Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131296AbRC0OHX>; Tue, 27 Mar 2001 09:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131297AbRC0OHN>; Tue, 27 Mar 2001 09:07:13 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:34323 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131296AbRC0OG7>;
	Tue, 27 Mar 2001 09:06:59 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compile-time versus run-time 
In-Reply-To: Your message of "Tue, 27 Mar 2001 08:26:53 EST."
             <3AC0951D.3C02A5F2@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Mar 2001 00:06:11 +1000
Message-ID: <9615.985701971@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001 08:26:53 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Making MODULE_PARM work when compiled in will be nice, but I see two
>flaws right off:
>
>* passing multiple module parms is wasteful, because the module prefix
>must be repeated for each argument.  That strains cmdline limits (80
>chars in boot environments)  IMHO we can do better than that.

Implementation detail.  module.{opt1=value opt2=value} will save some
space but the module name is still required, multiple objects use
variable names like io and irq.

>* There are cases where you do not want MODULE_PARM options appearing as
>__setup, just like there are cases where options passed to __setup do
>not belong as a MODULE_PARM.  You should not unconditionally make
>MODULE_PARM available on the kernel command line, even though that is
>the simple solution.

I'm not convinced that we need a distinction.  If you can specify a
parameter as a module you can specify it at boot time.  If there are
any cases where the parameter makes no sense at boot time, the code can
ignore any value when it is compiled for built in mode.

In any case it must be a gradual conversion.  A lot of code has #ifdef
MODULE around the parameter identifiers, #ifdef must be removed to use
both methods, otherwise you get undefined variables.  So only modules
that are compiled with a new flag will get the feature.  Later in the
2.5 cycle the common parameter handling will become the default.

