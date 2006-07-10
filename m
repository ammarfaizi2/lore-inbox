Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWGJPWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWGJPWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWGJPWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:22:00 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42762 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1422661AbWGJPV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:21:58 -0400
Date: Mon, 10 Jul 2006 16:21:47 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       "H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Clean up old names in tty code to current names
Message-ID: <20060710152146.GA18728@flint.arm.linux.org.uk>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Jon Smirl <jonsmirl@gmail.com>,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <1152524657.27368.108.camel@localhost.localdomain> <9e4733910607100541i744dd744n16c35c50dae1e98d@mail.gmail.com> <1152537049.27368.119.camel@localhost.localdomain> <9e4733910607100603r5ae1a21ex1a2fa0f045424fd1@mail.gmail.com> <1152539034.27368.124.camel@localhost.localdomain> <9e4733910607100707g4810a86boa93a5b6b0b1a8d0a@mail.gmail.com> <44B26752.9000507@gmail.com> <9e4733910607100757t4ddfaf93l1723580de551529b@mail.gmail.com> <1152544746.27368.134.camel@localhost.localdomain> <200607101510.k6AFAWND006142@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607101510.k6AFAWND006142@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 11:10:32AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 10 Jul 2006 16:19:06 BST, Alan Cox said:
> > Ar Llu, 2006-07-10 am 10:57 -0400, ysgrifennodd Jon Smirl:
> > > > A few apps do rely on /proc/tty/drivers for the major-minor
> > > > to device name mapping. /dev/vc/0 does not exist (unless
> > > > created manually) without devfs.
> > > 
> > > This is why I questioned if /proc/tty was really in use, it contains
> > > an entry that is obviously wrong for my system.
> > 
> > Which tools already know about. What is so hard to understand about the
> > idea that pointless random changes break stuff and don't fix things.
> 
> On the other hand, a case can be made that if userspace already knows about
> the fact the thing is totally broken

Maybe - what if userspace is looking up /dev/tty0 in /proc/tty/drivers
and happens to know that it's called /dev/vc/0, because it's working
around this known idiosyncrasy of the kernel ?  If you change tty/drivers
to be the more correct /dev/tty0, such a program would needlessly break.

> fixing it won't break anything.

How can you be certain - I think that's Alan's point (if it isn't,
that's my point.)  The answer is you can't, so in order to maintain
ABI compatibility (and yes, this *IS* part of the kernel ABI) it
must be left exactly as-is.

> The only case is that some *already* terminally broken stuff may break
> further.

That "terminally broken stuff" might just happen to work with today's
kernels.  Even so, that's no reason to pile in additional user-visible
changes which could potentially have adverse effects.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
