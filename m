Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSL3Aqj>; Sun, 29 Dec 2002 19:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265139AbSL3Aqj>; Sun, 29 Dec 2002 19:46:39 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:48599 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S265140AbSL3Aqg>; Sun, 29 Dec 2002 19:46:36 -0500
Date: Sun, 29 Dec 2002 16:54:57 -0800
From: Jeffrey Baker <jwbaker@acm.org>
Subject: 2.4.20 oops mounting iso9660 fs as hfs
To: linux-kernel@vger.kernel.org
Message-id: <20021230005457.GA15680@noodles>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using kernel 2.4.20 on ix86 and an HP IEEE1394 DVD+RW drive, I
encountered this BUG/oops when attempting to mount a CD-ROM.  I at
first could not mount the disc, so I attempted to mount it as HFS:

kernel BUG at buffer.c:2516!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013747e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 000007ff   ebx: 0000000b   ecx: 00000800   edx: cfed4280
esi: 00000001   edi: 00000b01   ebp: 00000002   esp: c5f71db4
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 15589, stackpage=c5f71000)
Stack: 00000000 00000b01 00000200 00000002 00002328 c013559a 00000b01 00000002 
       00000200 cff14c80 c06fc800 00000002 00000001 c01357c8 00000b01 00000002 
       00000200 c5f71e08 d4c5b703 00000b01 00000002 00000200 cff14c80 c06fc800 
Call Trace:    [<c013559a>] [<c01357c8>] [<d4c5b703>] [<d4c5a2c9>] [<d4c5b568>]
  [<c01d8bfd>] [<c01386fc>] [<d4c5f204>] [<d4c5f204>] [<c01388db>] [<d4c5f204>]
  [<c01488f9>] [<c0148bc2>] [<c0148a1d>] [<c0148f44>] [<c0106d27>]
Code: 0f 0b d4 09 00 b6 25 c0 8b 44 24 20 05 00 fe ff ff 3d 00 0e 


>>EIP; c013747e <grow_buffers+3e/110>   <=====

>>edx; cfed4280 <_end+fba14a8/1250c288>
>>esp; c5f71db4 <_end+5c3efdc/1250c288>

Trace; c013559a <getblk+2a/50>
Trace; c01357c8 <bread+18/70>
Trace; d4c5b703 <[hfs]hfs_buffer_get+23/80>
Trace; d4c5a2c9 <[hfs]hfs_mdb_get+a9/3c0>
Trace; d4c5b568 <[hfs]hfs_read_super+68/1a0>
Trace; c01d8bfd <media_changed+3d/70>
Trace; c01386fc <get_sb_bdev+1dc/250>
Trace; d4c5f204 <[hfs]hfs_fs+0/1c>
Trace; d4c5f204 <[hfs]hfs_fs+0/1c>
Trace; c01388db <do_kern_mount+5b/110>
Trace; d4c5f204 <[hfs]hfs_fs+0/1c>
Trace; c01488f9 <do_add_mount+69/140>
Trace; c0148bc2 <do_mount+152/170>
Trace; c0148a1d <copy_mount_options+4d/a0>
Trace; c0148f44 <sys_mount+84/d0>
Trace; c0106d27 <system_call+33/38>

Code;  c013747e <grow_buffers+3e/110>
00000000 <_EIP>:
Code;  c013747e <grow_buffers+3e/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0137480 <grow_buffers+40/110>
   2:   d4 09                     aam    $0x9
Code;  c0137482 <grow_buffers+42/110>
   4:   00 b6 25 c0 8b 44         add    %dh,0x448bc025(%esi)
Code;  c0137488 <grow_buffers+48/110>
   a:   24 20                     and    $0x20,%al
Code;  c013748a <grow_buffers+4a/110>
   c:   05 00 fe ff ff            add    $0xfffffe00,%eax
Code;  c013748f <grow_buffers+4f/110>
  11:   3d 00 0e 00 00            cmp    $0xe00,%eax

Corruptedly yours,
Jeffrey (please CC replies)

