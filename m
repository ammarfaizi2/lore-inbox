Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUAHLCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUAHLCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:02:37 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:22666 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S264275AbUAHLCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:02:35 -0500
Date: Thu, 8 Jan 2004 12:01:42 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: Performance drop 2.6.0-test7 -> 2.6.1-rc2
Message-ID: <20040108120142.A29178@fi.muni.cz>
References: <20040107023042.710ebff3.akpm@osdl.org> <20040107215240.GA768@frodo> <20040108105427.E20265@fi.muni.cz> <20040108021637.15d1b33a.akpm@osdl.org> <20040108112547.G20265@fi.muni.cz> <20040108023356.00db9dec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040108023356.00db9dec.akpm@osdl.org>; from akpm@osdl.org on Thu, Jan 08, 2004 at 02:33:56AM -0800
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
: 
: It would be interesting to run some simple benchmarks (dbench, iozone,
: tiobench, etc) on a relatively idle system.
: 
	I will try to do, but it is hard to get a "relatively idle" system.

: After that, it'd be a matter of searching through kernel versions, which
: you presumably cannot do.  Or eliminating device mapper from the picture,
: which is also presumably not an option.
: 
	I'll try to walk between kernel versions, but I cannot reboot this
machine too often ...
: 
: Have you run `hdparm' to check that all those disks have DMA enabled?  I
: guess they have.
: 
	No, I did not run hdparm, but the kernel messages from
2.6.1-rc2 were:

Jan  6 17:05:06 odysseus kernel: Linux version 2.6.1-rc2 (root@atlas) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r3, propolice)) #1 Tue Jan 6 16:47:51 CET 2004
[...]
Jan  6 17:05:09 odysseus kernel: hda: 40011300 sectors (20485 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(66)
Jan  6 17:05:09 odysseus kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Jan  6 17:05:09 odysseus kernel: hde: max request size: 64KiB
Jan  6 17:05:09 odysseus kernel: hde: 150136560 sectors (76869 MB) w/1916KiB Cache, CHS=65535/16/63, UDMA(100)
Jan  6 17:05:09 odysseus kernel:  hde: hde1 hde2 hde3
Jan  6 17:05:09 odysseus kernel: hdh: max request size: 64KiB
Jan  6 17:05:09 odysseus kernel: hdh: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Jan  6 17:05:09 odysseus kernel:  hdh: hdh1 hdh2 hdh3
Jan  6 17:05:09 odysseus kernel: hdi: max request size: 1024KiB
Jan  6 17:05:09 odysseus kernel: hdi: 361882080 sectors (185283 MB) w/7965KiB Cache, CHS=22526/255/63, UDMA(100)
Jan  6 17:05:09 odysseus kernel:  hdi: hdi1 hdi2 hdi3
Jan  6 17:05:09 odysseus kernel: hdj: max request size: 1024KiB
Jan  6 17:05:09 odysseus kernel: hdj: 361882080 sectors (185283 MB) w/7965KiB Cache, CHS=22526/255/63, UDMA(100)
Jan  6 17:05:09 odysseus kernel:  hdj: hdj1 hdj2 hdj3
Jan  6 17:05:09 odysseus kernel: hdk: max request size: 1024KiB
Jan  6 17:05:09 odysseus kernel: hdk: 361882080 sectors (185283 MB) w/7965KiB Cache, CHS=22526/255/63, UDMA(100)
Jan  6 17:05:09 odysseus kernel:  hdk: hdk1 hdk2 hdk3
Jan  6 17:05:09 odysseus kernel: hdl: max request size: 1024KiB
Jan  6 17:05:09 odysseus kernel: hdl: 361882080 sectors (185283 MB) w/7965KiB Cache, CHS=22526/255/63, UDMA(100)
Jan  6 17:05:09 odysseus kernel:  hdl: hdl1 hdl2 hdl3

	So judging from the "UDMA(100)" strings I think DMA was
enabled then.

	Do you think it cannot be something with the read request size?
I have never seen a read request >128KB on 2.6.0-test7 (according to
average values computed from /proc/diskstats), but in 2.6.1-rc2 I
often see bigger requests.

	The problem may also be with the IDE controllers. Were there
any significant changes between 2.6.0-test7 and 2.6.1-rc2 in this area?

/dev/hda is on the southbridge:
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10)

/dev/hde and /dev/hdh are on CMD680 card:
00:0a.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 02)

others are on the on-board Promise controller:
00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|  I actually have a lot of admiration and respect for the PATA knowledge  |
| embedded in drivers/ide. But I would never call it pretty:) -Jeff Garzik |
