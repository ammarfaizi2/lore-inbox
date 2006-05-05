Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWEEU6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWEEU6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWEEU6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 16:58:07 -0400
Received: from [206.222.18.114] ([206.222.18.114]:32962 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751777AbWEEU6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 16:58:05 -0400
Date: Sat, 6 May 2006 04:58:05 +0800
Message-ID: <10915800.1146862685034.JavaMail.websites@opensubscriber>
From: wang_yulei@hotmail.com
Reply-To: wang_yulei@hotmail.com
To: linux-kernel@vger.kernel.org
Subject: GPIO PA24 on AT91RM9200
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The GPIO PA24 is Ok to be an input IO.
But when I tried to 
request_irq(AT91_PIN_PA24, ....)
The kernal will crash with the follwoing message.
******************************************
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c0294000
[00000000] *pgd=202a1031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: keyi2c_driver pcf8574_driver sam_driver
CPU: 0
PC is at __wake_up_common+0x28/0x7c
LR is at __init_begin+0x3fff8000/0x2c
pc : [<c00314c4>]    lr : [<00000000>]    Not tainted
sp : c1671d58  ip : c1671d84  fp : c1671d80
r10: 00000001  r9 : 00000000  r8 : 00000000
r7 : 00000038  r6 : bf008404  r5 : 00000000  r4 : 00000001
r3 : 00000000  r2 : 00000001  r1 : 00000001  r0 : bf008404
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment user
Control: C000317F  Table: 20294000  DAC: 00000015
Process keyi2c_test (pid: 780, stack limit = 0xc1670194)
Stack: (0xc1671d58 to 0xc1672000)
1d40:                                                       60000013 00000000 
1d60: 00000000 00000038 c1671e40 00000002 c1671e40 c1671d98 c1671d84 c0031544 
1d80: c00314ac 00000000 00000001 c1671dc4 c1671d9c bf0074f0 c0031528 c15e2d40 
1da0: c0021930 c0206778 00000038 c1671e40 c0205c80 fefff400 c1671de0 c1671dc8 
1dc0: c00219b4 c00218f4 00000039 c0206778 00000001 c1671e0c c1671de4 c0029f84 
1de0: c002197c ffffffff fefff000 00000002 00000000 c1671e40 c1670000 c0205c18 
1e00: c1671e3c c1671e10 c0021c14 c0029f2c 00000000 00000000 ffffffff fefff000 
1e20: 00000002 00000000 bf007aa8 00000000 c1671ea4 c1671e40 c0020960 c0021bd4 
1e40: 01000000 fefff400 00000018 00000001 c15e2d40 40000013 00000038 00000000 
1e60: bf007aa8 c1670000 00000000 c1671ea4 c1671e88 c1671e88 c0022074 c0022078 
1e80: a0000013 ffffffff c15e2d40 00000038 00000000 bf007444 c1671ecc c1671ea8 
1ea0: c0022140 c0021fa8 fefff000 06000000 000003ff 00000000 c16400a0 400701fc 
1ec0: c1671f0c c1671ed0 bf0078ac c0022094 00000000 c15ab840 c169dbf4 00000000 
1ee0: 00000000 c007447c 00000000 c16400a0 c169dbf4 c02752a0 c1542f6c 00000000 
1f00: c1671f30 c1671f10 c006a238 c0074340 00000002 00000004 00000002 c15ba000 
1f20: c0020e44 c1671f84 c1671f34 c006a3b0 c006a144 c1542f6c c02752a0 00000004 
1f40: c0286040 c1670000 00000101 00000001 00000000 400701fc c1671f84 c1671f68 
1f60: c006a40c c0086658 00000001 00000003 00000001 00000001 c1671fa4 c1671f88 
1f80: c006a56c c006a37c 00000003 000085f4 000109cc 00000005 00000000 c1671fa8 
1fa0: c0020cc0 c006a538 00000003 c00270fc 00008874 00000002 00000001 00000002 
1fc0: 00000003 000085f4 000109cc beba2ddc 00008518 beba2dd4 400701fc 00000001 
1fe0: 000109bc beba2d00 00008728 4005f908 40000010 00008874 dd97fdd6 89b6a995 
Backtrace: 
[<c003149c>] (__wake_up_common+0x0/0x7c) from [<c0031544>] (__wake_up+0x2c/0x34)
[<c0031518>] (__wake_up+0x0/0x34) from [<bf0074f0>] (keyi2c_dect_func+0xac/0xf0 [keyi2c_driver])
 r4 = 00000001 
[<c00218e4>] (__do_irq+0x0/0x88) from [<c00219b4>] (do_simple_IRQ+0x48/0x70)
 r8 = FEFFF400  r7 = C0205C80  r6 = C1671E40  r5 = 00000038
 r4 = C0206778 
[<c002196c>] (do_simple_IRQ+0x0/0x70) from [<c0029f84>] (gpio_irq_handler+0x68/0x90)
 r6 = 00000001  r5 = C0206778  r4 = 00000039 
[<c0029f1c>] (gpio_irq_handler+0x0/0x90) from [<c0021c14>] (asm_do_IRQ+0x50/0x148)
[<c0021bc4>] (asm_do_IRQ+0x0/0x148) from [<c0020960>] (__irq_svc+0x20/0x60)
[<c0021f98>] (setup_irq+0x0/0xec) from [<c0022140>] (request_irq+0xbc/0xd8)
 r7 = BF007444  r6 = 00000000  r5 = 00000038  r4 = C15E2D40
[<c0022084>] (request_irq+0x0/0xd8) from [<bf0078ac>] (keyi2c_open+0xd4/0x118 [keyi2c_driver])
[<c0074330>] (chrdev_open+0x0/0x164) from [<c006a238>] (dentry_open+0x104/0x238)
 r8 = 00000000  r7 = C1542F6C  r6 = C02752A0  r5 = C169DBF4
 r4 = C16400A0 
[<c006a134>] (dentry_open+0x0/0x238) from [<c006a3b0>] (filp_open+0x44/0x4c)
 r8 = C0020E44  r7 = C15BA000  r6 = 00000002  r5 = 00000004
 r4 = 00000002 
[<c006a36c>] (filp_open+0x0/0x4c) from [<c006a56c>] (sys_open+0x44/0x88)
 r4 = 00000001 
[<c006a528>] (sys_open+0x0/0x88) from [<c0020cc0>] (ret_fast_syscall+0x0/0x2c)
 r7 = 00000005  r6 = 000109CC  r5 = 000085F4  r4 = 00000003
Code: e1a0a001 e1a04002 e1a08003 e59b9004 (e59e7000) 
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
******************************************

Anybody has idea about it


--
This message was sent on behalf of wang_yulei@hotmail.com at openSubscriber.com
http://www.opensubscriber.com/messages/linux-kernel@vger.kernel.org/topic.html
