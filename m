Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264719AbSJ3PxB>; Wed, 30 Oct 2002 10:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264720AbSJ3PxB>; Wed, 30 Oct 2002 10:53:01 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:32657 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264719AbSJ3PxA>;
	Wed, 30 Oct 2002 10:53:00 -0500
Date: Wed, 30 Oct 2002 16:59:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org, "Zephaniah E. Hull" <warp@mercury.d2dc.net>
Subject: Re: [patch] Problem with mousedev.c
Message-ID: <20021030165922.A12505@ucw.cz>
References: <20021027010538.GA1690@babylon.d2dc.net> <20021028184008.B32183@ucw.cz> <20021030153257.GA27585@babylon.d2dc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021030153257.GA27585@babylon.d2dc.net>; from warp@mercury.d2dc.net on Wed, Oct 30, 2002 at 10:32:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 10:32:57AM -0500, Zephaniah E. Hull wrote:
> On Mon, Oct 28, 2002 at 06:40:08PM +0100, Vojtech Pavlik wrote:
> > On Sat, Oct 26, 2002 at 09:05:38PM -0400, Zephaniah E. Hull wrote:
> > > To make a long story short, mousedev.c does not properly implement the
> > > EXPS/2 protocol, specificly dealing with the wheel.
> > > 
> > > The lower 8 bits of the 4th byte are supposed to be 0x1 or 0xf to
> > > indicate movement of the first wheel, and 0x2 or 0xe for the second
> > > wheel.
> > 
> > No, see microsoft documentation. They're expected to be a 4-bit signed
> > binary complement value that indicates the amount of movement.
> 
> After some poking, two questions.
> 
> The first is the URL for the documentation in question? This seems
> inconsistent with what I remember reading in the past, but can't seem to
> find anymore.
> 
> The second is if you have actually seen hardware which /actually/
> generates the wheel data described while speaking exps2?
> > 
> > > Attached is a patch to correct this.
> > > 
> > > This does not get my two wheel mouse working perfectly yet, sadly that
> > > will take a bit of a hack, and I'm not sure where the best place to put
> > > it is yet, but this gets it back to generating correct data.
> > 
> > PS/2 A4-Tech mouse do the ugly trick you describe above to stuff two
> > wheel information into a single-wheel oriented ImExPS/2 protocol. USB
> > A4-Tech mouse do another ugly trick (additional button which specifies
> > which wheel is rotating). I'm not interested in supporting these ugly
> > tricks.
> 
> Sadly, if PS/2 mice are any indication, mouse makers /will/ manage to
> fuck things up on enough popular mice under USB as well, and there needs
> to be a place to shove the dirty hacks needed to make things Just Work
> for users..

That place would be hid-input.c and psmouse.c. NOT mousedev.c.

> At least with USB stuff we can /identify/ the damn things, which means
> that we are leaps and bounds ahead of where we are for PS2 stuff.
> > 
> > If you want to support the H-Wheel in GPM, then please add
> > /dev/input/event support into GPM. (simple patch attached, you may need
> > to do more changes, namely for h-wheel).
> 
> Thanks, my next gpm upload should include it, now to get support for the
> same for X.. (Arrgh, X hacking is even lower on my list of things to do
> then kernel hacking is. Probably because I've done more of it.)

-- 
Vojtech Pavlik
SuSE Labs
