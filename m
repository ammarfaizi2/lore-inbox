Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWAIT7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWAIT7F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWAIT7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:59:04 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:4272 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751221AbWAIT7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:59:03 -0500
Date: Mon, 9 Jan 2006 13:58:53 -0600
To: paulus@samba.org
Cc: Olaf Hering <olh@suse.de>, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH]: ppowerpc: fix compile-time failure when EEH disabled.
Message-ID: <20060109195853.GH26221@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com> <20051006234624.GO29826@austin.ibm.com> <20060107212851.GA31731@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060107212851.GA31731@suse.de>
User-Agent: Mutt/1.5.6+20040907i
From: linas@austin.ibm.com (linas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul, please apply and fwd upstream.

--linas

Patch to fix compile problem reported by Olaf Herring: 
Kernel fails to compile when CONFIG_EMBEDDED is enabled,
but CONFIG_EEH disabled.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.15-mm1/include/asm-powerpc/eeh.h
===================================================================
--- linux-2.6.15-mm1.orig/include/asm-powerpc/eeh.h	2006-01-09 12:23:39.698773976 -0600
+++ linux-2.6.15-mm1/include/asm-powerpc/eeh.h	2006-01-09 12:28:44.404818949 -0600
@@ -113,12 +113,11 @@
 }
 
 static inline void pci_addr_cache_build(void) { }
-
 static inline void eeh_add_device_early(struct device_node *dn) { }
-
 static inline void eeh_add_device_late(struct pci_dev *dev) { }
-
 static inline void eeh_remove_device(struct pci_dev *dev) { }
+static inline void eeh_remove_bus_device(struct pci_dev *dev) { }
+static inline void eeh_add_device_tree_early(struct device_node *dn) { }
 
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
