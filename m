Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSKYUUx>; Mon, 25 Nov 2002 15:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265667AbSKYUUx>; Mon, 25 Nov 2002 15:20:53 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:64731 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265675AbSKYUUv> convert rfc822-to-8bit; Mon, 25 Nov 2002 15:20:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [BUG] 2.4.20-rc2-ac3 oops (causer is DRM 4.3.x code)
Date: Mon, 25 Nov 2002 21:27:49 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@nl.linux.org>
References: <200211251711.59882.m.c.p@wolk-project.de> <200211251810.57377.m.c.p@wolk-project.de> <200211252114.32569.m.c.p@wolk-project.de>
In-Reply-To: <200211252114.32569.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211252127.33083.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 November 2002 21:14, Marc-Christian Petersen wrote:

Hi Arjan,

> Ok Arjan, I am trying this out right now. Hang on please.
ok, removed those #if's and #endif's:

Nov 25 21:23:17 codeman kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000000
Nov 25 21:23:17 codeman kernel: c654a8c4
Nov 25 21:23:17 codeman kernel: *pde = 065ef067
Nov 25 21:23:17 codeman kernel: Oops: 0002
Nov 25 21:23:17 codeman kernel: CPU:    0
Nov 25 21:23:17 codeman kernel: EIP:    0010:[<c654a8c4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 25 21:23:17 codeman kernel: EFLAGS: 00013282
Nov 25 21:23:17 codeman kernel: eax: e51265e0   ebx: c2e6a900   ecx: 00000011   
edx: 00000000
Nov 25 21:23:17 codeman kernel: esi: c70b3f14   edi: dffbd880   ebp: c28cf000   
esp: c70b3ee0
Nov 25 21:23:17 codeman kernel: ds: 0018   es: 0018   ss: 0018
Nov 25 21:23:17 codeman kernel: Process XFree86 (pid: 27442, 
stackpage=c70b3000)
Nov 25 21:23:17 codeman kernel: Stack: 00020000 00000000 b80f2628 c70b3f6c 
c28cf000 dffbd880 c654aad7 c28cf000
Nov 25 21:23:17 codeman kernel:        c70b3f14 c70b2000 00000300 c28cf000 
c5a6a680 00000001 00000898 00000001
Nov 25 21:23:17 codeman kernel:        80000000 00000001 00100000 00002710 
00000010 00000000 00000640 003ab100
Nov 25 21:23:17 codeman kernel: Call Trace: [<c654aad7>] [<c65457ca>] 
[<c654aa40>] [sys_ioctl+637/708] [system_call+51/56]
Nov 25 21:23:17 codeman kernel: Code: 89 02 8b 47 24 c7 80 40 01 00 00 00 00 
00 00 8b 47 24 8b 90


>>EIP; c654a8c4 <[r128]r128_do_init_cce+744/7f8>   <=====

>>ebx; c5160980 <[smbfs].data.end+248291/6d47971>
>>ebp; c2e6a900 <[eepro100].bss.end+2ae349/5e3aa9>

Trace; c654aad7 <[r128]r128_cce_init+97/c0>
Trace; c65457ca <[r128]r128_ioctl+102/110>
Trace; c654aa40 <[r128]r128_cce_init+0/c0>

Code;  c654a8c4 <[r128]r128_do_init_cce+744/7f8>
00000000 <_EIP>:
Code;  c654a8c4 <[r128]r128_do_init_cce+744/7f8>   <=====
   0:   89 02                     mov    %eax,(%edx)   <=====
Code;  c654a8c6 <[r128]r128_do_init_cce+746/7f8>
   2:   8b 47 24                  mov    0x24(%edi),%eax
Code;  c654a8c9 <[r128]r128_do_init_cce+749/7f8>
   5:   c7 80 40 01 00 00 00      movl   $0x0,0x140(%eax)
Code;  c654a8d0 <[r128]r128_do_init_cce+750/7f8>
   c:   00 00 00
Code;  c654a8d3 <[r128]r128_do_init_cce+753/7f8>
   f:   8b 47 24                  mov    0x24(%edi),%eax
Code;  c654a8d6 <[r128]r128_do_init_cce+756/7f8>
  12:   8b 90 00 00 00 00         mov    0x0(%eax),%edx


root@codeman:[/] # lspci -v|grep ATI
01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE/SG 
(prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage 128 AIW


ciao, Marc
