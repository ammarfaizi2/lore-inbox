Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264992AbUGBVmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264992AbUGBVmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUGBVky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:40:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:31378 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264992AbUGBVkb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:40:31 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <10888043512721@kroah.com>
Date: Fri, 2 Jul 2004 14:39:12 -0700
Message-Id: <10888043523764@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1786, 2004/07/02 13:32:11-07:00, roland@topspin.com

[PATCH] PCI: Add some PCI Express constants to pci.h

This patch adds some PCI Express register constants to <linux/pci.h>

For my device, setting the Max_Read_Request_Size value in the PCI
Express device control register makes a huge performance difference.
I wanted my driver code that does this to be a little more
self-documenting than:

	pci_read_config_word(mdev->pdev, cap + 8, &val);
	val = (val & ~(5 << 12)) | (5 << 12);

I went a little overboard and added all the basic device register
fields.  If desired I could go even further overboard and add the
link, slot and root registers as well.

This patch is based on Matthew Wilcox's patch for pciutils, corrected
for some PCI Express spec 1.0a changes.

Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 include/linux/pci.h |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+)


diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2004-07-02 14:24:47 -07:00
+++ b/include/linux/pci.h	2004-07-02 14:24:47 -07:00
@@ -321,6 +321,50 @@
 #define  PCI_X_STATUS_266MHZ	0x40000000	/* 266 MHz capable */
 #define  PCI_X_STATUS_533MHZ	0x80000000	/* 533 MHz capable */
 
+/* PCI Express capability registers */
+
+#define PCI_EXP_FLAGS		2	/* Capabilities register */
+#define PCI_EXP_FLAGS_VERS	0x000f	/* Capability version */
+#define PCI_EXP_FLAGS_TYPE	0x00f0	/* Device/Port type */
+#define  PCI_EXP_TYPE_ENDPOINT	0x0	/* Express Endpoint */
+#define  PCI_EXP_TYPE_LEG_END	0x1	/* Legacy Endpoint */
+#define  PCI_EXP_TYPE_ROOT_PORT 0x4	/* Root Port */
+#define  PCI_EXP_TYPE_UPSTREAM	0x5	/* Upstream Port */
+#define  PCI_EXP_TYPE_DOWNSTREAM 0x6	/* Downstream Port */
+#define  PCI_EXP_TYPE_PCI_BRIDGE 0x7	/* PCI/PCI-X Bridge */
+#define PCI_EXP_FLAGS_SLOT	0x0100	/* Slot implemented */
+#define PCI_EXP_FLAGS_IRQ	0x3e00	/* Interrupt message number */
+#define PCI_EXP_DEVCAP		4	/* Device capabilities */
+#define  PCI_EXP_DEVCAP_PAYLOAD	0x07	/* Max_Payload_Size */
+#define  PCI_EXP_DEVCAP_PHANTOM	0x18	/* Phantom functions */
+#define  PCI_EXP_DEVCAP_EXT_TAG	0x20	/* Extended tags */
+#define  PCI_EXP_DEVCAP_L0S	0x1c0	/* L0s Acceptable Latency */
+#define  PCI_EXP_DEVCAP_L1	0xe00	/* L1 Acceptable Latency */
+#define  PCI_EXP_DEVCAP_ATN_BUT	0x1000	/* Attention Button Present */
+#define  PCI_EXP_DEVCAP_ATN_IND	0x2000	/* Attention Indicator Present */
+#define  PCI_EXP_DEVCAP_PWR_IND	0x4000	/* Power Indicator Present */
+#define  PCI_EXP_DEVCAP_PWR_VAL	0x3fc0000 /* Slot Power Limit Value */
+#define  PCI_EXP_DEVCAP_PWR_SCL	0xc000000 /* Slot Power Limit Scale */
+#define PCI_EXP_DEVCTL		8	/* Device Control */
+#define  PCI_EXP_DEVCTL_CERE	0x0001	/* Correctable Error Reporting En. */
+#define  PCI_EXP_DEVCTL_NFERE	0x0002	/* Non-Fatal Error Reporting Enable */
+#define  PCI_EXP_DEVCTL_FERE	0x0004	/* Fatal Error Reporting Enable */
+#define  PCI_EXP_DEVCTL_URRE	0x0008	/* Unsupported Request Reporting En. */
+#define  PCI_EXP_DEVCTL_RELAX_EN 0x0010 /* Enable relaxed ordering */
+#define  PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
+#define  PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
+#define  PCI_EXP_DEVCTL_PHANTOM	0x0200	/* Phantom Functions Enable */
+#define  PCI_EXP_DEVCTL_AUX_PME	0x0400	/* Auxiliary Power PM Enable */
+#define  PCI_EXP_DEVCTL_NOSNOOP_EN 0x0800  /* Enable No Snoop */
+#define  PCI_EXP_DEVCTL_READRQ	0x7000	/* Max_Read_Request_Size */
+#define PCI_EXP_DEVSTA		10	/* Device Status */
+#define  PCI_EXP_DEVSTA_CED	0x01	/* Correctable Error Detected */
+#define  PCI_EXP_DEVSTA_NFED	0x02	/* Non-Fatal Error Detected */
+#define  PCI_EXP_DEVSTA_FED	0x04	/* Fatal Error Detected */
+#define  PCI_EXP_DEVSTA_URD	0x08	/* Unsupported Request Detected */
+#define  PCI_EXP_DEVSTA_AUXPD	0x10	/* AUX Power Detected */
+#define  PCI_EXP_DEVSTA_TRPND	0x20	/* Transactions Pending */
+
 /* Extended Capabilities (PCI-X 2.0 and Express) */
 #define PCI_EXT_CAP_ID(header)		(header & 0x0000ffff)
 #define PCI_EXT_CAP_VER(header)		((header >> 16) & 0xf)

