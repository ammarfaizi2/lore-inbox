Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135814AbRDYGBF>; Wed, 25 Apr 2001 02:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135813AbRDYGA4>; Wed, 25 Apr 2001 02:00:56 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:1408 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S135814AbRDYGAl>;
	Wed, 25 Apr 2001 02:00:41 -0400
Date: Wed, 25 Apr 2001 00:12:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ignacio Monge <ignaciomonge@navegalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PIO disk writes using 100% system time and performing poorly with VIA vt82c686b on kernels 2.2 & 2.4
Message-ID: <20010425001236.A2888@suse.cz>
In-Reply-To: <20010424191941.5e719746.ignaciomonge@navegalia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010424191941.5e719746.ignaciomonge@navegalia.com>; from ignaciomonge@navegalia.com on Tue, Apr 24, 2001 at 07:19:41PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 07:19:41PM -0400, Ignacio Monge wrote:

> 	I have  VIA686a too and a UDMA100 hard disk.
> 	This is my cat /proc/ide/via:
> 
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     3.23
> South Bridge:                       VIA vt82c686a
> Revision:                           ISA 0x22 IDE 0x10
> Highest DMA rate:                   UDMA66
> BM-DMA base:                        0xb800
> PCI clock:                          33MHz
> -----------------------Primary IDE-------Secondary IDE------
> Enabled:                      yes                 yes
> Cable Type:                   40w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:        DMA      UDMA       PIO       PIO
> Address Setup:       30ns      30ns     120ns     120ns
> Cmd Active:          90ns      90ns     480ns     480ns
> Cmd Recovery:        30ns      30ns     480ns     480ns
> Data Active:         90ns      90ns     330ns     330ns
> Data Recovery:       30ns      30ns     270ns     270ns
> Cycle Time:         120ns      60ns     600ns     600ns
> Transfer Rate:   16.5MB/s  33.0MB/s   3.3MB/s   3.3MB/s
> 
> 	As you can see, l use UDMA66 instead UDMA100. 

You use UDMA33 dor your second drive and MWDMA16 for your first.
Check your BIOS UDMA enable settings.

> I don't know why. Maybe VIA vt82c686a doesn't support it?

Yes, it supports modes only up to 66 MB/sec.

> I have answering in this list a days ago about this problem. but none seems to have a question. Like you, my system goes down when I try to compile something (I have a 394 Mb of RAM and a 1 Ghz processor).
> 	Although, my hdparm output is this:
> 	/dev/hde2:
>  Timing buffer-cache reads:   128 MB in  0.79 seconds =162.03 MB/sec
>  Timing buffered disk reads:  64 MB in  2.44 seconds = 26.23 MB/sec
> 	and sometime looks better.

26 megabytes per second is quite surprising in your setup

> 	I don't know is this is a problem with the VIA kernel driver or not. But the system doesn't seem to work fine since 2.4.2 or 2.4.1 kernel. I hope (plz!) this problem will be fixed in future.

You can disable the VIA driver.

> 	PS: in cat /proc/ide/via I see "Cable Type:                   40w                 40w"... Is it right? I have a 80w cable, not 40.

Check your BIOS settings, if you have disabled UDMA in the BIOS, the
driver can't detect the cable. If that doesn't work, use "ide0=ata66"
on the kernel command line.

-- 
Vojtech Pavlik
SuSE Labs
