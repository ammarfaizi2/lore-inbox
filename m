Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267635AbTAGQSt>; Tue, 7 Jan 2003 11:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267636AbTAGQSt>; Tue, 7 Jan 2003 11:18:49 -0500
Received: from smtp2.home.se ([195.66.35.201]:44957 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id <S267635AbTAGQSs>;
	Tue, 7 Jan 2003 11:18:48 -0500
Message-ID: <000f01c2b56e$aab93650$0219450a@sandos>
From: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
To: <linux-kernel@vger.kernel.org>
Subject: Re: How does the disk buffer cache work?
Date: Mon, 6 Jan 2003 11:30:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> More details: lspci -vv output for the IDE
controller:
>
> 00:07.1 IDE interface: Intel Corp. 82371FB PIIX IDE
> [Triton I] (rev 02) (prog-if 80 [Master])
>         Control: I/O+ Mem- BusMaster+ SpecCycle-
> MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
> DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR-
>         Latency: 32
>         Region 0: [virtual] I/O ports at 01f0
>         Region 1: [virtual] I/O ports at 03f4
>         Region 2: [virtual] I/O ports at 0170
>         Region 3: [virtual] I/O ports at 0374
>         Region 4: I/O ports at 3000 [size=16]
>
> The hdd is a 1GB ST51080A, but I dont know if its the
> particualr hdd that causes problems, or if its
> something else. A cdrom on the same channel works.
Dont
> have any other hdds to test with right now.

I saw that this mail did not connect to the right
thread, so to recap: With this hdd as master on my
second IDE channel, 2.4.20 hangs at the partition
check, a backtrace:

lock_page
read_cache_page
read_dev_sector
handle_ide_mess
msdos_partition
check_partition
grok_partitions
register_disk
ide_geninit
ide_init
blk_dev_init
device_init
do_initcalls

There is a primary msdos partition on this drive that
use the entire disk, but I also tried with a clear
partition table. 2.2 slackware bootdisk is fine, DOS is
fine in using the hdd. If anybody wants more info, just
tell me what to do. Im not on the list so reply to me
if so. I also tried lots of IDE patches but didnt help.
Any specific kernel versions or kernel options I should
try/disable/enable?

---
John Bäckstrand


