Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131265AbRANI4H>; Sun, 14 Jan 2001 03:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131581AbRANIz5>; Sun, 14 Jan 2001 03:55:57 -0500
Received: from styx.suse.cz ([195.70.145.226]:58362 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S131265AbRANIzr>;
	Sun, 14 Jan 2001 03:55:47 -0500
Date: Sun, 14 Jan 2001 09:55:43 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: TimO <hairballmt@mcn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide.2.4.1-p3.01112001.patch
Message-ID: <20010114095543.C365@suse.cz>
In-Reply-To: <20010112212427.A2829@suse.cz> <Pine.LNX.4.10.10101121604080.8097-100000@penguin.transmeta.com> <20010113150046.E1155@suse.cz> <3A611FCC.931D8CA0@mcn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A611FCC.931D8CA0@mcn.net>; from hairballmt@mcn.net on Sat, Jan 13, 2001 at 08:41:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 13, 2001 at 08:41:00PM -0700, TimO wrote:

> > Note that with this patch, all VIA users will get IDE transferrates
> > about 3 MB/sec as opposed to about 20 MB/sec without it (and with
> > UDMA66).
> > 
> > Also note that enabling the DMA later with hdparm -X66 -d1 or similar
> > command is not safe, and usually works by pure luck on VIA chipsets.
> > This however, would need some non-minor changes to the generic code to
> > fix.
> 
> _ouch_  Will -X66 -d1c1m16 be as stable with this patch as version 2.1e
> has been for me??  It has always (auto)set transfer speeds properly and
> I have never seen corruption with my 686a -- 'cept when patching from
> test11-pre7 to test12-pre1, and I'm pretty sure that was from other
> factors.

Well, can't tell. For some reason hdparm doesn't tell the VIA driver to
update the timings in the chipset when changing modes. The fact that
UDMA will start to work after this command is only due to that the VIA
chips do have a built in filter for UDMA commands, notice the command
sent to the harddrive, and switch the UDMA mode on. However the timings
stay as were, as perhaps the BIOS set them up. So it may work or may
not. 

As I said, getting it to work reliably needs changes in the generic code
(hdparm should call the correct ioctl, and the ioctl must call the
timing routine in the specific chipset code).

If the patch I sent to Linus gets applied, I'll probably submit another
one that will allow to override the no-dma rule by a kernel command line
option, as Alan Cox suggested.

-- 
Vojtech Pavlik
SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
