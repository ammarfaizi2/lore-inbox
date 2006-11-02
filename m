Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWKBBJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWKBBJB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 20:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422879AbWKBBJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 20:09:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62410 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752623AbWKBBJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 20:09:00 -0500
Date: Wed, 1 Nov 2006 19:08:54 -0600
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/2 v2]: Renumber PCI error enums to start at zero
Message-ID: <20061102010854.GA3623@austin.ibm.com>
References: <20061101235417.GV6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101235417.GV6360@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 05:54:17PM -0600, Linas Vepstas wrote:
[...] 
Fix brain-disengaged error.

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
+++ linux-2.6.19-rc4-git3/include/linux/pci.h	2006-11-01 18:43:14.000000000 -0600
@@ -86,13 +86,13 @@ typedef unsigned int __bitwise pci_chann
 
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
 
 typedef unsigned short __bitwise pci_bus_flags_t;
@@ -180,6 +180,11 @@ struct pci_dev {
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
+static inline int pci_channel_offline(struct pci_dev *pdev)
+{
+	return (pdev->error_state != pci_channel_io_normal);
+}
+
 static inline struct pci_cap_saved_state *pci_find_saved_cap(
 	struct pci_dev *pci_dev,char cap)
 {
