Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129671AbQJ2WDS>; Sun, 29 Oct 2000 17:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129787AbQJ2WC7>; Sun, 29 Oct 2000 17:02:59 -0500
Received: from getafix.lostland.net ([216.29.29.27]:22313 "EHLO
	getafix.lostland.net") by vger.kernel.org with ESMTP
	id <S129671AbQJ2WCs>; Sun, 29 Oct 2000 17:02:48 -0500
Date: Sun, 29 Oct 2000 17:02:47 -0500 (EST)
From: adrian <jimbud@lostland.net>
To: linux-kernel@vger.kernel.org
Subject: Oops with v2.2.18-pre18
Message-ID: <Pine.BSO.4.21.0010291650510.3803-100000@getafix.lostland.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello folks,

   I've mainly been testing the 2.4.0-test kernels, but I decided to go
ahead and test the 2.2.18-pre18 for a bit of variety.  I hadn't noticed
any problems until I recompiled it without USB support.  After doing a
make modules, I got the following:

Unable to handle kernel paging request at virtual address bb6c8f1e
current->tss.cr3 = 0cac9000, %cr3 = 0cac9000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013050c>]
EFLAGS: 00010283
eax: cff9bb50   ebx: bb6c8f06   ecx: 0000001e   edx: cff80000
esi: 0067bf11   edi: c5521023   ebp: bb6c8f1e   esp: cca59f40
ds: 0018   es: 0018   ss: 0018
Process make (pid: 3749, process nr: 63, stackpage=cca59000)
Stack: c5521023 00000001 cff9bb50 c552101e 0067bf11 00000005 c012b508 cb9f7a40 
       cca59f88 cca59f88 c012b783 cb9f7a40 cca59f88 00000001 c5521000 c5521000 
       bfffde44 bfffdd8c c552101e 00000005 0067bf11 c012b880 c5521000 cb9f7a40 
Call Trace: [<c012b508>] [<c012b783>] [<c012b880>] [<c012993e>] [<c0109044>] 
Code: 8b 6d 00 8b 74 24 18 39 73 48 75 58 8b 74 24 24 39 73 0c 75 

>>EIP; c013050c <d_lookup+64/dc>   <=====
Trace; c012b508 <cached_lookup+10/54>
Trace; c012b783 <lookup_dentry+113/1e8>
Trace; c012b880 <__namei+28/58>
Trace; c012993e <sys_newstat+e/60>
Trace; c0109044 <system_call+34/38>
Code;  c013050c <d_lookup+64/dc>
00000000 <_EIP>:
Code;  c013050c <d_lookup+64/dc>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c013050f <d_lookup+67/dc>
   3:   8b 74 24 18               mov    0x18(%esp,1),%esi
Code;  c0130513 <d_lookup+6b/dc>
   7:   39 73 48                  cmp    %esi,0x48(%ebx)
Code;  c0130516 <d_lookup+6e/dc>
   a:   75 58                     jne    64 <_EIP+0x64> c0130570 <d_lookup+c8/dc>
Code;  c0130518 <d_lookup+70/dc>
   c:   8b 74 24 24               mov    0x24(%esp,1),%esi
Code;  c013051c <d_lookup+74/dc>
  10:   39 73 0c                  cmp    %esi,0xc(%ebx)
Code;  c013051f <d_lookup+77/dc>
  13:   75 00                     jne    15 <_EIP+0x15> c0130521 <d_lookup+79/dc>


Up until I started the recompile, I had run several tests (start up a
vmware session, run quake3, etc.) all of which gave no errors or
indications of instability.  Now, having vmware loaded might render this
moot, but I wanted to throw it out in case it would trigger any
lightbulbs.

Regards,
Adrian


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
