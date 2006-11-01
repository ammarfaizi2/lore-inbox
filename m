Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752582AbWKAXyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbWKAXyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbWKAXyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:54:25 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:27347 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752580AbWKAXyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:54:24 -0500
Date: Wed, 1 Nov 2006 17:54:17 -0600
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/2]: Renumber PCI error enums to start at zero
Message-ID: <20061101235417.GV6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg,

This is a low-prioriity patch to fix an annoying numbering mistake. 
Please apply this (and the next patch) at net convenience.

--linas

Subject: [PATCH 1/2]: Renumber PCI error enums to start at zero

Renumber the PCI error enums to start at zero for "normal/online".
This allows un-initialized pci channel state (which defaults to zero)
to be interpreted as "normal".  Add very simple routine to check
state, just in case this ever has to be fiddled with again.

Signed-off-by: Linas Vepstas <linas@linas.org>

----
 include/linux/pci.h |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.19-rc4-git3/include/linux/pci.h
===================================================================
--- linux-2.6.19-rc4-git3.orig/include/linux/pci.h	2006-11-01 16:15:49.000000000 -0600
+++ linux-2.6.19-rc4-git3/include/linux/pci.h	2006-11-01 16:20:49.000000000 -0600
@@ -86,15 +86,20 @@ typedef unsigned int __bitwise pci_chann
 
 enum pci_channel_state {
 	/* I/O channel is in normal state */
-	pci_channel_io_normal = (__force pci_channel_state_t) 1,
+	pci_channel_io_normal = (__force pci_channel_state_t) 0,
 
 	/* I/O to channel is blocked */
-	pci_channel_io_frozen = (__force pci_channel_state_t) 2,
+	pci_channel_io_frozen = (__force pci_channel_state_t) 1,
 
 	/* PCI card is dead */
-	pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
+	pci_channel_io_perm_failure = (__force pci_channel_state_t) 2,
 };
 
+static inline int pci_channel_offline(pci_channel_state_t state)
+{
+	return (state != pci_channel_io_normal);
+}
+
 typedef unsigned short __bitwise pci_bus_flags_t;
 enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MSI = (__force pci_bus_flags_t) 1,
