Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbTIGVrY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTIGVrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:47:17 -0400
Received: from mail.netbeat.de ([62.208.140.19]:56327 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S261508AbTIGVrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:47:06 -0400
Subject: [2.6-test4-mm5] modprobe e100 after ifplugd -> oops
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: netdev@oss.sgi.com
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1062971256.13515.9.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 07 Sep 2003 23:47:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using kernel 2.6.0-test4-mm5 I got on oops when inserting the e100
module after running ifplugd. 

When I load the module before starting ifplugd everything is ok.
I didn't check yet, if it occurs with previous kernel versions too.

after a modprobe

 kernel: Intel(R) PRO/100 Network Driver - version 2.3.18-k1
 kernel: Copyright (c) 2003 Intel Corporation
 kernel:
 kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000004
 kernel:  printing eip:
 kernel: d0a5250f
 kernel: *pde = 00000000
 kernel: Oops: 0000 [#1]
 kernel: PREEMPT
 kernel: CPU:    0
 kernel: EIP:    0060:[__crc_pcmcia_request_irq+5867872/7156875]    Not
tainted VLI
 kernel: EFLAGS: 00010203
 kernel: EIP is at e100_free_rfd_pool+0x14/0xdc [e100]
 kernel: eax: 00000000   ebx: 00000000   ecx: 00000020   edx: 00000000
 kernel: esi: c7b95200   edi: c7b95220   ebp: 00000000   esp: ccd13e78
 kernel: ds: 007b   es: 007b   ss: 0068
 kernel: Process ifplugd (pid: 774, threadinfo=ccd12000 ta:
 kernel: Stack: c1367454 c7b95200 c7b95200 c7b95000 d0a527c6 c7b95200
fffffff4 d0a51a7e
 kernel:        c7b95200 00000003 ccd13ec8 c3e6b940 0008d42c c7b95000
00000000 00001003
 kernel:        00000000 c028eb1a c7b95000 ccd12000 c02939ea c7b95000
00001002 c02900b8
 kernel: Call Trace:
 kernel:  [__crc_pcmcia_request_irq+5868567/7156875]
e100_clear_pools+0x1a/0x2a [e100]
 kernel:  [__crc_pcmcia_request_irq+5865167/7156875]
e100_open+0x13b/0x198 [e100]
 kernel:  [dev_open+121/134] dev_open+0x79/0x86
 kernel:  [dev_mc_upload+37/67] dev_mc_upload+0x25/0x43
 kernel:  [dev_change_flags+81/288] dev_change_flags+0x51/0x120
 kernel:  [devinet_ioctl+643/1538] devinet_ioctl+0x283/0x602
 kernel:  [inet_ioctl+178/248] inet_ioctl+0xb2/0xf8
 kernel:  [sock_ioctl+0/676] sock_ioctl+0x0/0x2a4
 kernel:  [sock_ioctl+245/676] sock_ioctl+0xf5/0x2a4
 kernel:  [sock_ioctl+0/676] sock_ioctl+0x0/0x2a4
 kernel:  [sys_ioctl+253/626] sys_ioctl+0xfd/0x272
 kernel:  [sys_munmap+68/100] sys_munmap+0x44/0x64
 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
 kernel:
 kernel: Code: 00 c7 43 40 00 00 00 00 c7 43 3c 00 00 00 00 8b 5c 24 10
83 c4 14 c3 57 56 53 83 ec 04 8b 74 24 14 8d 7e 20 8b 5e 20 39 fb
74 5a <8b> 53 04 39 1a 0f 85 b0 00 00 00 8b 03 39 58 04 0f 85 98 00 00
 kernel:  <7>e100: selftest OK.
 kernel: e100: eth0: Intel(R) PRO/100 Network Connection
 kernel:   Hardware receive checksums enabled
 kernel:

Config:
# CONFIG_DGRS is not set
CONFIG_EEPRO100=m
# CONFIG_EEPRO100_PIO is not set
CONFIG_E100=m
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set

System is a Thinkpad R40 2722.


Jan

(Please CC on reply)

-- 
Jan Ischebeck <mail@jan-ischebeck.de>

