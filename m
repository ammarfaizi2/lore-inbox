Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbTJCWlh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbTJCWlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:41:37 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:44262 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261403AbTJCWle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:41:34 -0400
Subject: NULL pointer dereference in sysfs_hash_and_remove()
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1065220892.31749.39.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 04 Oct 2003 00:41:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I compiled 2.6.0-test6 and ran it on a laptop with cardbus.
I have an Xircom NIC and if I remove it during operation I get the bug
below.

I have yenta_socket and xircom_cb loaded as modules.


Unable to handle kernel NULL pointer dereference at virtual address 00000068
 printing eip:
c017cd75
*pde = 0df96067
*pte = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c017cd75>]    Not tainted
EFLAGS: 00010282
EIP is at sysfs_hash_and_remove+0x15/0x7d
eax: 00000000   ebx: c03109e4   ecx: 00000068   edx: ccf13dd0
esi: ccf13d60   edi: c03106e4   ebp: cea5c454   esp: cd0ede54
ds: 007b   es: 007b   ss: 0068
Process pccardd (pid: 528, threadinfo=cd0ec000 task=ce1c8740)
Stack: c017cd55 cd0ede60 c03109e4 ccf13d60 c017e231 ccf13d60 c02c390f ccf13d60 
       c0310a40 c017e368 ccf13d60 c0310a40 cfc2dc00 cfc2dd90 c023e937 cfc2dd98 
       c0310a40 cfc2dc00 cd0edeb4 c023b99a cfc2dc00 00000006 cfc2dc00 00000282 
Call Trace:
 [<c017cd55>] sysfs_get_dentry+0x65/0x70
 [<c017e231>] remove_files+0x31/0x40
 [<c017e368>] sysfs_remove_group+0x28/0x70
 [<c023e937>] netdev_unregister_sysfs+0x67/0x70
 [<c023b99a>] netdev_run_todo+0xea/0x1f0
 [<d086738c>] xircom_remove+0xac/0xd0 [xircom_cb]
 [<c01a9deb>] pci_device_remove+0x3b/0x40
 [<c01e9316>] device_release_driver+0x66/0x70
 [<c01e9455>] bus_remove_device+0x55/0xa0
 [<c01e81bd>] device_del+0x5d/0xa0
 [<c01e8213>] device_unregister+0x13/0x30
 [<c01a740e>] pci_destroy_dev+0x1e/0x70
 [<c01a752b>] pci_remove_behind_bridge+0x2b/0x40
 [<c0221b48>] shutdown_socket+0x88/0x120
 [<c0222263>] socket_remove+0x13/0x50
 [<c022230a>] socket_detect_change+0x6a/0x90
 [<c02224c8>] pccardd+0x198/0x220
 [<c011a980>] default_wake_function+0x0/0x30
 [<c011a980>] default_wake_function+0x0/0x30
 [<c0222330>] pccardd+0x0/0x220
 [<c01092a5>] kernel_thread_helper+0x5/0x10

Code: ff 48 68 78 63 89 34 24 8b 44 24 18 89 44 24 04 e8 66 ff ff 
 
-- 
/Martin
