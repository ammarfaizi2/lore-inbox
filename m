Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVFWOmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVFWOmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 10:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbVFWOmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 10:42:10 -0400
Received: from gw.alcove.fr ([81.80.245.157]:24528 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S262549AbVFWOmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 10:42:06 -0400
Subject: rmmod ohci1394 hangs in klist_remove
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 16:40:10 +0200
Message-Id: <1119537610.5848.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the ohci1394 module no longer works, sysrq+t shows:

rmmod         D 0FF7F724     0  6044   6038                     (NOTLB)
Call trace:
 [c00073ec] __switch_to+0x48/0x70
 [c02954c8] schedule+0x348/0x6f8
 [c02958f0] wait_for_completion+0x78/0xe4
 [c0294c1c] klist_remove+0x24/0x38
 [c01313ec] device_del+0x34/0xb8
 [c0131488] device_unregister+0x18/0x30
 [c0185afc] nodemgr_remove_ne+0x6c/0x88
 [c0185b2c] __nodemgr_remove_host_dev+0x14/0x28
 [c0131520] device_for_each_child+0x4c/0x74
 [c0185b68] nodemgr_remove_host_dev+0x28/0x6c
 [c018234c] __unregister_host+0xdc/0xe0
 [c0182e98] highlevel_remove_host+0x70/0xd8
 [c0181cc0] hpsb_remove_host+0x60/0x8c
 [e2218fec] ohci1394_pci_remove+0x5c/0x288 [ohci1394]
 [c00e02d0] pci_device_remove+0x60/0x64

This is with the latest Linus' git tree, on a Powerbook laptop (ppc).
Removing the module works with stock 2.4.12.

Thanks.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

