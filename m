Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316593AbSFGCIc>; Thu, 6 Jun 2002 22:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSFGCIb>; Thu, 6 Jun 2002 22:08:31 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:38001 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316593AbSFGCIa>; Thu, 6 Jun 2002 22:08:30 -0400
Date: Fri, 7 Jun 2002 04:08:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa1
Message-ID: <20020607020839.GM1004@dualathlon.random>
In-Reply-To: <20020607003413.GH1004@dualathlon.random> <3D001363.BDEBD682@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 06:58:59PM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > Only in 2.4.19pre10aa1: 90_ext3-commit-interval-1
> > 
> >         Avoid laptops to waste energy despite kupdate interval is set
> >         to 2 hours with ext3. kjournald has no right to choose
> >         "how frequently" we should look for old transactions, that's
> >         an user problem. journaling doesn't enforce how much old data
> >         we can lose after a 'reboot -f', it only enforces that the
> >         metadata or even the data will be coherent after an hard reboot.
> 
> Yes, that'll work OK.   It's a wild implementation though.  Why not
> just add
> 
> int bdflush_min(void)
> {
> 	return bdf_prm.b_un.interval;
> }
> EXPORT_SYMBOL(bdflush_min);

well, that's not bdflush_min, that would be better called
bdflush_interval like I did in my patch, the bdflush_min is confusing
with the min values for the bdf_prm. btw, my way is actually some cycle
faster than the above, I don't like very much gratuiotus wasted cycles
with no gain in design. It's just the c++ cycle-wasteful mania that
everything is a method and that data sturctures have to be hidden and
not to be seen. But here I don't see any real gain to hide the
internals, such a data structure is basically known even from userspace.

> 
> to fs/buffer.c?
> 
> (You forgot to export bdf_prm, btw).

to export to modules, right, I don't use it as module so I didn't
noticed. Oh well, it's too late now to update. I will upload a new one
tomorrow if I find the time or it will wait one week.

thanks for noticing,

Andrea
