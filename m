Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbTGBIfV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 04:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264835AbTGBIfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 04:35:20 -0400
Received: from a089197.adsl.hansenet.de ([213.191.89.197]:24241 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S264833AbTGBIfO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 04:35:14 -0400
Message-ID: <3F029CA1.3010001@tu-harburg.de>
Date: Wed, 02 Jul 2003 10:49:37 +0200
From: Jan Dittmer <jan.dittmer@tu-harburg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: maxk@qualcomm.com, marcel@holtmann.org
Subject: Bluetooth rfcomm tty layer initialization
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was in 2.5 for a while. Happens when loading the rfcomm module.
Anything more needed for this? All bluetooth stuff is modular, and I'm 
using devfs.
I cannot capture the start of the rfcomm loading, the messages are 
scrolling far too fast and I don't have a serial console handy right 
now, sorry.

Thanks,

Jan

from dmesg:

Bluetooth: Core ver 2.2
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.1
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.0
Bluetooth: BNEP filters: protocol multicast

[ cutted some unrelated info ]

devfs_mk_cdev: could not append to parent for bluetooth/rfcomm/1
[ cutted 253 lines]
devfs_mk_cdev: could not append to parent for bluetooth/rfcomm/255
Bluetooth: RFCOMM TTY layer initialized
------------[ cut here ]------------
kernel BUG at include/linux/module.h:297!
invalid operand: 0000 [#1]
PREEMPT SMP
CPU:    0
EIP:    0060:[<d0cf3e2d>]    Not tainted VLI
EFLAGS: 00010246
EIP is at rfcomm_sock_alloc+0x59/0x10c [rfcomm]
eax: 00000000   ebx: cc9d9b00   ecx: 00000002   edx: d0cfb300
esi: 000000d0   edi: 00000003   ebp: 00000001   esp: cc987f14
ds: 007b   es: 007b   ss: 0068
Process rfcomm (pid: 1518, threadinfo=cc986000 task=ccd8f940)
Stack: 0000000c d0b0f384 d0cf3f17 ccc45180 00000003 000000d0 d0b02112 
ccc45180
        00000003 0000007c ccc45180 00000001 c03ea720 ffffffa3 c026e056 
ccc45180
        00000003 0000001f 00000001 cc987fa8 00000000 ffffff9f c026e195 
0000001f
Call Trace:
  [<d0cf3f17>] rfcomm_sock_create+0x37/0x58 [rfcomm]
  [<d0b02112>] bt_sock_create+0xaa/0x104 [bluetooth]
  [<c026e056>] sock_create+0x14e/0x270
  [<c026e195>] sys_socket+0x1d/0x50
  [<c026ef3f>] sys_socketcall+0x9f/0x240
  [<c0109afd>] error_code+0x2d/0x38
  [<c0109073>] syscall_call+0x7/0xb

Code: b2 cf d0 83 bb 28 01 00 00 00 74 08 0f 0b cb 01 0c 71 cf d0 89 83 
28 01 00 00 85 c0 74 40 50 e8 0e 11 44 ef 83 c4 04 85 c0 75 08 <0f> 0b 
29 01 23 70 cf d0 b8 00 e0 ff ff 21 e0 ff 40 14 8b 50 10

