Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWFTWfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWFTWfv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWFTW3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53476 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751334AbWFTW2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:28:53 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
       <linux-pci@atrey.karlin.mff.cuni.cz>, <discuss@x86-64.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/25] msi: Make the msi boolean tests return either 0 or 1.
Reply-To: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 20 Jun 2006 16:28:18 -0600
Message-Id: <1150842520235-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.0.gc07e
In-Reply-To: <11508425191063-git-send-email-ebiederm@xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the output of the msi tests to be stored directly
in a bit field.  If you don't do this a value greater than
one will be truncated and become 0.  Changing true to false
with bizare consequences.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/pci/msi.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/msi.h b/drivers/pci/msi.h
index 56951c3..9b31d4c 100644
--- a/drivers/pci/msi.h
+++ b/drivers/pci/msi.h
@@ -110,8 +110,8 @@ #define multi_msi_capable(control) \
 	(1 << ((control & PCI_MSI_FLAGS_QMASK) >> 1))
 #define multi_msi_enable(control, num) \
 	control |= (((num >> 1) << 4) & PCI_MSI_FLAGS_QSIZE);
-#define is_64bit_address(control)	(control & PCI_MSI_FLAGS_64BIT)
-#define is_mask_bit_support(control)	(control & PCI_MSI_FLAGS_MASKBIT)
+#define is_64bit_address(control)	(!!(control & PCI_MSI_FLAGS_64BIT))
+#define is_mask_bit_support(control)	(!!(control & PCI_MSI_FLAGS_MASKBIT))
 #define msi_enable(control, num) multi_msi_enable(control, num); \
 	control |= PCI_MSI_FLAGS_ENABLE
 
-- 
1.4.0.gc07e

