Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263428AbTGGRcR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 13:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTGGRcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 13:32:17 -0400
Received: from squirrelserver.co.uk ([217.160.171.76]:25257 "EHLO
	squirrelserver.co.uk") by vger.kernel.org with ESMTP
	id S263428AbTGGRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 13:32:15 -0400
X-Abuse-Info: send abuse reports to <abuse@e-consort.co.uk>
Message-ID: <61151.82.47.211.162.1057600008.squirrel@mail.e-consort.co.uk>
Date: Mon, 7 Jul 2003 18:46:48 +0100 (BST)
Subject: PDCRaid OOPS
From: "Tim Yamin" <plasmaroo@plasmaroo.squirrelserver.co.uk>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

<This was sent to Alan Cox ages ago; but nothing happened>

I'm using a Promise FastTrak 133 "Lite" Controller, and getting an OOPS on
a "different" RAID configuration.

Array info: RAID1 mirror:
                        HD0 @ 60GB  @ ATA133
                        HD1 @ 120GB @ ATA100

The crash happens upon loading pdcraid, not ataraid...

Strangely enough, I see my ataraid line, and it seems that this is a bug
in the partition logic: the bug happens after the partition line but NOT
after the end of it; looks like a bug in the logical partion code...

i.e. ataraid/d0: p1 p2 p3 p4 <<1>Unable to handle kernel NULL pointer
     dereference at virtual address 00000000

I also get this (before) (any clue what "[PTBL] [7476/255/63]" is for?):

 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
 /dev/ide/host2/bus1/target0/lun0: [PTBL] [7476/255/63] p1 p2 p3 p4 < p5 p6 >

I can't really do anything else: I've looked at pdcraid.c and ataraid.c
but I can't really find anything which I can relate to the ksymoops output;
everything seems to be related to IO access and there isn't that much init
code either.

------------------------------------------------------------------------

ksymoops 2.4.9 on i686 2.4.21.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21/ (default)
     -m /usr/src/linux/System.map (default)

 ataraid/d0:<1>Unable to handle kernel NULL pointer dereference at virtual
address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Tainted: Not Tainted

Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c03601e0   ebx: d674ca00   ecx: 00000000   edx: 00000000
esi: 00000002   edi: 038cf888   ebp: 00000000   esp: d66abcc8
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 2405, stackpage=d66ab000)
Stack: c01e973a c03601e0 00000000 d674ca00 00000000 00007200 00000002
00000000
       00000400 00001000 c01e97e9 00000000 d674ca00 d674c880 00000000
c013da2b
       00000000 d674ca00 d674c880 00000000 00000010 00015630 d674ca00
00000004
Call Trace:    [<c01e973a>] [<c01e97e9>] [<c013da2b>] [<c012f7ad>]
[<c0140b10>]
  [<c012ecc8>] [<c0140bd0>] [<c015f4ad>] [<c0140bd0>] [<c015f83d>]
[<c015fa5d>]
  [<c014fd7f>] [<c015ed82>] [<d9c26b80>] [<d9d76815>] [<d9d768cc>]
[<d9c27400>]
  [<d9c26b80>] [<c015f3e7>] [<d9c26b80>] [<d9c264aa>] [<d9c26b80>]
[<d9d76cad>]
  [<d9d76da9>] [<c011be31>] [<d9d76060>] [<d9d772fc>] [<d9d76060>]
[<c010912f>]
Code:  Bad EIP value.


>>EIP; 00000000 Before first symbol

>>eax; c03601e0 <blk_dev+0/8b80>
>>ebx; d674ca00 <_end+163cf37c/198a89dc>
>>esp; d66abcc8 <_end+1632e644/198a89dc>

Trace; c01e973a <generic_make_request+da/130>
Trace; c01e97e9 <submit_bh+59/80>
Trace; c013da2b <block_read_full_page+1fb/2a0>
Trace; c012f7ad <__read_cache_page+8d/d0>
Trace; c0140b10 <blkdev_get_block+0/60>
Trace; c012ecc8 <read_cache_page+38/b0>
Trace; c0140bd0 <blkdev_readpage+0/20>
Trace; c015f4ad <read_dev_sector+4d/d0>
Trace; c0140bd0 <blkdev_readpage+0/20>
Trace; c015f83d <handle_ide_mess+2d/1e0>
Trace; c015fa5d <msdos_partition+6d/310>
Trace; c014fd7f <new_inode+f/50>
Trace; c015ed82 <check_partition+132/210>
Trace; d9c26b80 <[ataraid]ataraid_gendisk+0/9>
Trace; d9d76815 <[pdcraid]calc_pdcblock_offset+25/70>
Trace; d9d768cc <[pdcraid]read_disk_sb+6c/f0>
Trace; d9c27400 <[ataraid]ataraid_gendisk_sizes+0/400>
Trace; d9c26b80 <[ataraid]ataraid_gendisk+0/9>
Trace; c015f3e7 <grok_partitions+c7/140>
Trace; d9c26b80 <[ataraid]ataraid_gendisk+0/9>
Trace; d9c264aa <[ataraid]ataraid_register_disk+3a/40>
Trace; d9c26b80 <[ataraid]ataraid_gendisk+0/9>
Trace; d9d76cad <[pdcraid]pdcraid_init_one+5d/e0>
Trace; d9d76da9 <[pdcraid]pdcraid_init+79/c0>
Trace; c011be31 <sys_init_module+4e1/630>
Trace; d9d76060 <[pdcraid]pdcraid_ioctl+0/350>
Trace; d9d772fc <[pdcraid].rodata.end+bd/101>
Trace; d9d76060 <[pdcraid]pdcraid_ioctl+0/350>
Trace; c010912f <system_call+33/38>



