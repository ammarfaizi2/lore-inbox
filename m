Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVJFXgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVJFXgr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 19:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVJFXgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 19:36:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3005 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932079AbVJFXgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 19:36:46 -0400
Date: Thu, 6 Oct 2005 18:36:22 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 10/22] ppc64: Crash on DLPAR PHB add
Message-ID: <20051006233622.GK29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006232032.GA29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


10-rpaphp-crashing.patch

This patch fixes a bug related to dlpar PHB add, after a PHB removal.

-- The crash was due to the PHB not having a pci_dn structure yet,
   when the phb is being added.

This code survived testing, of adding and removeig the PHB and all slots
underneath it, 17 times so far, as of this writing.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpadlpar_core.c	2005-10-06 17:50:27.631286278 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c	2005-10-06 17:53:50.226860151 -0500
@@ -303,7 +303,7 @@
 {
 	struct pci_controller *phb;
 
-	if (PCI_DN(dn)->phb) {
+	if (PCI_DN(dn) && PCI_DN(dn)->phb) {
 		/* PHB already exists */
 		return -EINVAL;
 	}
