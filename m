Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbTESS3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 14:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTESS3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 14:29:15 -0400
Received: from mail.cs.umn.edu ([128.101.34.202]:47314 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S262584AbTESS3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 14:29:13 -0400
Subject: oops 2.4.20 e1000?
From: "Scott M. Dier" <sdier@cs.umn.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1053369725.1868.94.camel@gurney.cs.umn.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 19 May 2003 13:42:05 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC me on replies, thanks!]

I've been trying to debug an issue out here and we've ruled out memory
with memtest86 so far.

I got a OOPS report that looks like it might be some sort of ethernet 
card issue....

Any ideas would be welcome.

---
Unable to handle kernel NULL pointer dereference at virtual address
00000000    printing eip:
c01a24db
*pde = 00000000
Oops: 0
CPU: 0
EIP:  0010:[<c01a24db>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS:  00010202
eax: 0000000c   ebx: f63da505  ecx: 0000000e  edx: 00000000
esi: f63da505   edi: f6dd0800  ebp: f6ce9380  esp: c0259eec
ds: 0018  es: 0018  ss: 0018
Process swapper (pid: 0, stackpage=c0259000)
Stack:  f63da505 f63da505 0000009e f890b6f3 f63da505 f6dd6800 f6dd6960
f6ce9380
        f63da505 f6dd6960 0000000a 00000000 00000018 f63da505 000000e0
c0258000
        00000460 00000038 f6dd6800 f6dd6a0c f890b2cb f6dd6960 f6dd1ac0
14000001
Call trace: [<f890b6f3>] [<f890bc2b>] [<c010a1a4>] [<c010a397>]
[<c0106d80>]
 [<c0106d80>] [<c0106d80>] [<c0106d80>] [<c0106dac>] [<c0106e12>]
[<c0105000>]
 [<c0105050>]
Code: f6 02 01 74 20 89 d6 83 c7 70 b9 06 00 00 00 fc a8 00 f3 a6
 
 
>>EIP; c01a24db <eth_type_trans+3f/b0>   <=====
 
>>ebx; f63da505 <END_OF_CODE+159bb116/????>
>>esi; f63da505 <END_OF_CODE+159bb116/????>
>>edi; f6dd0800 <END_OF_CODE+163b1411/????>
>>ebp; f6ce9380 <END_OF_CODE+162c9f91/????>
>>esp; c0259eec <init_task_union+1eec/2000>
 
Trace; f890b6f3 <END_OF_CODE+17eec304/????>
Trace; f890bc2b <END_OF_CODE+17eec83c/????>
Trace; c010a1a4 <handle_IRQ_event+50/7c>
Trace; c010a397 <do_IRQ+a7/ec>
Trace; c0106d80 <default_idle+0/34>
Trace; c0106d80 <default_idle+0/34>
Trace; c0106d80 <default_idle+0/34>
Trace; c0106d80 <default_idle+0/34>
Trace; c0106dac <default_idle+2c/34>
Trace; c0106e12 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105050 <rest_init+50/54>
 
Code;  c01a24db <eth_type_trans+3f/b0>
00000000 <_EIP>:
Code;  c01a24db <eth_type_trans+3f/b0>   <=====
   0:   f6 02 01                  testb  $0x1,(%edx)   <=====
Code;  c01a24de <eth_type_trans+42/b0>
   3:   74 20                     je     25 <_EIP+0x25> c01a2500
<eth_type_trans+64/b0>
Code;  c01a24e0 <eth_type_trans+44/b0>
   5:   89 d6                     mov    %edx,%esi
Code;  c01a24e2 <eth_type_trans+46/b0>
   7:   83 c7 70                  add    $0x70,%edi
Code;  c01a24e5 <eth_type_trans+49/b0>
   a:   b9 06 00 00 00            mov    $0x6,%ecx
Code;  c01a24ea <eth_type_trans+4e/b0>
   f:   fc                        cld
Code;  c01a24eb <eth_type_trans+4f/b0>
  10:   a8 00                     test   $0x0,%al
Code;  c01a24ed <eth_type_trans+51/b0>
  12:   f3 a6                     repz cmpsb %es:(%edi),%ds:(%esi)
 
  <0>:Kernel panic: Aiee, killing interrupt handler!


-- 
Scott Dier <sdier@cs.umn.edu>
CS/IT Systems Staff

