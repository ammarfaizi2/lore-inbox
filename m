Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbTDQNoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTDQNoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 09:44:15 -0400
Received: from [81.91.128.66] ([81.91.128.66]:42183 "HELO agahbodan.com")
	by vger.kernel.org with SMTP id S261390AbTDQNoN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 09:44:13 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: farshad khoshkhui <farshad_kh@yahoo.com>
Reply-To: farshad_kh@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: softirq.c bug
Date: Thu, 17 Apr 2003 18:23:00 +0430
User-Agent: KMail/1.4.3
Cc: farshad_kh@yahoo.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304171823.00338.farshad_kh@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using 2.5.67, on a duron 1200 box , my keyboard lock up when a ppp 
connection goes down and also
pppd process won't die and kill, and the box don't event shutdown!
I also found that my ethernet (rtl8139 NIC) don't work while CONFIG_ACPI=y
it's response to other stations arp requests but don't add others to arp table

Apr 17 17:44:58 pars1 kernel: kernel BUG at kernel/softirq.c:105!
Apr 17 17:44:58 pars1 kernel: invalid operand: 0000 [#1]
Apr 17 17:44:58 pars1 kernel: CPU:    0
Apr 17 17:44:58 pars1 kernel: EIP:    0060:[<c011e575>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 17 17:44:58 pars1 kernel: EFLAGS: 00010002
Apr 17 17:44:58 pars1 kernel: eax: 00000001   ebx: cdf30000   ecx: 00000001  
edx: 00000000
Apr 17 17:44:58 pars1 kernel: esi: 00000000   edi: 00000000   ebp: 00000001   
esp: cdf31ef4
Apr 17 17:44:58 pars1 kernel: ds: 007b   es: 007b   ss: 0068
Apr 17 17:44:58 pars1 kernel: Stack: cdc0d800 ce83ec02 c8f71000 00000000 
cdc0d894 00000049 c8f71000
00000049
Apr 17 17:44:58 pars1 kernel:        c8f71000 cdc0d800 c8f719e4 cdf30000 
ce83e501 cdc0d800 c8f71000
00000246
Apr 17 17:44:58 pars1 kernel:        ce927a31 c8f71000 c8f71000 c01c0c5d 
c8f71000 c8f810c0 00000000
00000002
Apr 17 17:44:58 pars1 kernel:  [<ce83ec02>] ppp_async_push+0xa2/0x190 
[ppp_async]
Apr 17 17:44:58 pars1 kernel:  [<ce83e501>] ppp_asynctty_wakeup+0x31/0x70 
[ppp_async]
Apr 17 17:44:58 pars1 kernel:  [<ce927a31>] uart_flush_buffer+0x71/0x80 [core]
Apr 17 17:44:58 pars1 kernel:  [<c01c0c5d>] do_tty_hangup+0x35d/0x3b0
Apr 17 17:44:58 pars1 kernel:  [<c0129033>] worker_thread+0x1e3/0x2d0
Apr 17 17:44:58 pars1 kernel:  [<c01c0900>] do_tty_hangup+0x0/0x3b0
Apr 17 17:44:58 pars1 kernel:  [<c0117700>] default_wake_function+0x0/0x20
Apr 17 17:44:58 pars1 kernel:  [<c010aa4e>] ret_from_fork+0x6/0x14
Apr 17 17:44:58 pars1 kernel:  [<c0117700>] default_wake_function+0x0/0x20
Apr 17 17:44:58 pars1 kernel:  [<c0128e50>] worker_thread+0x0/0x2d0
Apr 17 17:44:58 pars1 kernel:  [<c0108abd>] kernel_thread_helper+0x5/0x18
Apr 17 17:44:58 pars1 kernel: Code: 0f 0b 69 00 c4 f8 28 c0 eb c2 90 53 89 c1 
9c 5b fa b8 01 00


>>EIP; c011e575 <local_bh_enable+55/60>   <=====

>>ebx; cdf30000 <__crc_prepare_to_wait+e7cf1/359db1>
>>esp; cdf31ef4 <__crc_prepare_to_wait+e9be5/359db1>

Code;  c011e575 <local_bh_enable+55/60>
00000000 <_EIP>:
Code;  c011e575 <local_bh_enable+55/60>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c011e577 <local_bh_enable+57/60>
   2:   69 00 c4 f8 28 c0         imul   $0xc028f8c4,(%eax),%eax
Code;  c011e57d <local_bh_enable+5d/60>
   8:   eb c2                     jmp    ffffffcc <_EIP+0xffffffcc>
Code;  c011e57f <local_bh_enable+5f/60>
   a:   90                        nop
Code;  c011e580 <raise_softirq+0/40>
   b:   53                        push   %ebx
Code;  c011e581 <raise_softirq+1/40>
   c:   89 c1                     mov    %eax,%ecx
Code;  c011e583 <raise_softirq+3/40>
   e:   9c                        pushf
Code;  c011e584 <raise_softirq+4/40>
   f:   5b                        pop    %ebx
Code;  c011e585 <raise_softirq+5/40>
  10:   fa                        cli
Code;  c011e586 <raise_softirq+6/40>
  11:   b8 01 00 00 00            mov    $0x1,%eax



