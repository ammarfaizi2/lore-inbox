Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281077AbRKOV37>; Thu, 15 Nov 2001 16:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281073AbRKOV3u>; Thu, 15 Nov 2001 16:29:50 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:47074 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281074AbRKOV3h>; Thu, 15 Nov 2001 16:29:37 -0500
Date: Thu, 15 Nov 2001 22:29:20 +0100
From: Birger Lammering <lammering@planet-interkom.de>
To: linux-kernel@vger.kernel.org
Cc: birger.lammering@science-computing.de
Subject: nfs problem: hp-server --- linux 2.4.13 client, ooops
Message-ID: <20011115222920.A9929@ludwig2.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I've got an interesting problem for people working on nfs:

Kernel version: 2.4.13 (up and smp), Trond's seekdir patch, ext3 patch
Hardware: P4 1700 (1 and 2), 2 GB RAM.
Compiled with RedHat 7.1 gcc (2.96-85)
nfs-Server: HP-UX 10.20

Without the nfs patch I had a lot of trouble with Irix servers - now Irix,
NetApp, Aix, Linux... nfs- servers are fine, but connecting to a HP server
leads to statements like this in the syslog:
NFS: short packet in readdir reply!

Even worse: Accessing one particular directory (using ls, find etc) leads
to a segmentation fault in the accessing process. The machine stays up and
running, but some other processes (without relationship to nfs mount) die a
sudden death as well.

There is nothing special about the directory on the nfs server.
There is no problem with Linux  2.2.14-5.0smp. I can check with other 2.4
versions if necessary. The problem is independent of the nfs version.

The syslog says:


Unable to handle kernel paging request at virtual address fe01e000
 printing eip:
f898eaed
*pde = 00004063
*pte = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<f898eaed>]    Not tainted
EFLAGS: 00010296
eax: 01000000   ebx: fe01dff8   ecx: fe01e000   edx: 00000019
esi: fe01e000   edi: 0000006c   ebp: f537405c   esp: f4e83c60
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 11091, stackpage=f4e83000)
Stack: f4e83cec f518c200 f898ea4c f8956e07 f537405c f6a15240 f4e83d94
f4e83d40 
       f4e83d54 f4e83cac 00000002 f895a18c f4e83cec f4e83cec fffffff5
f4e83cec 
       f518c200 f4e82000 f4e82000 00000000 f4e82000 f4e83d58 f4e83d58
f895a498 
Call Trace: [<f898ea4c>] [<f8956e07>] [<f895a18c>] [<f895a498>]
[<f895646e>] 
   [<f8997520>] [<f89594e0>] [<f898e09e>] [<f8997520>] [<f898b89a>]
[<c01299e8>] 
   [<f898bc2b>] [<f898b7c0>] [<f898eb1c>] [<c0142bb4>] [<c0142f90>]
[<c01430f3>]
 
   [<c0142f90>] [<c0125838>] [<c0106f7b>] 

Code: 8b 11 0f ca 8d 42 03 24 fc 8d 4c 01 08 81 fa ff 00 00 00 77 
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: f6ff2480   ecx: 00000000   edx: 00000000
esi: f6f49b80   edi: f4e83d24   ebp: f7308180   esp: f4e83d00
ds: 0018   es: 0018   ss: 0018
Process gcc (pid: 11097, stackpage=f4e83000)
Stack: f7308180 f6ff24bc f4e83d90 f4e83d24 f6ff2480 00000000 f4e83e34
f72fae00 
       f4e83d90 00010002 00000000 00000000 00000000 00000000 00000000
00000000 
       00000005 0000a1ff 00000001 00000000 00000000 0000001c 00000000
00001000 
Call Trace: [<c013e3de>] [<c013e850>] [<c013ee1a>] [<c013c65e>]
[<c013d13e>] 
   [<f898eb1c>] [<c0142bb4>] [<c0141f0a>] [<c013e14d>] [<c0105b8f>]
[<c0106f7b>]
 

Code:  Bad EIP value.
 <1>Unable to handle kernel NULL pointer dereference at virtual address
00000000
 printing eip:
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
EFLAGS: 00010286
eax: 00000000   ebx: f6ff2480   ecx: 00000000   edx: 00000000
esi: f6f49b80   edi: f4e83d24   ebp: f7308180   esp: f4e83d00
ds: 0018   es: 0018   ss: 0018
Process gcc (pid: 11139, stackpage=f4e83000)
Stack: f7308180 f6ff24bc f4e83d90 f4e83d24 f6ff2480 00000000 f4e83e34
f72fae00 
       f4e83d90 08060002 f4e82000 f6fe4100 00001812 00000000 080603ec
080600a0 
       00000005 0000a1ff 00000001 00000000 00000000 0000001c 00000000
00001000 
Call Trace: [<c013e3de>] [<c013e850>] [<c013ee1a>] [<c013c65e>]
[<c013d13e>] 
   [<c012ee22>] [<c01201e5>] [<c01202aa>] [<c0116da1>] [<c0141f0a>]
[<c013e14d>]
 
   [<c0105b8f>] [<c0106f7b>] 

Code:  Bad EIP value.

If you are interested in more details or even better have a solution,
please also cc email to my account, since I'm only a casual spectator at
this list.

Cheers,
Birger

--
Dr. Birger Lammering                         
science+computing ag                        Tel: 089 356386-15
Geschaeftsstelle Muenchen                   Fax: 089 356386-37
Ingolstaedter Str. 22
80807 Muenchen         email:  Birger.Lammering(at)partner.bmw.de
                              B.Lammering(at)science-computing.de

