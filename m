Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbTIIV5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264605AbTIIV5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 17:57:14 -0400
Received: from smtp1.fre.skanova.net ([195.67.227.94]:18385 "EHLO
	smtp1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S264604AbTIIV5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 17:57:09 -0400
Subject: 2.6.0-test5: Was: [2.6.0-test4-mm5] [BLUETOOTH] rfcomm: kernel BUG
	at include/net/sock.h:459!
From: Fredrik Noring <noring@nocrew.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: NoCrew
Message-Id: <1063144449.2935.15.camel@h9n1fls20o980.bredband.comhem.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 23:54:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2003-09-03 20:46:45 cb-lkml wrote:
> I get this BUG (twice) during boot when the rfcomm init script runs.

I get a similar crash (three times) and now this also shows up in 2.6.0-test5.

	Fredrik

Bluetooth: Core ver 2.2
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: HCI USB driver ver 2.4
hci_usb: probe of 1-2:1 failed with error -5
hci_usb: probe of 1-2:2 failed with error -5
drivers/usb/core/usb.c: registered new driver hci_usb
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
------------[ cut here ]------------
kernel BUG at include/net/sock.h:459!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<e0921786>]    Not tainted
EFLAGS: 00010286
EIP is at l2cap_sock_alloc+0xb6/0xc0 [l2cap]
eax: e09ad400   ebx: dc700d54   ecx: dc5f6d98   edx: dc700d54
esi: 00000000   edi: ffffffa3   ebp: dc5f6d98   esp: debdfeec
ds: 007b   es: 007b   ss: 0068
Process sdpd (pid: 1005, threadinfo=debde000 task=def4e690)
Stack: dc5f6d98 00000000 00000024 000000d0 dc5f6d98 00000000 e09217fa dc5f6d98
       00000000 000000d0 e09ad604 e09a10db dc5f6d98 00000000 0000001f 00000005
       00000000 c024f5f6 dc5f6d98 00000000 00000000 0804d000 ffffff9f 00000000
Call Trace:
 [<e09217fa>] l2cap_sock_create+0x6a/0x90 [l2cap]
 [<e09a10db>] bt_sock_create+0x7b/0xc0 [bluetooth]
 [<c024f5f6>] sock_create+0xe6/0x220
 [<c024f75b>] sys_socket+0x2b/0x60
 [<c0250871>] sys_socketcall+0xc1/0x2c0
 [<c011011a>] do_gettimeofday+0x1a/0x90
 [<c010aa39>] sysenter_past_esp+0x52/0x71
 
Code: 0f 0b cb 01 5c 48 92 e0 eb 81 83 ec 10 89 5c 24 0c 8b 5c 24
 <3>hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb dc5fed60 err -22


