Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbUCOVxA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUCOVwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:52:43 -0500
Received: from colino.net ([62.212.100.143]:30966 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262816AbUCOVvc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:51:32 -0500
Date: Mon, 15 Mar 2004 22:50:31 +0100
From: Colin Leroy <colin@colino.net>
To: linux-kernel@vger.kernel.org
Cc: linux-usb-devel@lists.sf.net
Subject: 2.6.4-bk3 and usb key: OOPS at removal
Message-Id: <20040315225031.224ccbaa@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Using 2.6.4-bk3 (the patch found at kernel.org), on an iBook G4 (ohci/ehci), i get oopses when disconnecting an usb key:

P: C008C130 LR: C008D32C SP: C0D9FD70 REGS: c0d9fcc0 TRAP: 0301    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000008, DSISR: 40000000
TASK = c0c46000[5] 'khubd' Last syscall: 120
GPR00: C008D32C C0D9FD70 C0C46000 00000000 C0249294 E748F1C0 C0334350 C0350000
GPR08: 0000000C C02BB82C C02B7580 E6E32650 42008028
Call trace:
 [c008d32c] sysfs_remove_link+0x14/0x24
 [c010a4e0] class_device_dev_unlink+0x38/0x3c
 [c010aa00] class_device_del+0xd0/0x12c
 [c010aa74] class_device_unregister+0x18/0x34
 [c015c2e4] scsi_remove_device+0x54/0xb0
 [c015b70c] scsi_forget_host+0x40/0x7c
 [c0154c70] scsi_remove_host+0x2c/0x6c
 [ea3b9614] storage_disconnect+0x50/0x6c [usb_storage]
 [c0198adc] usb_unbind_interface+0x88/0x8c
 [c0109a40] device_release_driver+0x84/0x88
 [c0109be0] bus_remove_device+0x74/0xd0
 [c01085a8] device_del+0xac/0x104
 [c019f538] usb_disable_device+0x9c/0xd8
 [c01997a8] usb_disconnect+0x9c/0x134
 [c019bbbc] hub_port_connect_change+0x28c/0x290

hth,
-- 
Colin
