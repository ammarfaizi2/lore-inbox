Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSKYQFe>; Mon, 25 Nov 2002 11:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSKYQFe>; Mon, 25 Nov 2002 11:05:34 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:43176 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261354AbSKYQFd> convert rfc822-to-8bit; Mon, 25 Nov 2002 11:05:33 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.20-rc2-ac3 oops (causer is DRM 4.3.x code)
Date: Mon, 25 Nov 2002 17:12:41 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211251711.59882.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, Hi Arjan,

with XFree 4.2.1, r128 modular, get's loaded at startup of X, and then:

Nov 25 17:06:41 codeman kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 25 17:06:41 codeman kernel: cbc6a8c4
Nov 25 17:06:41 codeman kernel: *pde = 081d9067
Nov 25 17:06:41 codeman kernel: Oops: 0002
Nov 25 17:06:41 codeman kernel: CPU:    0
Nov 25 17:06:41 codeman kernel: EIP:    0010:[<cbc6a8c4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 25 17:06:41 codeman kernel: EFLAGS: 00013282
Nov 25 17:06:41 codeman kernel: eax: e51285e0   ebx: c5160980   ecx: 00000011   
edx: 00000000
Nov 25 17:06:41 codeman kernel: esi: cc6adf14   edi: dffbdb80   ebp: c4997800   
esp: cc6adee0
Nov 25 17:06:41 codeman kernel: ds: 0018   es: 0018   ss: 0018
Nov 25 17:06:41 codeman kernel: Process XFree86 (pid: 15852, 
stackpage=cc6ad000)
Nov 25 17:06:41 codeman kernel: Stack: 00020000 00000000 b86d2ce8 cc6adf6c 
c4997800 dffbdb80 cbc6aaad c4997800 
Nov 25 17:06:41 codeman kernel:        cc6adf14 cc6ac000 00000300 c4997800 
c83f8d00 00000001 00000898 00000001 
Nov 25 17:06:41 codeman kernel:        80000000 00000001 00100000 00002710 
00000010 00000000 00000640 003ab100 
Nov 25 17:06:41 codeman kernel: Call Trace: [<cbc6aaad>] [<cbc657ca>] 
[<cbc6aa18>] [sys_ioctl+637/708] [system_call+51/56] 
Nov 25 17:06:41 codeman kernel: Code: 89 02 8b 47 24 c7 80 40 01 00 00 00 00 
00 00 8b 47 24 8b 90 


>>EIP; cbc6a8c4 <[r128]r128_do_init_cce+744/7f8>   <=====

>>ebx; c5160980 <[smbfs].data.end+248291/6d47971>
>>ebp; c4997800 <[eepro100].bss.end+6b269/c3ac9>

Trace; cbc6aaad <[r128]r128_cce_init+95/b8>
Trace; cbc657ca <[r128]r128_ioctl+102/110>
Trace; cbc6aa18 <[r128]r128_cce_init+0/b8>

Code;  cbc6a8c4 <[r128]r128_do_init_cce+744/7f8>
00000000 <_EIP>:
Code;  cbc6a8c4 <[r128]r128_do_init_cce+744/7f8>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  cbc6a8c6 <[r128]r128_do_init_cce+746/7f8>
   2:   8b 47 24                  mov    0x24(%edi),%eax
Code;  cbc6a8c9 <[r128]r128_do_init_cce+749/7f8>
   5:   c7 80 40 01 00 00 00      movl   $0x0,0x140(%eax)
Code;  cbc6a8d0 <[r128]r128_do_init_cce+750/7f8>
   c:   00 00 00 
Code;  cbc6a8d3 <[r128]r128_do_init_cce+753/7f8>
   f:   8b 47 24                  mov    0x24(%edi),%eax
Code;  cbc6a8d6 <[r128]r128_do_init_cce+756/7f8>
  12:   8b 90 00 00 00 00         mov    0x0(%eax),%edx


ciao, Marc
