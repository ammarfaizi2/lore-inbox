Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSHIOI2>; Fri, 9 Aug 2002 10:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSHIOI2>; Fri, 9 Aug 2002 10:08:28 -0400
Received: from dsl-213-023-029-199.arcor-ip.net ([213.23.29.199]:36619 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S313181AbSHIOI0>;
	Fri, 9 Aug 2002 10:08:26 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Oliver Feiler <kiza@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at buffer.c:2497! - mounting hfs formatted CD
Date: Fri, 9 Aug 2002 16:13:06 +0200
User-Agent: KMail/1.4.1
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208091613.20741.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm getting the following oops while trying to mount a hfs formatted CD 
(produced on Mac OS X). mount segfaults and I have to reboot to get my CD 
back.

I've found postings about this exact problem in the archives happening with 
2.4.17 and .18, but I didn't find a fix or patch for this. Does any patch 
exists to fix this problem?

Here's the output of ksymoops:

ksymoops 2.4.5 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at buffer.c:2497!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0136e5e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 000007ff   ebx: 0000000b   ecx: 00000800   edx: c15dc800
esi: 00000001   edi: 00000b01   ebp: 00000000   esp: dd855dbc
ds: 0018   es: 0018   ss: 0018
Process mount (pid: 211, stackpage=dd855000)
Stack: 00000b01 00000200 00000000 00000001 00004240 c0134fb7 00000b01 00000000
       00000200 00000b01 d4f38c00 00000000 c01351d8 00000b01 00000000 00000200
       00000000 e09655c3 00000b01 00000000 00000200 00000b01 00000001 00000000
Call Trace:    [<c0134fb7>] [<c01351d8>] [<e09655c3>] [<e0964839>] 
[<e0965443>]
  [<c01e831d>] [<c01380e0>] [<e0968fe4>] [<e0968fe4>] [<c01382bb>] 
[<e0968fe4>]
  [<c0148059>] [<c0148332>] [<c014817d>] [<c01486b4>] [<c010870b>]
Code: 0f 0b c1 09 c0 6e 25 c0 8b 44 24 20 05 00 fe ff ff 3d 00 0e


>>EIP; c0136e5e <grow_buffers+3e/110>   <=====

>>eax; 000007ff Before first symbol
>>ecx; 00000800 Before first symbol
>>edx; c15dc800 <_end+12bdc64/2053a464>
>>edi; 00000b01 Before first symbol
>>esp; dd855dbc <_end+1d537220/2053a464>

Trace; c0134fb7 <getblk+27/40>
Trace; c01351d8 <bread+18/70>
Trace; e09655c3 <[hfs]hfs_buffer_get+23/80>
Trace; e0964839 <[hfs]hfs_part_find+19/170>
Trace; e0965443 <[hfs]hfs_read_super+73/190>
Trace; c01e831d <media_changed+3d/70>
Trace; c01380e0 <get_sb_bdev+210/280>
Trace; e0968fe4 <[hfs]hfs_fs+0/1c>
Trace; e0968fe4 <[hfs]hfs_fs+0/1c>
Trace; c01382bb <do_kern_mount+5b/110>
Trace; e0968fe4 <[hfs]hfs_fs+0/1c>
Trace; c0148059 <do_add_mount+69/140>
Trace; c0148332 <do_mount+162/180>
Trace; c014817d <copy_mount_options+4d/a0>
Trace; c01486b4 <sys_mount+84/d0>
Trace; c010870b <system_call+33/38>

Code;  c0136e5e <grow_buffers+3e/110>
00000000 <_EIP>:
Code;  c0136e5e <grow_buffers+3e/110>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0136e60 <grow_buffers+40/110>
   2:   c1 09 c0                  rorl   $0xc0,(%ecx)
Code;  c0136e63 <grow_buffers+43/110>
   5:   6e                        outsb  %ds:(%esi),(%dx)
Code;  c0136e64 <grow_buffers+44/110>
   6:   25 c0 8b 44 24            and    $0x24448bc0,%eax
Code;  c0136e69 <grow_buffers+49/110>
   b:   20 05 00 fe ff ff         and    %al,0xfffffe00
Code;  c0136e6f <grow_buffers+4f/110>
  11:   3d 00 0e 00 00            cmp    $0xe00,%eax


1 warning issued.  Results may not be reliable.


- -- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9U84AOpifZVYdT9IRAvpUAJ9BJVIMbDUUbRAdePFx3JvPgCQYuwCeO4xj
hiUVK/O5/BdI4TJvSUEaJcE=
=ob1p
-----END PGP SIGNATURE-----

