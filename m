Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUCNXEr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 18:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUCNXEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 18:04:46 -0500
Received: from colino.net ([62.212.100.143]:37359 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262024AbUCNXEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 18:04:40 -0500
Date: Mon, 15 Mar 2004 00:02:37 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.4-bk3: Oops using pppd
Message-Id: <20040315000237.557a3792@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

got an oops with 2.6.4-bk3.

Command-line was:
/usr/sbin/pppd connect '/usr/sbin/chat -v ABORT "NO CARRIER" "" "AT&F" OK \
 "AT+CGDCONT=1,\"IP\",\"websfr\",\"0.0.0.0\",0,0" OK "ATDT*99#" CONNECT' \
 /dev/usb/acm/0 115200 defaultroute crtscts noauth deflate 0 asyncmap 0 \
 mtu 1500 mru 1500 noipdefault idle 600 2>/dev/null

Segmentation fault:
Oops: kernel access of bad area, sig: 11 [#1]
NIP: C0060B54 LR: C0060B2C SP: DBE57E60 REGS: dbe57db0 TRAP: 0301    Not
taintedMSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0002B281, DSISR: 40000000
TASK = dc18c660[6901] 'pppd' Last syscall: 5
GPR00: C0060B2C DBE57E60 DC18C660 00000000 DBE57E68 C0D6A5C0 DBEAEB10 00000000
GPR08: E7FFA810 C02B8788 00000001 0002B281 88000822
Call trace:
 [c00560f8] dentry_open+0x168/0x244
 [c0055f8c] filp_open+0x68/0x6c
 [c0056450] sys_open+0x68/0xa0
 [c0007cbc] ret_from_syscall+0x0/0x44


Ksymoops:
>>NIP; c0060b54 <chrdev_open+70/180>   <=====
 
>>GPR0; c0060b2c <chrdev_open+48/180>
>>GPR1; dbe57e60 <__crc_ide_auto_reduce_xfer+23be73/332b9b>
>>GPR2; dc18c660 <__crc_pci_pci_problems+3d8b9/105e48>
>>GPR4; dbe57e68 <__crc_ide_auto_reduce_xfer+23be7b/332b9b>
>>GPR5; c0d6a5c0 <__crc___wait_on_buffer+68ac5/831f2>
>>GPR6; dbeaeb10 <__crc_ide_auto_reduce_xfer+292b23/332b9b>
>>GPR8; e7ffa810 <__crc_vunmap+14d3e0/204f5f>
>>GPR9; c02b8788 <ppp_device_fops+0/58>
>>GPR12; 88000822 <__crc_sleep_on_timeout+3b752a/766020>

This didn't happen using 2.6.4.
HTH,
-- 
Colin
