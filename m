Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315717AbSHZPuz>; Mon, 26 Aug 2002 11:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316530AbSHZPuz>; Mon, 26 Aug 2002 11:50:55 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:26770 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315717AbSHZPux> convert rfc822-to-8bit; Mon, 26 Aug 2002 11:50:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: h.grosenick@t-online.de (Holger Grosenick)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: System freeze on 2.4.18 / 19 SMP
Date: Mon, 26 Aug 2002 17:54:56 +0200
User-Agent: KMail/1.4.3
References: <200208261436.44030.hgrosenick@web.de> <1030365978.1437.6.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1030365978.1437.6.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: linux-kernel@vger.kernel.org
Message-Id: <200208261754.56217.hgrosenick@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't think ALSA is likely to be the cause however. Does it behave
> stably running a non SMP kernel ?

yes alsa is running too - i'll deactivate it next time.

It just tried to run the installer on a PII 400MHz with SuSE kernel 2.4.18-4GB 
and only 128MB of physical RAM / 380 MB swap (short test, i will recompile 
the 2.4.19 later):

- the installer itself (java-app) crashed with segmentation fault
- afterwards the system is unstable, starting the installer again leads to 
kernel messages as follows and even "umount" gets a segmentation fault.


Aug 26 17:32:31 holger kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Aug 26 17:32:31 holger kernel:  printing eip:
Aug 26 17:32:31 holger kernel: c0145ab6
Aug 26 17:32:31 holger kernel: *pde = 00000000
Aug 26 17:32:31 holger kernel: Oops: 0002
Aug 26 17:32:31 holger kernel: CPU:    0
Aug 26 17:32:31 holger kernel: EIP:    0010:[iput+302/464]    Not tainted
Aug 26 17:32:31 holger kernel: EFLAGS: 00010246
Aug 26 17:32:31 holger kernel: eax: 00000000   ebx: c6c407e0   ecx: 00000000   
edx: c6c407e8
Aug 26 17:32:31 holger kernel: esi: c13a5c00   edi: c16250c0   ebp: 000001d0   
esp: c7fe3f10
Aug 26 17:32:31 holger kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 17:32:31 holger kernel: Process kswapd (pid: 5, stackpage=c7fe3000)
Aug 26 17:32:31 holger kernel: Stack: c7903da0 c6c407e0 000005aa c01436c6 
c6c407e0 c7903db8 c7903da0 c01439d4 
Aug 26 17:32:31 holger kernel:        c7903da0 00000000 c114de40 0000001e 
c0143c8b 00000689 c012c586 00000006 
Aug 26 17:32:31 holger kernel:        000001d0 00000020 c02a9510 000001d0 
c02a9510 c7fe2000 ffffffff 0000c40f 
Aug 26 17:32:32 holger kernel: Call Trace: [dentry_iput+70/116] 
[prune_dcache+148/280] [shrink_dcache_memory+27/52] [shrink_cache+606/816] 
[shrink_caches+93/104] 
Aug 26 17:32:32 holger kernel:    [try_to_free_pages+92/240] 
[kswapd_balance_pgdat+85/164] [kswapd_balance+22/44] [kswapd+155/196] 
[kernel_thread+40/56] 
Aug 26 17:32:32 holger kernel: 
Aug 26 17:32:32 holger kernel: Code: 89 48 04 89 01 a1 64 a3 2a c0 89 50 04 89 
43 08 c7 42 04 64 

-------------------------------------------------------------------------

The time before, i started the installer, it failed the i tried to read an 
"rpm" from a NFS share and got:


Aug 26 15:24:18 holger kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000028
Aug 26 15:24:18 holger kernel:  printing eip:
Aug 26 15:24:18 holger kernel: c01453dc
Aug 26 15:24:18 holger kernel: *pde = 00000000
Aug 26 15:24:18 holger kernel: Oops: 0000
Aug 26 15:24:18 holger kernel: CPU:    0
Aug 26 15:24:18 holger kernel: EIP:    0010:[find_inode+32/76]    Not tainted
Aug 26 15:24:18 holger kernel: EFLAGS: 00010203
Aug 26 15:24:18 holger kernel: eax: c25d1e80   ebx: 00000000   ecx: 0000000d   
edx: c1607ec4
Aug 26 15:24:18 holger kernel: esi: 00000000   edi: c1607ec4   ebp: 000042e8   
esp: c25d1e2c
Aug 26 15:24:18 holger kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 15:24:18 holger kernel: Process rpm (pid: 1368, stackpage=c25d1000)
Aug 26 15:24:18 holger kernel: Stack: 00000000 c1212cc0 000042e8 c13a4c00 
c0145860 c13a4c00 000042e8 c1212cc0 
Aug 26 15:24:18 holger kernel:        c1607ec4 c25d1e80 00000000 c25d1f04 
c25d1ea0 c0803640 c1607f07 c13a4c00 
Aug 26 15:24:18 holger kernel:        000042e8 c1607ec4 c25d1e80 00000000 
00000001 000042df c1604228 c13a4c00 
Aug 26 15:24:18 holger kernel: Call Trace: [iget4+64/272] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.18-4GB/kernel/fs/nfsd/nfsd.+-51
020092/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.18-4GB/kernel/fs/nfsd/nfsd.+-51020025/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.
4.18-4GB/kernel/fs/nfsd/nfsd.+-51020092/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.18-4GB/kernel/fs/nfsd/nfsd.+-51035608/96] 
Aug 26 15:24:18 holger kernel:    [real_lookup+83/196] 
[link_path_walk+1270/1908] [path_walk+26/28] [__user_walk+53/80] [sys_st
at64+25/120] [system_call+51/64] 
Aug 26 15:24:18 holger kernel: 
Aug 26 15:24:18 holger kernel: Code: 39 6e 28 75 ef 8b 44 24 14 39 86 9c 00 00 
00 75 e3 85 ff 74 

