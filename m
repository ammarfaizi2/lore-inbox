Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275082AbTHQItP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 04:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275084AbTHQItP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 04:49:15 -0400
Received: from imap.gmx.net ([213.165.64.20]:9690 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S275082AbTHQItL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 04:49:11 -0400
From: Holger Schurig <holgerschurig@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: devfs/ppp oops on linux-2.6.0-test3 ?
Date: Sun, 17 Aug 2003 10:49:09 +0200
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308171049.09562.holgerschurig@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my gentoo system I call linux with the following commands:

image=/boot/vmlinuz
        label=Gentoo26
        root=/dev/hda5
        append="devfs=mount apm=off"
        read-only

And at startup time, I get the following oops:

PPP generic driver version 2.4.2
devfs_mk_cdev: could not append to parent for ppp
failed to register PPP device (-17)
PPP generic driver version 2.4.2
failed to register PPP device (-16)
ppp_async: Unknown symbol ppp_channel_index
ppp_async: Unknown symbol ppp_register_channel
ppp_async: Unknown symbol ppp_input
ppp_async: Unknown symbol ppp_input_error
ppp_async: Unknown symbol ppp_output_wakeup
ppp_async: Unknown symbol ppp_unregister_channel
ppp_async: Unknown symbol ppp_unit_number

Unable to handle kernel paging request at virtual address e083f080
 printing eip:
c0151bc6
*pde = 1ff6d067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[cdev_get+22/112]    Not tainted
EIP:    0060:[<c0151bc6>]    Not tainted
EFLAGS: 00010282
EIP is at cdev_get+0x16/0x70
eax: df004e00   ebx: e083f080   ecx: df004e00   edx: c0151ac0
esi: 00006c00   edi: 00000000   ebp: df0efeb4   esp: df0efea8
ds: 007b   es: 007b   ss: 0068
Process pppd (pid: 3424, threadinfo=df0ee000 task=df0f1980)
Stack: df0eff68 df1824e0 00006c00 df0efec0 c0151ad1 df004e00 df0efef0 
c0257ba8
       00006c00 df004e00 00000006 df004e00 c0151ab0 000000ff 6c0056ac 
00000000
       00000000 00000000 df0eff14 c015192c dfff1c00 00006c00 df0eff04 
00000000
Call Trace:
 [exact_lock+17/32] exact_lock+0x11/0x20
 [<c0151ad1>] exact_lock+0x11/0x20
 [kobj_lookup+248/432] kobj_lookup+0xf8/0x1b0
 [<c0257ba8>] kobj_lookup+0xf8/0x1b0
 [exact_match+0/16] exact_match+0x0/0x10
 [<c0151ab0>] exact_match+0x0/0x10
 [chrdev_open+236/352] chrdev_open+0xec/0x160
 [<c015192c>] chrdev_open+0xec/0x160
 [devfs_open+155/192] devfs_open+0x9b/0xc0
 [<c01ab2cb>] devfs_open+0x9b/0xc0
 [dentry_open+298/448] dentry_open+0x12a/0x1c0
 [<c01487ca>] dentry_open+0x12a/0x1c0
 [filp_open+102/112] filp_open+0x66/0x70
 [<c0148696>] filp_open+0x66/0x70
 [sys_open+83/144] sys_open+0x53/0x90
 [<c0148a83>] sys_open+0x53/0x90
 [syscall_call+7/11] syscall_call+0x7/0xb
 [<c01091af>] syscall_call+0x7/0xb

Code: 83 3b 02 ba 01 00 00 00 74 40 ff 83 c0 00 00 00 31 c0 85 d2

and so on (the OOPS happens several times)



Attached you'll find a more elaborate syslog-snippet.

pppd is 2.4.1

CONFIG_DEVFS_FS=y
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPPOE=m
