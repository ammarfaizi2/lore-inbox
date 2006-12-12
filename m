Return-Path: <linux-kernel-owner+w=401wt.eu-S932540AbWLLW4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWLLW4K (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbWLLW4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:56:10 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:41302 "EHLO e1.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932540AbWLLW4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:56:08 -0500
Date: Tue, 12 Dec 2006 16:55:59 -0600
To: gregkh@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Revised [PATCH 1/2]: define inline for test of channel error state
Message-ID: <20061212225559.GL4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Per discussion, a revised patch. Silly me, the value was already
initialized in drivers/pci/probe.c and I'd been dragging along
a prehistoric version of the if checks.

--linas

[PATCH 1/2]: define inline for test of pci channel error state

Add very simple routine to indicate the pci channel error state.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 include/linux/pci.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6.19-git7/include/linux/pci.h
===================================================================
--- linux-2.6.19-git7.orig/include/linux/pci.h	2006-12-06 15:53:30.000000000 -0600
+++ linux-2.6.19-git7/include/linux/pci.h	2006-12-12 15:48:04.000000000 -0600
@@ -181,6 +181,11 @@ struct pci_dev {
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