Aug 26 15:25:13 holger kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000028
Aug 26 15:25:13 holger kernel:  printing eip:
Aug 26 15:25:13 holger kernel: c01453dc
Aug 26 15:25:13 holger kernel: *pde = 00000000
Aug 26 15:25:13 holger kernel: Oops: 0000
Aug 26 15:25:13 holger kernel: CPU:    0
Aug 26 15:25:13 holger kernel: EIP:    0010:[find_inode+32/76]    Not tainted
Aug 26 15:25:13 holger kernel: EFLAGS: 00010203
Aug 26 15:25:13 holger kernel: eax: c25d1e80   ebx: 00000000   ecx: 0000000d   
edx: c1607ec4
Aug 26 15:25:13 holger kernel: esi: 00000000   edi: c1607ec4   ebp: 000062e7   
esp: c25d1e2c
Aug 26 15:25:13 holger kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 15:25:13 holger kernel: Process rpm (pid: 1373, stackpage=c25d1000)
Aug 26 15:25:13 holger kernel: Stack: 00000000 c1212cc0 000062e7 c13a4c00 
c0145860 c13a4c00 000062e7 c1212cc0 
Aug 26 15:25:13 holger kernel:        c1607ec4 c25d1e80 00000000 c25d1f04 
c25d1ea0 c2c22320 c1607f07 c13a4c00 
Aug 26 15:25:13 holger kernel:        000062e7 c1607ec4 c25d1e80 00000000 
00000001 000062dd c1604228 c13a4c00 
Aug 26 15:25:13 holger kernel: Call Trace: [iget4+64/272] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.18-4GB/kernel/fs/nfsd/nfsd.+-51
020092/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.18-4GB/kernel/fs/nfsd/nfsd.+-51020025/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.
4.18-4GB/kernel/fs/nfsd/nfsd.+-51020092/96] 
[nfsd:__insmod_nfsd_O/lib/modules/2.4.18-4GB/kernel/fs/nfsd/nfsd.+-51035608/96] 
Aug 26 15:25:13 holger kernel:    [real_lookup+83/196] 
[link_path_walk+1270/1908] [path_walk+26/28] [__user_walk+53/80] [sys_ls
tat64+25/112] [system_call+51/64] 
Aug 26 15:25:13 holger kernel: 
Aug 26 15:25:49 holger kernel:  <1>Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Aug 26 15:25:49 holger kernel:  printing eip:
Aug 26 15:25:49 holger kernel: c0144751
Aug 26 15:25:49 holger kernel: *pde = 00000000
Aug 26 15:25:49 holger kernel: Oops: 0002
Aug 26 15:25:49 holger kernel: CPU:    0
Aug 26 15:25:49 holger kernel: EIP:    0010:[__mark_inode_dirty+93/120]    Not 
tainted
Aug 26 15:25:49 holger kernel: EFLAGS: 00010203
Aug 26 15:25:49 holger kernel: eax: 00000000   ebx: c31137e0   ecx: 00000000   
edx: c31137e8
Aug 26 15:25:49 holger kernel: esi: c13a4c00   edi: 00000001   ebp: c31137e0   
esp: c5fa1f30
Aug 26 15:25:49 holger kernel: ds: 0018   es: 0018   ss: 0018
Aug 26 15:25:49 holger kernel: Process ldconfig (pid: 1379, 
stackpage=c5fa1000)
Aug 26 15:25:49 holger kernel: Stack: c5fa0000 c3148ec0 c5fa1fa4 c0145cce 
c31137e0 00000001 c013c410 c31137e0 
Aug 26 15:25:49 holger kernel:        c77c4000 00000000 c5fa1fa4 00000009 
00000001 00000009 00000000 c77c4019 
Aug 26 15:25:49 holger kernel:        c3148ec0 c77c4009 00000010 7f180bac 
c013c596 c013ca15 c5fa0000 c5fa1fa4 
Aug 26 15:25:49 holger kernel: Call Trace: [update_atime+78/84] 
[link_path_walk+1544/1908] [path_walk+26/28] [__user_walk+53/80
] [sys_stat64+25/120] 
Aug 26 15:25:49 holger kernel:    [sys_close+67/84] [system_call+51/64] 



I hope that i don't destroy my installation with that ...

