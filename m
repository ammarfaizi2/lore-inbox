Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277089AbRJKX41>; Thu, 11 Oct 2001 19:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277093AbRJKX4X>; Thu, 11 Oct 2001 19:56:23 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:27147 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277089AbRJKX4M>;
	Thu, 11 Oct 2001 19:56:12 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unconditional include of <linux/module.h> in aic7xxx driver 
In-Reply-To: Your message of "Thu, 11 Oct 2001 13:40:08 CST."
             <200110111940.f9BJe8Y97938@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Oct 2001 09:56:34 +1000
Message-ID: <32281.1002844594@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2001 13:40:08 -0600, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>Can anyone comment on why the include of <linux/module.h> is now
>unconditional in the aic7xxx driver?  Assuming MODULE_LICENSE is
>properly qualified by an #ifdef MODULE, the driver appears to compile
>and function correctly without this include.  Are MODULE attributes
>(MODULE_VERSION/AUTHOR/DESCRIPTION/etc.) now supposed to be included in
>static configurations?

Absolutely.  module.h detects how the code is being compiled and most
of the macros become noops.  In 2.5 MODULE_PARM will have meaning even
for code built into the kernel, so we get a consistent method of
setting parameters without adding boot line parsing code to every
object.

Always include module.h, never condition MODULE_xxx on CONFIG_MODULES,
init and exit functions should be defined as __init and __exit and
referenced via module_init() and module_exit().  init.h and module.h
will do whatever is necessary, depending on how the code is compiled.

