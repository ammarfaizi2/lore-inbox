Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267519AbRGMSVK>; Fri, 13 Jul 2001 14:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267521AbRGMSVA>; Fri, 13 Jul 2001 14:21:00 -0400
Received: from willow.seitz.com ([207.106.55.140]:47620 "EHLO willow.seitz.com")
	by vger.kernel.org with ESMTP id <S267519AbRGMSUx>;
	Fri, 13 Jul 2001 14:20:53 -0400
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Fri, 13 Jul 2001 14:20:54 -0400
To: linux-kernel@vger.kernel.org
Subject: Crash on boot with 2.4.6
Message-ID: <20010713142054.A5042@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

	2.4.6 crashes while calibrating the delay loop 
on a machine I've built it for, saying:

Calibrating delay loop... kernel bug at softirq.c:206!

	The machine that fails is a Cyrix MII 233MHz.
The chipset is a PIIX4.  I've tried building the kernel 
with the CPU set to 6x86MX as well as plain-jane 386, i
both have the same effect.  2.2.19 boots an runs correctly.

The output of the crash sent through ksymoops follows.

Ross Vandegrift
ross@willow.seitz.com

ksymoops 2.3.4 on i586 2.4.6.  Options used
     -v /home/usr/ross/kernels/willow/vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /home/usr/ross/kernels/willow/System.map (specified)

CPU:    0
EIP:    0010:[<c011454e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001d ebx: c02af2c0 ecx: 00000001 edx: c024e3e8
esi: c02af2c0 edi: 00000001 ebp: 00000000 esp: c0263f64
ds: 0018 es: 0018 ss: 0018
Process swapper (pid: 0, stackpage=c0263000)
Stack:  c0210a55 c0210af1 000000ce 00000009 c0295560 c0263fa8 c011435f
        c0295560 00000000 c0293900 00000000 c0107d4d 00000001 000994c1 c0105000
        c024df20 0008e000 c0106b1c 00000001 00000001 c024e3e8 000994c1 c0105000
Call Trace: [<c011435f>] [<c0107d4d>] [<c0105000>] [<c0106b1c>] [<c0105000>] [<c0105000>]
Code: 0f 0b 83 c4 0c 8b 43 08 85 c0 75 14 fb ff 73 10 8b 43 0c ff

>>EIP; c011454e <tasklet_hi_action+6e/b0>   <=====
Trace; c011435f <do_softirq+3f/68>
Trace; c0107d4d <do_IRQ+9d/b0>
Trace; c0105000 <_stext+0/0>
Trace; c0106b1c <ret_from_intr+0/7>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Code;  c011454e <tasklet_hi_action+6e/b0>
00000000 <_EIP>:
Code;  c011454e <tasklet_hi_action+6e/b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0114550 <tasklet_hi_action+70/b0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0114553 <tasklet_hi_action+73/b0>
   5:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0114556 <tasklet_hi_action+76/b0>
   8:   85 c0                     test   %eax,%eax
Code;  c0114558 <tasklet_hi_action+78/b0>
   a:   75 14                     jne    20 <_EIP+0x20> c011456e <tasklet_hi_action+8e/b0>
Code;  c011455a <tasklet_hi_action+7a/b0>
   c:   fb                        sti
Code;  c011455b <tasklet_hi_action+7b/b0>
   d:   ff 73 10                  pushl  0x10(%ebx)
Code;  c011455e <tasklet_hi_action+7e/b0>
  10:   8b 43 0c                  mov    0xc(%ebx),%eax
Code;  c0114561 <tasklet_hi_action+81/b0>
  13:   ff 00                     incl   (%eax)

Kernel panic: Aiee, killing interrupt handler!
