Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRC0N1v>; Tue, 27 Mar 2001 08:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131292AbRC0N1l>; Tue, 27 Mar 2001 08:27:41 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37258 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131290AbRC0N1e>;
	Tue, 27 Mar 2001 08:27:34 -0500
Message-ID: <3AC0951D.3C02A5F2@mandrakesoft.com>
Date: Tue, 27 Mar 2001 08:26:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Compile-time versus run-time
In-Reply-To: <3ABF2F8E.B212A96B@uow.edu.au> <9186.985698979@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Andrew Morton wrote:
> > CONFIG_8139TOO_TUNE_TWISTER
> > (And wouldn't it be nice to be able to get the same functionality
> > which module options give us when using a statically linked driver?)
> 
> On my todo list for 2.5.  MODULE_PARM will be promoted to
> module_name.parm when the object is built in.  insmod foo debug=1 or
> boot with foo.debug=1.  It needs a mapping of source to module which is
> not easy to get for multi object modules in 2.4, my 2.5 makefile
> rewrite will make it easy.

(redirect to lkml)

Making MODULE_PARM work when compiled in will be nice, but I see two
flaws right off:

* passing multiple module parms is wasteful, because the module prefix
must be repeated for each argument.  That strains cmdline limits (80
chars in boot environments)  IMHO we can do better than that.

* There are cases where you do not want MODULE_PARM options appearing as
__setup, just like there are cases where options passed to __setup do
not belong as a MODULE_PARM.  You should not unconditionally make
MODULE_PARM available on the kernel command line, even though that is
the simple solution.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
