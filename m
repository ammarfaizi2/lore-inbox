Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423860AbWKPMjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423860AbWKPMjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 07:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423863AbWKPMjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 07:39:03 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:33293 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423860AbWKPMi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 07:38:56 -0500
Date: Thu, 16 Nov 2006 12:38:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061116123849.GB28311@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Alan <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <200611122047.kACKl8KP004895@harpo.it.uu.se> <20061112212941.GA31624@flint.arm.linux.org.uk> <20061112220318.GA3387@elte.hu> <20061112235410.GB31624@flint.arm.linux.org.uk> <20061114110958.GB2242@elf.ucw.cz> <1163522062.14674.3.camel@mindpipe> <20061115202418.GC3875@elf.ucw.cz> <20061115204915.1d0717db@localhost.localdomain> <20061115204933.GD3875@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115204933.GD3875@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2006 at 09:49:33PM +0100, Pavel Machek wrote:
> > > > > Suspending with mounted floppy is a user error.
> > > > 
> > > > Huh?  How so?
> > > 
> > > Floppy is removable, and you are expected to umount removable devices
> > > before suspend.
> > 
> > That seems pretty crude. There are lots of cases where an apparently
> > removable device is/should be preserved properly and left mounted (eg
> > builtin CF).
> > 
> > We really want to be smarter than that - which means the drivers ought to
> > be doing stuff in their suspend/resume paths to figure out if the media
> > changed when really possible (eg IDE removable)
> > 
> > Floppy is probably not too fixable, but calling it a "user error" is
> > insulting - user expectation is reasonable that suspend/resume should
> > just work. The implementation is just rather trickier/nonsensical in this
> > case.
> 
> Yep, it would be nice to do something about that; but I'm not sure how
> this "was media changed" should be implemented, and if it should be
> done in kernel or in userland.

With a floppy the only way to do that is to read data off the disk and
compare it with what we know was on the disk prior to suspend/resume.

Since we don't have a "standard floppy format" (since we're flexible)
you can't rely on MSDOS boot sectors and the like to uniquely identify
floppy disks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
