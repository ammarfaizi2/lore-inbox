Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289313AbSANX7y>; Mon, 14 Jan 2002 18:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289308AbSANX7p>; Mon, 14 Jan 2002 18:59:45 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:49677 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S289313AbSANX7g>; Mon, 14 Jan 2002 18:59:36 -0500
Date: Tue, 15 Jan 2002 00:59:18 +0100 (CET)
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.18-pre1 - world-record holder
Message-ID: <Pine.LNX.4.33.0201150041540.2772-100000@lt.wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have machine with world-record holder with Oopses. :-)

[root@mask log]# cat messages |grep Oops |wc -l
  16904
[root@mask log]# cat messages |grep Oops |head -n 1
Jan  4 14:35:34 mask kernel: Oops: 0000
[root@mask log]# cat messages |grep Oops |tail -n 1
Jan 15 00:26:56 mask kernel: Oops: 0000

Probably it's a hardware problem, but earlier with 2.4.15-pre5 i didn't
have problem with it. This machine is a NFS server with reiserfs spool 
area.

Below as an example - only one Oops:

ksymoops 2.4.0 on i686 2.4.18-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-pre3/ (default)
     -m /lib/modules/2.4.18-pre3/System.map (specified)

Unable to handle kernel paging request at virtual address 11482dae
c01203b3
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01203b3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 11482da6   ebx: 46981181   ecx: ca8bb7e0   edx: 46981181
esi: 00000000   edi: cfddf720   ebp: ca8bb7e0   esp: cf5d3db8
ds: 0018   es: 0018   ss: 0018
Process check_ping (pid: 28145, stackpage=cf5d3000)
Stack: 46981181 00000000 cfddf720 ca8bb7e0 c0120518 cfddf720 ca8bb7e0 46981181
       00000000 c9a72604 00280006 00170018 c0299d58 00000fd7 00000025 c029ae58
       00000000 00000002 cf5d2000 cfddf720 ca8bb7e0 46981181 c01100ca cfddf720
Call Trace: [<c0120518>] [<c01100ca>] [<c012389c>] [<c01238c9>] [<c012037e>]
   [<c01237e0>] [<c01203f1>] [<c010ff40>] [<c0106ddc>] [<c010ff40>] [<c0240018>]
   [<c0121087>] [<c010ffc9>] [<c011210c>] [<c0105678>] [<c0129231>] [<c0110c81>]
   [<c010ff40>] [<c0106ddc>]
Code: 8b 68 08 85 ed 75 26 52 8b 7c 24 24 57 8b 74 24 2c 56 8b 5c

>>EIP; c01203b3 <do_no_page+13/120>   <=====
Trace; c0120518 <handle_mm_fault+58/c0>
Trace; c01100ca <do_page_fault+18a/4cb>
Trace; c012389c <filemap_nopage+bc/210>
Trace; c01238c9 <filemap_nopage+e9/210>
Trace; c012037e <do_anonymous_page+8e/b0>
Trace; c01237e0 <filemap_nopage+0/210>
Trace; c01203f1 <do_no_page+51/120>
Trace; c010ff40 <do_page_fault+0/4cb>
Trace; c0106ddc <error_code+34/3c>
Trace; c010ff40 <do_page_fault+0/4cb>
Trace; c0240018 <packet_flush_mclist+78/80>
Trace; c0121087 <find_vma+37/60>
Trace; c010ffc9 <do_page_fault+89/4cb>
Trace; c011210c <copy_mm+28c/2c0>
Trace; c0105678 <copy_thread+68/90>
Trace; c0129231 <__alloc_pages+41/180>
Trace; c0110c81 <schedule+2e1/310>
Trace; c010ff40 <do_page_fault+0/4cb>
Trace; c0106ddc <error_code+34/3c>
Code;  c01203b3 <do_no_page+13/120>
00000000 <_EIP>:
Code;  c01203b3 <do_no_page+13/120>   <=====
   0:   8b 68 08                  mov    0x8(%eax),%ebp   <=====
Code;  c01203b6 <do_no_page+16/120>
   3:   85 ed                     test   %ebp,%ebp
Code;  c01203b8 <do_no_page+18/120>
   5:   75 26                     jne    2d <_EIP+0x2d> c01203e0 <do_no_page+40/120>
Code;  c01203ba <do_no_page+1a/120>
   7:   52                        push   %edx
Code;  c01203bb <do_no_page+1b/120>
   8:   8b 7c 24 24               mov    0x24(%esp,1),%edi
Code;  c01203bf <do_no_page+1f/120>
   c:   57                        push   %edi
Code;  c01203c0 <do_no_page+20/120>
   d:   8b 74 24 2c               mov    0x2c(%esp,1),%esi
Code;  c01203c4 <do_no_page+24/120>
  11:   56                        push   %esi
Code;  c01203c5 <do_no_page+25/120>
  12:   8b 5c 00 00               mov    0x0(%eax,%eax,1),%ebx


-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl

