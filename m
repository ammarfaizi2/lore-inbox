Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265631AbTF2LXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 07:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265632AbTF2LXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 07:23:47 -0400
Received: from 123.162-136-217.adsl.skynet.be ([217.136.162.123]:49156 "EHLO
	gw.ici") by vger.kernel.org with ESMTP id S265631AbTF2LXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 07:23:42 -0400
Message-ID: <3EFEDD34.6070408@trollprod.org>
Date: Sun, 29 Jun 2003 14:36:04 +0200
From: Olivier NICOLAS <olivn@trollprod.org>
Organization: TrollPod
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
Cc: green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.7x: processes in D state
References: <3EF0CBCB.4010202@trollprod.org>	<20030619060217.GA23774@namesys.com>	<3EFDA6C4.3090906@trollprod.org> <20030628165650.3e2353a5.akpm@digeo.com>
In-Reply-To: <20030628165650.3e2353a5.akpm@digeo.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040406080606090409060000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406080606090409060000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


1. SMP enable

System: dual Athlon 1800 MP
	MSI K7D master MB using IDE disk controller


2. Preempt is not enable

3. IDE controller

lspci
...
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04)
....


4. device driver used
CONFIG_BLK_DEV_AMD74XX=y

(full config is attached)


5. dmesg output
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7441: IDE controller at PCI slot 0000:00:07.1
AMD7441: chipset revision 4
AMD7441: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD_IDE: Advanced Micro Devic AMD-768 [Opus] IDE (rev 04) UDMA100 
controller on pci0000:00:07.1
     ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:DMA
hda: IC35L060AVVA07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: host protected area => 1
hda: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, 
UDMA(100)
  hda: hda1 hda2 hda4 < hda5 hda6 hda7 >
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12




Andrew Morton wrote:
> Olivier NICOLAS <olivn@trollprod.org> wrote:
> 
>>It still hapen in 2.5.73-bk5
>>
>> See Sys-Rq T output in attached file
> 
> 
> This is the offending process:
> 
> pdflush       D 00000001 4294957500    10      1            11     9 (L-TLB)
> dfdd5d28 00000046 c039d540 00000001 00000003 c02450f3 d4cc7a44 dfdd5d18 
>        dfdd5d18 dfda16a0 dfdd5d1c c03d7380 dfdd7980 00000283 00000246 ce311a0c 
>        c039d540 c03d7a00 dfdd5d64 dfdd5d34 c011ddb4 ce16a888 dfdd5d90 c0160ad9 
> Call Trace:
>  [<c02450f3>] generic_unplug_device+0x83/0xc0
>  [<c011ddb4>] io_schedule+0x24/0x30
>  [<c0160ad9>] __wait_on_buffer+0x99/0xd0
>  [<c011f210>] autoremove_wake_function+0x0/0x50
>  [<c011f210>] autoremove_wake_function+0x0/0x50
>  [<c01e57dd>] flush_commit_list+0x34d/0x440
>  [<c01e9f8c>] do_journal_end+0x71c/0xbe0
>  [<c01e911d>] flush_old_commits+0x12d/0x1c0
>  [<c01b5521>] __log_start_commit+0x31/0x40
>  [<c01d6c48>] reiserfs_write_super+0xa8/0xf0
>  [<c0166784>] sync_supers+0x164/0x180
>  [<c01434d8>] wb_kupdate+0x48/0x190
>  [<c011c2e4>] schedule+0x114/0x5e0
>  [<c0143d32>] __pdflush+0x162/0x350
>  [<c0143f20>] pdflush+0x0/0x20
>  [<c0143f31>] pdflush+0x11/0x20
>  [<c0143490>] wb_kupdate+0x0/0x190
>  [<c01073b9>] kernel_thread_helper+0x5/0xc
> 
> It looks like some IO got submitted and then was simply lost.
> 
> I can see you're using SMP.  Preempt or not?
> 
> What disk controller hardware are you using? And which device drivers
> for that hardware?
> 
> 


--------------040406080606090409060000
Content-Type: application/x-tar;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------040406080606090409060000--

