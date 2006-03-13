Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbWCMUCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbWCMUCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWCMUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 15:02:05 -0500
Received: from flex.com ([206.126.0.13]:53008 "EHLO flex.com")
	by vger.kernel.org with ESMTP id S932412AbWCMUCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 15:02:03 -0500
From: Marr <marr@flex.com>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()'
Date: Mon, 13 Mar 2006 15:01:38 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       Linda Walsh <lkml@tlinx.org>, Bill Davidsen <davidsen@tmr.com>,
       marr@flex.com, Hans Reiser <reiser@namesys.com>
References: <200603131437.50461.a1426z@gawab.com>
In-Reply-To: <200603131437.50461.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603131501.38803.marr@flex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 March 2006 6:37am, Al Boldi wrote:
> Marr wrote:
> > The 2.6.13 kernel on ReiserFS (without using
> > 'nolargeio=1' as a mount option) still takes about 4m35s to fseek 200,000
> > times on that 4MB file, even with 'hdparm -a0 /dev/hda' in effect.
>
> try this magic number:
>
>         echo 192 > /sys/block/hda/queue/max_sectors_kb
>         echo 192 > /sys/block/hda/queue/read_ahead_kb
>
> Anything outside 132-255 affects throughput negatively.

I tried this, but it seems that neither of these settings will take any value 
over 128 (which is what they both started at before I tried to change them). 
It seems that I can set values _lower_ than 128, but nothing higher (stock 
Slackware 10.2 2.6.13 kernel).

> Also, can you dump hdparm -I /dev/hda?

Sure. Here's the results:

----------------------------------------

/dev/hda:

ATA device, with non-removable media
	Model Number:       TOSHIBA MK2023GAS                       
	Serial Number:      54594043T
	Firmware Revision:  MB001A  
Standards:
	Supported: 5 4 3 2 
	Likely used: 6
Configuration:
	Logical		max	current
	cylinders	16383	16383
	heads		16	16
	sectors/track	63	63
	--
	CHS current addressable sectors:   16514064
	LBA    user addressable sectors:   39070080
	device size with M = 1024*1024:       19077 MBytes
	device size with M = 1000*1000:       20003 MBytes (20 GB)
Capabilities:
	LBA, IORDY(can be disabled)
	bytes avail on r/w long: 48	Queue depth: 1
	Standby timer values: spec'd by Standard, no device specific minimum
	R/W multiple sector transfer: Max = 16	Current = ?
	Advanced power management level: unknown setting (0x0080)
	DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 
	     Cycle time: min=120ns recommended=120ns
	PIO: pio0 pio1 pio2 pio3 pio4 
	     Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
	Enabled	Supported:
	   *	NOP cmd
	   *	READ BUFFER cmd
	   *	WRITE BUFFER cmd
	   *	Host Protected Area feature set
	   *	Look-ahead
	   *	Write cache
	   *	Power Management feature set
		Security Mode feature set
		SMART feature set
	   *	Mandatory FLUSH CACHE command 
	   *	Device Configuration Overlay feature set 
		SET MAX security extension
	   *	Advanced Power Management feature set
	   *	SMART self-test 
	   *	SMART error logging 
Security: 
	Master password revision code = 65534
		supported
	not	enabled
	not	locked
		frozen
	not	expired: security count
	not	supported: enhanced erase
	24min for SECURITY ERASE UNIT. 
HW reset results:
	CBLID- above Vih
	Device num = 0 determined by the jumper
Checksum: correct

----------------------------------------

I don't think anyone is implying this, but for the record, this problem is not 
peculiar to this particular hard disk drive. I seem to see the problem on any 
2.6.x kernel with a ReiserFS filesystem that has _not_ enabled the 
(undocumented, as near as I can see) 'nolargeio=1' option on the mount.

Also, I haven't heard anything more after Hans Reiser queried Ulrich Drepper 
about the 'glibc' angle on this problem, so I'm wondering if there's been any 
progress on that front. Oh, I just noticed that Hans has re-pinged Ulrich on 
this issue -- thanks, Hans!

Anway, as always, thanks to all who've contributed to this thread.

*** Please CC: me on replies -- I'm not subscribed.

Regards,
Bill Marr
