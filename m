Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbRFMSlg>; Wed, 13 Jun 2001 14:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbRFMSlQ>; Wed, 13 Jun 2001 14:41:16 -0400
Received: from pc40.e18.physik.tu-muenchen.de ([129.187.154.153]:1805 "EHLO
	pc40.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S263244AbRFMSlF>; Wed, 13 Jun 2001 14:41:05 -0400
Date: Wed, 13 Jun 2001 20:40:58 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.4 Oops in ext2 and strange /proc/ksyms
Message-ID: <Pine.LNX.4.31.0106132028550.26564-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

After seeing the Oops below (and rebooting), I looked into /proc/ksyms
(because ksymoops complained about mismatches), and I could not find
system_call, do_page_fault, etc. Shouldn't they be there? When doing
ksymoops with /proc/ksyms I found recursive calling of do_brk, which
for sure is not the right thing.

The machine is a dual PII-450, kernel is 2.4.4 vanilla with Neil Brown's
knfsd-patch.

----------------------------------------------
ksymoops 2.4.0 on i686 2.4.4.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /usr/src/linux/System.map (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0002
CPU: 0
EIP: 0010:[<c0124b96>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000  ebx: c16d32f8  ecx: c16d32f8  edx: c023b0c0
esi: c16d32f8  edi: c5b556e4  ebp: 00000000  esp: c2dbded4
ds: 0018  es: 0018  ss: 0018
Process g++ (pid: 24364, stackpage=c2dbd000)
Stack:  c16d32f8  c0124c06  c16d32f8  c16d32f8  c0124e6b  c16d32f8  00000000  c2dbdf18
        d38f71c0  dd7c5ba0  c015af38  dd7c5ba0  c2dbdf18  00000000  c5b556e4  c63dc140
        c0124f27  00000000  c5b55640  c028ab40  df56fa20  c0149cf5  c5b556e4  00000000
Call Trace: [<c0124c06>] [<c0124e6b>] [<c015af38>] [<c0124f27>] [<c0149cf5>] [<c0147e46>] [<c013e7d9>]
            [<c0140c9a>] [<c013f9aa>] [<c0140d6a>] [<c0111ef0>] [<c0106edb>]
Code: ff 48 18 8b 53 04 8b 03 89 50 04 89 02 8b 43 10 c7 43 08 00

>>EIP; c0124b96 <__remove_inode_page+26/60>   <=====
Trace; c0124c06 <remove_inode_page+36/40>
Trace; c0124e6b <truncate_list_pages+12b/1a0>
Trace; c015af38 <ext2_delete_entry+98/100>
Trace; c0124f27 <truncate_inode_pages+47/80>
Trace; c0149cf5 <iput+a5/170>
Trace; c0147e46 <d_delete+66/b0>
Trace; c013e7d9 <vfs_permission+89/120>
Trace; c0140c9a <vfs_unlink+17a/1b0>
Trace; c013f9aa <lookup_hash+4a/e0>
Trace; c0140d6a <sys_unlink+9a/110>
Trace; c0111ef0 <do_page_fault+0/470>
Trace; c0106edb <system_call+33/38>
Code;  c0124b96 <__remove_inode_page+26/60>
00000000 <_EIP>:
Code;  c0124b96 <__remove_inode_page+26/60>   <=====
   0:   ff 48 18                  decl   0x18(%eax)   <=====
Code;  c0124b99 <__remove_inode_page+29/60>
   3:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c0124b9c <__remove_inode_page+2c/60>
   6:   8b 03                     mov    (%ebx),%eax
Code;  c0124b9e <__remove_inode_page+2e/60>
   8:   89 50 04                  mov    %edx,0x4(%eax)
Code;  c0124ba1 <__remove_inode_page+31/60>
   b:   89 02                     mov    %eax,(%edx)
Code;  c0124ba3 <__remove_inode_page+33/60>
   d:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c0124ba6 <__remove_inode_page+36/60>
  10:   c7 43 08 00 00 00 00      movl   $0x0,0x8(%ebx)

Ciao,
					Roland

+-----------------------------------------------------+
|    Tel.:    089/32649332        0561/873744         |
|    in       Radeberger Weg 8    Am Fasanenhof 16    |
|             85748 Garching      34125 Kassel        |
+---------------------------+-------------------------+
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+
|             May the Source be with you!             |
+-----------------------------------------------------+

