Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129562AbRCBWHw>; Fri, 2 Mar 2001 17:07:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRCBWHd>; Fri, 2 Mar 2001 17:07:33 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:8964 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129584AbRCBWHD>;
	Fri, 2 Mar 2001 17:07:03 -0500
Date: Thu, 1 Mar 2001 12:12:11 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Moyle <bmoyle@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac6 hangs on boot w/AMD Elan SC520 dev board
Message-ID: <20010301121210.B34@(none)>
In-Reply-To: <200102280312.TAA13404@bia.mvista.com> <E14Y539-0005XE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14Y539-0005XE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 28, 2001 at 11:45:40AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >     bios-e820: 000000000009f400 @ 0000000000000000 (usable)
> >     bios-e820: 0000000000000c00 @ 000000000009f400 (reserved)
> >     bios-e820: 0000000003f00000 @ 0000000000100000 (usable)
> >     bios-e820: 0000000003f00000 @ 0000000000100000 (usable)
> >     bios-e820: 0000000000100000 @ 00000000fff00000 (reserved)
> >    (at this point, it appears to be in an infinite printk loop <?>)
> > 
> > I didn't spend much time looking into the printk loop, but it seems to 
> > end up there, even if CONFIG_DEBUG_BUGVERBOSE is not defined, as if the 
> > ".byte 0x0f,0x0b" is causing the loop to begin.
> > 
> > Any ideas/suggestions/comments?
> 
> Having been over the code the problem is indeed the bios reporting overlapping
> /duplicated ranges. That will cause a crash in mm/bootmem when we try and free
> the range twice.
> 
> I suspect you need to add some code to take the E820 map and remove any
> overlaps from it, favouring ROM over RAM if the types disagree (for safety),
> and filter them before you register them with the bootmem in 
> arch/i386/kernel/setup.c

...plus prining ?@#@&#&$ BIOS reports invalid mem map
seems like good idea, so that bios bugs are fixed.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

