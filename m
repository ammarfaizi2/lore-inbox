Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWDVT1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWDVT1F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWDVT0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:26:38 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45243 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751060AbWDVTZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:25:58 -0400
Date: Sat, 22 Apr 2006 16:44:33 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] 'make headers_install' kbuild target.
Message-ID: <20060422144433.GE5010@stusta.de>
References: <1145672241.16166.156.camel@shinybook.infradead.org> <20060422093328.GM19754@stusta.de> <1145707384.16166.181.camel@shinybook.infradead.org> <20060422123835.GA5010@stusta.de> <1145710123.11909.241.camel@pmac.infradead.org> <20060422132032.GB5010@stusta.de> <1145712964.11909.258.camel@pmac.infradead.org> <20060422141134.GC5010@stusta.de> <1145715974.11909.272.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145715974.11909.272.camel@pmac.infradead.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2006 at 03:26:14PM +0100, David Woodhouse wrote:
> On Sat, 2006-04-22 at 16:11 +0200, Adrian Bunk wrote:
> > Sorry, but I'm not a fan of doing much more work than required instead 
> > of getting a consensus first and then implementing the solution.
> 
> It _isn't_ significantly more work. The _real_ work is in reading
> through the header files and deciding which parts should be private and
> which can be public, then splitting them up accordingly into separate
> files (or using 'ifdef __KERNEL__' if appropriate). That's the kind of
> thing that you seem particularly good at, which is why I've asked if you
> could help us with it.
> 
> Moving the public files from one directory to another, if they've been
> suitably marked or listed somewhere, is _trivial_. Even if you've used
> #ifdef __KERNEL__ it's simple enough to do it automatically with tools
> like unifdef. The _real_ work which requires human attention is the same
> either way.

The problem is you need #ifdef's everywhere.

If part of a header file is part of the userspace ABI, this often means 
that you need #ifdef __KERNEL__'s for the #include's of headers that 
will not be part of the userspace ABI (like linux/compiler.h).

And how do you express that in header foo.h, the userspace part requires 
the userspace part of bar.h, while the kernel-internal part of foo.h 
also requires the kernel-internal part of bar.h?

And reading through header files doesn't become easier after adding five 
#ifdef __KERNEL__'s to a header file.

> But if you're not willing to help, that's fine. I just thought you'd be
> particularly suited to the task, that's all.

I'm sorry, but I don't like your approach.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

