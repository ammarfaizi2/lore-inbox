Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVJEAFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVJEAFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 20:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVJEAFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 20:05:10 -0400
Received: from over.co.us.ibm.com ([32.97.110.157]:28316 "EHLO
	bldfb.esmtp.ibm.com") by vger.kernel.org with ESMTP id S965045AbVJEAFI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 20:05:08 -0400
Date: Tue, 4 Oct 2005 19:04:26 -0500
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, johnrose@linux.ibm.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH] rpaphp: PCI Hotplug crash on PHB DLPAR add
Message-ID: <20051005000426.GY29826@austin.ibm.com>
References: <20051003185739.GR29826@austin.ibm.com> <20051004203019.GV29826@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051004203019.GV29826@austin.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a bug related to dlpar PHB add, after a PHB removal.

-- The crash was due to the PHB not having a pci_dn structure yet,
   when the phb is being added.

This code survived testing, of adding and removeig the PHB and all slots
underneath it, 17 times so far, as of this writing.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/drivers/pci/hotplug/rpadlpar_core.c	2005-10-04 16:40:12.539168432 -0500
+++ linux-2.6.14-rc2-git6/drivers/pci/hotplug/rpadlpar_core.c	2005-10-04 17:55:43.165471615 -0500
@@ -303,7 +303,7 @@
 {
 	struct pci_controller *phb;
 
-	if (PCI_DN(dn)->phb) {
+	if (PCI_DN(dn) && PCI_DN(dn)->phb) {
 		/* PHB already exists */
 		return -EINVAL;
 	}
