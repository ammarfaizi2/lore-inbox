Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTHYC5q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 22:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbTHYC5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 22:57:46 -0400
Received: from [62.75.136.201] ([62.75.136.201]:14739 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S261408AbTHYC5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 22:57:44 -0400
Message-ID: <3F499638.5040105@g-house.de>
Date: Mon, 25 Aug 2003 06:53:12 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030815
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: parport_pc Oops with 2.6.0-test3
References: <3F40B665.2010407@g-house.de> <20030824030043.729a5786.akpm@osdl.org>
In-Reply-To: <20030824030043.729a5786.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Can you retest on 2.6.0-test4?

i have, but with no (?) changes:

prinz:~$ modprobe parport_pc
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO 
[PCSPP,TRISTATE,COMPAT,ECP]
prinz:~$ rmmod parport_pc
Unable to handle kernel paging request at virtual address e1a4f164
  printing eip:
  e1a4757a
  *pde = 1fe2a067
  *pte = 00000000
  Oops: 0000 [#1]
  CPU:    0
  EIP:    0060:[<e1a4757a>]    Tainted: P
  EFLAGS: 00010282
  EIP is at cleanup_module+0xa/0x50 [parport_pc]
  eax: deab8980   ebx: e1a4b2c0   ecx: 00000000   edx: e1a4b2c0
  esi: 00000880   edi: 00000000   ebp: c0320318   esp: dae47f50
  ds: 007b   es: 007b   ss: 0068
  Process rmmod (pid: 618, threadinfo=dae46000 task=dcda4640)
  Stack: dae47f70 e1a4b2c0 00000880 c01346a8 e1a4b2c0 bffffce0 \
         0000003b 00000000
         70726170 5f74726f c0006370 dfd69940 db6be180 dfd60280 \
         40014000 40015000
         40015000 dfd60280 dfd69940 dfd69960 00000000 dae46000 \
         00148634 dfd69940
  Call Trace:
  [<c01346a8>] sys_delete_module+0x138/0x1b0
  [<c010929b>] syscall_call+0x7/0xb

Code: 8b 15 64 f1 a4 e1 89 c3 85 d2 74 29 85 db 74 15 8d b6 00 00
Segmentation fault
prinz:~$

(oh, yes, it's tainted again. the nvidia.ko module. but it oopsed with a 
non-tainted 2.6.0-test3 too: 
http://christian.go4more.de/parport/parport_oops.txt )

thank you for your time,
Christian.
-- 
BOFH excuse #161:

monitor VLF leakage

