Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272540AbTGZPLr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 11:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270140AbTGZPIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 11:08:11 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:15082 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S270143AbTGZPGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 11:06:23 -0400
Date: Sat, 26 Jul 2003 11:21:35 -0400
From: Matt Zimmerman <mdz@debian.org>
To: linux-kernel@vger.kernel.org
Subject: OOPS: dcache_dir_lseek, 2.4.21 and 2.4.20
Message-ID: <20030726152135.GL8935@alcor.net>
Mail-Followup-To: Matt Zimmerman <mdz@debian.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see this from time to time when I leave a UML instance running for a long
period of time (I get this oops on the host, not the UML, of course).  It is
not immediately reproducible, but has happened several times under similar
circumstances.  Previously I had seen it on 2.4.20 as well.

-- 
 - mdz


Unable to handle kernel NULL pointer dereference at virtual address 00000000
c014c4d2
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c014c4d2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: c22762e0   ecx: cbb159e8   edx: c22762e0
esi: 00000002   edi: 00000000   ebp: c22762c0   esp: c663df84
ds: 0018   es: 0018   ss: 0018
Process linux (pid: 936, stackpage=c663d000)
Stack: fffffff2 c22762c0 00000000 c014c3c0 c63e97c0 ffffffea c013d7b5 c63e97c0 
       00000002 00000000 00000000 c663c000 00000002 a691bafc a691ba8c c0108eff 
       00000037 00000002 00000000 00000002 a691bafc a691ba8c 00000013 0000002b 
Call Trace:    [<c014c3c0>] [<c013d7b5>] [<c0108eff>]
Code: 89 10 89 42 04 8b 54 24 1c 8b 42 08 8b 40 08 8d 48 68 ff 40 


>>EIP; c014c4d2 <dcache_dir_lseek+112/140>   <=====

>>ebx; c22762e0 <_end+1f61168/20504f08>
>>ecx; cbb159e8 <_end+b800870/20504f08>
>>edx; c22762e0 <_end+1f61168/20504f08>
>>ebp; c22762c0 <_end+1f61148/20504f08>
>>esp; c663df84 <_end+6328e0c/20504f08>

Trace; c014c3c0 <dcache_dir_lseek+0/140>
Trace; c013d7b5 <sys_lseek+65/a0>
Trace; c0108eff <system_call+33/38>

Code;  c014c4d2 <dcache_dir_lseek+112/140>
00000000 <_EIP>:
Code;  c014c4d2 <dcache_dir_lseek+112/140>   <=====
   0:   89 10                     mov    %edx,(%eax)   <=====
Code;  c014c4d4 <dcache_dir_lseek+114/140>
   2:   89 42 04                  mov    %eax,0x4(%edx)
Code;  c014c4d7 <dcache_dir_lseek+117/140>
   5:   8b 54 24 1c               mov    0x1c(%esp,1),%edx
Code;  c014c4db <dcache_dir_lseek+11b/140>
   9:   8b 42 08                  mov    0x8(%edx),%eax
Code;  c014c4de <dcache_dir_lseek+11e/140>
   c:   8b 40 08                  mov    0x8(%eax),%eax
Code;  c014c4e1 <dcache_dir_lseek+121/140>
   f:   8d 48 68                  lea    0x68(%eax),%ecx
Code;  c014c4e4 <dcache_dir_lseek+124/140>
  12:   ff 40 00                  incl   0x0(%eax)


