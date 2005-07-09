Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbVGIDDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbVGIDDb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 23:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbVGIDDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 23:03:31 -0400
Received: from mail.kroah.org ([69.55.234.183]:11188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263095AbVGIDDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 23:03:18 -0400
Date: Fri, 8 Jul 2005 20:02:04 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, kirk@braille.uwo.ca,
       linux-kernel@vger.kernel.org, speakup@braille.uwo.ca, gregkh@suse.de
Subject: Re: 2.6.13-rc2-mm1: some speakup nitpicks
Message-ID: <20050709030204.GA7974@kroah.com>
References: <20050707040037.04366e4e.akpm@osdl.org> <20050709020717.GQ3671@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709020717.GQ3671@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2005 at 04:07:18AM +0200, Adrian Bunk wrote:
> On Thu, Jul 07, 2005 at 04:00:37AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.13-rc1-mm1:
> >...
> > +gregkh-driver-speakup-docs.patch
> > +gregkh-driver-speakup-core.patch
> > 
> >  driver-core updates
> >...
> 
> These aren't driver-core updates, these are new drivers.

Yeah, sorry, I put them in my tree, in order for me to work on them.

> It seems I missed when this was sent for review to linus-kernel.

Heh, it's no where ready for such review, it needs a lot of cleanup.  I
did a lot of it about 12 months ago, but lost it somehow, don't want to
do that again...

I would not recommend reading the code just yet, unless you want to feel
ill...

> Some random nitpicks:
> 
> - SPEAKUP_DEFAULT shouldn't be asked if SPEAKUP=n
> - "make namespacecheck" shows tons of needlessly global code
> - the static variable special_handler is EXPORT_SYMBOL'ed
> - #define MIN should be removed
> - the file cvsversion.h only for keeping a CVS date is a bit
>   overkill
> - spk_con_module.h is not exactly how we use header files in the kernel
> - many of the #ifdef MODULE's point to things that could be done better
>   (especially the #include "mod_code.c"'s)
> - the things in synthlist.h could be done less ugly
> - speakupconf is a userspace script that belongs under Documentation/
> - dtload.c is not kernel code, and should therefore not be in that
>   directory
> - the code should follow Documentation/CodingStyle better
>   (no spaces between the braces and function arguments)
> - building speakup_keyhelp.c modular even in a kernel that doesn't
>   support modules is silly
> - #include <linux/...> belongs before #include <asm/...>

Yes, that's just the start of what needs to be done.  But I like it in
the -mm tree for now to at least give it wider testing to users who rely
on this hardware in order to have access to their machines.  I'll be
slowly working on it over the next month or so to fix these issues and
the placement of where it hooks into the main kernel.  Then I will
submit the driver for review by all of lkml.  I will not send it to
Linus until everyone agrees that it is acceptable.

thanks,

greg k-h
