Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274287AbRJAACW>; Sun, 30 Sep 2001 20:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274288AbRJAACM>; Sun, 30 Sep 2001 20:02:12 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:62963 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S274287AbRJAAB5>;
	Sun, 30 Sep 2001 20:01:57 -0400
Date: Mon, 1 Oct 2001 02:02:23 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200110010002.CAA14944@harpo.it.uu.se>
To: torvalds@transmeta.com
Subject: 2.4.11-pre1 oops in bdget()
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.11-pre1 built with gcc 2.95.3, building 2.4.10-ac1,
final dd in 'make bzdisk' oopsed with the following:

ksymoops 2.4.2 on i686 2.4.11-pre1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.11-pre1/ (default)
     -m /boot/System.map-2.4.11-pre1 (specified)

Unable to handle kernel paging request at virtual address d08b8b60
c0133664
*pde = 0fd41067
Oops: 0000
CPU:    0
EIP:    0010:[<c0133664>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000000   ebx: ccc15a40   ecx: d08b8b60   edx: 00000200
esi: 00000400   edi: cff752a0   ebp: 00000200   esp: c4251f14
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 9335, stackpage=c4251000)
Stack: cfa7d260 cfa7d260 cda4cbe0 cffe92a0 00000200 c021f640 00000200 c0133793 
       00000200 cda4cbe0 c0133c16 cfa7d260 cda4cbe0 cfa7d260 00000000 cffe92a0 
       c012ccb5 cfa7d260 cda4cbe0 000001b6 ca0a4000 00008241 bffff098 c012cbca 
Call Trace: [<c0133793>] [<c0133c16>] [<c012ccb5>] [<c012cbca>] [<c012cefa>] 
   [<c0106b0b>] 
Code: 83 3c 81 00 0f 45 34 81 89 f0 b9 08 00 00 00 41 d1 e8 3d 00 

>>EIP; c0133664 <bdget+f8/180>   <=====
Trace; c0133792 <bd_acquire+26/80>
Trace; c0133c16 <blkdev_open+16/b8>
Trace; c012ccb4 <dentry_open+e0/188>
Trace; c012cbca <filp_open+52/5c>
Trace; c012cefa <sys_open+36/94>
Trace; c0106b0a <system_call+32/38>
Code;  c0133664 <bdget+f8/180>
00000000 <_EIP>:
Code;  c0133664 <bdget+f8/180>   <=====
   0:   83 3c 81 00               cmpl   $0x0,(%ecx,%eax,4)   <=====
Code;  c0133668 <bdget+fc/180>
   4:   0f 45 34 81               cmovne (%ecx,%eax,4),%esi
Code;  c013366c <bdget+100/180>
   8:   89 f0                     mov    %esi,%eax
Code;  c013366e <bdget+102/180>
   a:   b9 08 00 00 00            mov    $0x8,%ecx
Code;  c0133672 <bdget+106/180>
   f:   41                        inc    %ecx
Code;  c0133674 <bdget+108/180>
  10:   d1 e8                     shr    %eax
Code;  c0133676 <bdget+10a/180>
  12:   3d 00 00 00 00            cmp    $0x0,%eax

