Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130793AbRCTVdy>; Tue, 20 Mar 2001 16:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRCTVdp>; Tue, 20 Mar 2001 16:33:45 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:788 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S130793AbRCTVda>; Tue, 20 Mar 2001 16:33:30 -0500
Date: Tue, 20 Mar 2001 16:32:48 -0500 (EST)
From: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <20010320202020Z130768-406+2207@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1       932   7486258+   b  Win95 FAT32
> /dev/hda2           933      3737  22531162+   5  Extended
> /dev/hda5           933       935     24066   83  Linux
> /dev/hda6           936       952    136521   82  Linux swap
> /dev/hda7           953      3737  22370481   83  Linux
> 
> 
> I also ran hdparm -tT /dev/hda1:
>  
> Timing buffer-cache reads:   128 MB in  1.28 seconds =100.00 MB/sec
>  Timing buffered disk reads:  64 MB in  4.35 seconds = 14.71 MB/sec
> 
> Which obviously gives much the same result as my usual hdparm -tT /dev/hda
> 
> I then tried hdparm -tT /dev/hda7:
> 
>  Timing buffer-cache reads:   128 MB in  1.28 seconds =100.00 MB/sec
>  Timing buffered disk reads:  64 MB in  2.12 seconds = 30.19 MB/sec
> 
> As you would expect, I get almost identical results with several repetitions.
> 
> Does this solve the mystery ?

no, it's quite odd.  hdparm -t cannot be effected by the filesystem
that lives in the partition, since hdparm is doing reads that don't
go through the filesystem.  hmm, I wonder if that's it: if you mount
the FS that's in hda1, it might change the block driver configuration
(changing the blocksize, for instance).  that would effect hdparm,
even though its reads don't go through the FS.

prediction: if you comment out the hda1 line in fstab, and reboot,
so that vfat never gets mounted on that partition, I predict that 
hdparm will show >30.19 MB/s on it.

