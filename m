Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbREXMJB>; Thu, 24 May 2001 08:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261687AbREXMIv>; Thu, 24 May 2001 08:08:51 -0400
Received: from juicer34.bigpond.com ([139.134.6.86]:40674 "EHLO
	mailin9.bigpond.com") by vger.kernel.org with ESMTP
	id <S261679AbREXMIk>; Thu, 24 May 2001 08:08:40 -0400
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au>
	<200105240658.f4O6wEWq031945@webber.adilger.int>
	<20010524103145.A9521@gruyere.muc.suse.de>
	<20010524121936.I12470@suse.de>
From: monkeyiq <monkeyiq@users.sourceforge.net>
X-Home-Page: http://witme.sourceforge.net
Date: 24 May 2001 22:08:30 +1000
In-Reply-To: Jens Axboe's message of "Thu, 24 May 2001 12:19:36 +0200"
Message-ID: <m3eltfymo1.fsf@kloof.cr.au>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Thu, May 24 2001, Andi Kleen wrote:
> > On Thu, May 24, 2001 at 12:58:14AM -0600, Andreas Dilger wrote:
> > > Well reiserfs is probably a very bad choice at this point.  It
> > > does not have any bad blocks support (yet), so as soon as you have
> > > a bad block you are stuck.
> > 
> > reiserfs doesn't, but the HD usually has transparently in its firmware.
> > So it hits a bad block; you see an IO error and the next time you hit
> > the block the firmware has mapped in a fresh one from its internal
> > reserves.
> 
> In fact you will typically only see an I/O error if the drive _can't_
> remap the sector anymore, because it has run out. No point in reporting
> a condition that was recovered.
> 
> I'd still say, that if you get bad block errors reported from your disk
> it's long overdue for replacement.
> 
> -- 
> Jens Axboe

Well, I have been fighting this for a while now, its just that today it
finally hit /home in a big way :( basically its giving a DoS trying 
to compile stuff (which needs to write 25Mb+ library files)

The drive gives the patented IBM "replace me" audio and the kernel graces
me with these little chums:

May 24 14:50:22 kloof kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
May 24 14:50:22 kloof kernel: hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=78294495, sector=957496
May 24 14:50:22 kloof kernel: end_request: I/O error, dev 03:08 (hda), sector 957496
May 24 14:50:22 kloof kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
May 24 14:50:23 kloof kernel: hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=78294495, sector=957504
May 24 14:50:23 kloof kernel: end_request: I/O error, dev 03:08 (hda), sector 957504
May 24 14:50:23 kloof kernel: hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
May 24 14:50:23 kloof kernel: hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=78294495, sector=957512

I already knew that the drive was rooted by using the IBM DFT tool.
I am backing up as I type. Then, roll the dice with yet another 
IBM drive :-/
 

-- 
---------------------------------------------------
It's the question, http://witme.sourceforge.net
If you think education is expensive, try ignorance.
		-- Derek Bok, president of Harvard

