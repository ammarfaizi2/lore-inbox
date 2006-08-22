Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWHVQHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWHVQHm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 12:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751405AbWHVQHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 12:07:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16907 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751404AbWHVQHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 12:07:41 -0400
Date: Tue, 22 Aug 2006 18:07:41 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
Message-ID: <20060822160741.GB11651@stusta.de>
References: <20060821215641.GQ11651@stusta.de> <20060822022012.GA7070@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822022012.GA7070@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 10:20:12PM -0400, Jeff Dike wrote:
> On Mon, Aug 21, 2006 at 11:56:41PM +0200, Adrian Bunk wrote:
> > arch/um/sys-i386/setjmp.S contains two #ifdef _REGPARM's.
> > 
> > Even if regparm was used in i386 uml (which isn't currently done (why?)),
> > I don't see _REGPARM being defined anywhere.
> 
> setjmp.S was stolen from klibc, and I'd just as soon leave it alone and
> not try to customize it for UML.  That file will disappear if/when klibc 
> is in mainline, and I can just pull it in from usr.

Ah, klibc defines _REGPARM if required.

> In general, there's no reason that regparam can't be used for UML.  However,
> in the past (I don't know if it's still a problem) gcc miscompiled regparam
> code in the presence of -pg.

I didn't find a corresponding open bug in the gcc Bugzilla.

Can someone verify whether it's still present, and if yes, open a gcc 
bug?

> As for why it's not, I don't see any occurences of regparam in include/linux
> or include/asm-i386 either.

It's set globally in arch/i386/Makefile:
  cflags-$(CONFIG_REGPARM) += -mregparm=3

That's not pulled by UML, but if there are no outstanding problems with 
regparm, we could both enable it uncomditionally on i386 and enable it
on UML/i386.

> > Is this a bug waiting for happening when regparm will be used on uml or 
> > do I miss anything?
> 
> Probably not.
> 
> 				Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

