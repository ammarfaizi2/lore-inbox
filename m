Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261442AbSJYOvp>; Fri, 25 Oct 2002 10:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261443AbSJYOvp>; Fri, 25 Oct 2002 10:51:45 -0400
Received: from mail012.mail.bellsouth.net ([205.152.58.32]:55266 "EHLO
	imf12bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S261442AbSJYOvn>; Fri, 25 Oct 2002 10:51:43 -0400
Date: Fri, 25 Oct 2002 10:57:53 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: Linux 2.5.44-ac3: on boot, BUG in mm/page_alloc.c:120
Message-ID: <Pine.LNX.4.43.0210251055430.12130-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On booting 2.5.44-ac3, I'm getting a BUG in mm/page_alloc.c:120

This oops doesn't happen with 2.5.44.

Loading 2.5.44ac3........................
BIOS data check successful
Linux version 2.5.44-ac3 (root@razor) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Fri Oct 25 09:56:22 EST 2002
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000a000000 (usable)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
160MB LOWMEM available.
On node 0 totalpages: 40960
  DMA zone: 4096 pages
  Normal zone: 36864 pages
  HighMem zone: 0 pages
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=2.5.44ac3 root=302 console=ttyS0,9600 console=tty0
Initializing CPU#0
Detected 264.844 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 521.21 BogoMIPS
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:120!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c012daba>]    Not tainted
EFLAGS: 00010206
EIP is at __free_pages_ok+0x146/0x2e4
eax: 0000ffff   ebx: 00000003   ecx: c0353370   edx: 00010000
esi: c1000000   edi: c0353370   ebp: c0377f78   esp: c0377f44
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c0376000 task=c034f300)
Stack: c1000078 00000008 00000003 c0377f64 c011399a ffffffff c03533e0 c1000000
       c0377f84 c0113a89 ffff0000 00000003 ffffffff c0377f80 c012e4d2 c0377fac
       c038227c c0376000 000a0200 c0105000 fffffff8 c0410000 0000a000 00000000
Call Trace:
 [<c011399a>] _call_console_drivers+0x5a/0x64
 [<c0113a89>] call_console_drivers+0xe5/0xf0
 [<c012e4d2>] __free_pages+0x36/0x3c
 [<c0105000>] stext+0x0/0x14
 [<c0105000>] stext+0x0/0x14
 [<c0105000>] stext+0x0/0x14

Code: 0f 0b 78 00 96 f0 28 c0 8b 45 f8 8b 55 e4 8d 4f 01 89 45 fc
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing

--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


On Fri, 25 Oct 2002, Alan Cox wrote:

> ** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.
>
>    Doug's scsi changes broke mptfusion. I've not looked into that yet
>    also u14f/u34f.
>
>    This one builds, its not yet had any measurable testing
>
> Linux 2.5.44-ac3
> o	Update the cciss driver				(Stephen Cameron)
> o	Fix seagate st02 unload				(me)
> o	Fix missing \n in i810 driver			(me)
> o	Update Ninja SCSI PCMCIA driver			(Yokota Hiroshi)
> o	Clean up and kill off scsi_merge		(Christoph Hellwig)
> o	Remove niceness magic numbers			(Randy Dunlap)
> o	Update EDD support				(Matt Domsch)
> o	Update voyager support for IRQ stacks		(James Bottomley)
> -	Revert do_mounts change
> o	Better fix for raw.c headers			(Bjoern Zeeb)
> o	Fix ehci enumeration breakage			(David Brownell)
> o	Update adv7175 to new style i2c			(Frank Davis)
> o	PnP updates					(Adam Belay)
> o	PnP conversion of CS423x to new code		(Adam Belay)
> o	Fix APM BUG() on SMP boxes, port forward 2.4	(me)
> 	changes
> o	Update other Digi URLS				(me)
>


