Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263402AbTCNR42>; Fri, 14 Mar 2003 12:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbTCNR42>; Fri, 14 Mar 2003 12:56:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35475 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263402AbTCNR4V>;
	Fri, 14 Mar 2003 12:56:21 -0500
Date: Fri, 14 Mar 2003 19:07:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.64-mm6: oops in elv_remove_request
Message-ID: <20030314180716.GZ791@suse.de>
References: <1047576167.1318.4.camel@ixodes.goop.org> <20030313175454.GP836@suse.de> <1047578690.1322.17.camel@ixodes.goop.org> <20030313190247.GQ836@suse.de> <1047633884.1147.3.camel@ixodes.goop.org> <20030314104219.GA791@suse.de> <1047637870.1147.27.camel@ixodes.goop.org> <20030314113732.GC791@suse.de> <1047664774.25536.47.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047664774.25536.47.camel@ixodes.goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 14 2003, Jeremy Fitzhardinge wrote:
> On Fri, 2003-03-14 at 03:37, Jens Axboe wrote:
> > Can you send me the output of -prcap?
> 
> # cdrecord -prcap
> Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.7'
> Device type    : Removable CD-ROM
> Version        : 2
> Response Format: 2
> Capabilities   :
> Vendor_info    : 'PLEXTOR '
> Identifikation : 'CD-R   PX-W4824A'
> Revision       : '1.04'
> Device seems to be: Generic mmc CD-RW.
> 
> Drive capabilities, per MMC-3 page 2A:
> 
>   Does read CD-R media
>   Does write CD-R media
>   Does read CD-RW media
>   Does write CD-RW media
>   Does not read DVD-ROM media
>   Does not read DVD-R media
>   Does not write DVD-R media
>   Does not read DVD-RAM media
>   Does not write DVD-RAM media
>   Does support test writing
> 
>   Does read Mode 2 Form 1 blocks
>   Does read Mode 2 Form 2 blocks
>   Does read digital audio blocks
>   Does restart non-streamed digital audio reads accurately
>   Does support Buffer-Underrun-Free recording
>   Does read multi-session CDs
>   Does read fixed-packet CD media using Method 2
>   Does not read CD bar code
>   Does read R-W subcode information
>   Does return R-W subcode de-interleaved and error-corrected
>   Does read raw P-W subcode data from lead in
>   Does return CD media catalog number
>   Does return CD ISRC information
>   Does support C2 error pointers
>   Does deliver composite A/V data
> 
>   Does play audio CDs
>   Number of volume control levels: 256
>   Does support individual volume control setting for each channel
>   Does support independent mute setting for each channel
>   Does not support digital output on port 1
>   Does not support digital output on port 2
> 
>   Loading mechanism type: tray
>   Does support ejection of CD via START/STOP command
>   Does not lock media on power up via prevent jumper
>   Does allow media to be locked in the drive via PREVENT/ALLOW command
>   Is not currently in a media-locked state
>   Does not support changing side of disk
>   Does not have load-empty-slot-in-changer feature
>   Does not support Individual Disk Present feature
> 
>   Maximum read  speed:  7056 kB/s (CD  40x, DVD  5x)
>   Current read  speed:  7056 kB/s (CD  40x, DVD  5x)
>   Maximum write speed:  8467 kB/s (CD  48x, DVD  6x)
>   Current write speed:  8467 kB/s (CD  48x, DVD  6x)
>   Rotational control selected: CLV/PCAV
>   Buffer size in KB: 4096
>   Copy management revision supported: 0
>   Number of supported write speeds: 8
>   Write speed # 0:  8467 kB/s CLV/PCAV (CD  48x, DVD  6x)
>   Write speed # 1:  7056 kB/s CLV/PCAV (CD  40x, DVD  5x)
>   Write speed # 2:  5645 kB/s CLV/PCAV (CD  32x, DVD  4x)
>   Write speed # 3:  4234 kB/s CLV/PCAV (CD  24x, DVD  3x)
>   Write speed # 4:  3528 kB/s CLV/PCAV (CD  20x, DVD  2x)
>   Write speed # 5:  2822 kB/s CLV/PCAV (CD  16x, DVD  2x)
>   Write speed # 6:  1411 kB/s CLV/PCAV (CD   8x, DVD  1x)
>   Write speed # 7:   706 kB/s CLV/PCAV (CD   4x, DVD  0x)
> 
> 
> But... When I first ran -checkdrive this morning, it gave me good
> results:
> 
> # cdrecord -checkdrive
> Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.7'
> Device type    : Removable CD-ROM
> Version        : 2
> Response Format: 2
> Capabilities   :
> Vendor_info    : 'PLEXTOR '
> Identifikation : 'CD-R   PX-W4824A'
> Revision       : '1.04'
> Device seems to be: Generic mmc CD-RW.
> Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
> Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC
> Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
> 
> But immediately afterwards:
> 
> # cdrecord -checkdrive
> Cdrecord 2.01a05 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> scsidev: '/dev/hdc'
> devname: '/dev/hdc'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.
> Linux sg driver version: 3.5.27
> Using libscg version 'schily-0.7'
> Device type    : Removable CD-ROM
> Version        : 0
> Response Format: 1
> Vendor_info    : 'PLEXTOR '
> Identifikation : 'CD-R   PX-W4824A'
> Revision       : '1.04'
> Device seems to be: Generic mmc CD-RW.
> Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
> Driver flags   : MMC-3 SWABAUDIO BURNFREE VARIREC
> Supported modes:
> 
> Ejecting and reinserting the disc seems to restore things:

Really weird, I can't reproduce here at all. My drive gives the correct
result no matter if it's empty or loaded. Results are repeatable, too.
DMA or PIO, didn't matter.

> Notice the "version" and "response format" fields have changed.

Yeah, something is really screwed. Hmmm, let spend a bit of time with
this problem...

-- 
Jens Axboe

