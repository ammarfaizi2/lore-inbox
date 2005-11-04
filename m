Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161032AbVKDBCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161032AbVKDBCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030569AbVKDAwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:52:00 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:63635
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161012AbVKDAvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:51:32 -0500
Date: Thu, 3 Nov 2005 18:51:17 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 19/42]: ppc64: bugfix: crash on PHB add
Message-ID: <20051104005117.GA26991@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

19-rpaphp-crashing.patch

This patch fixes a bug related to dlpar PHB add, after a PHB removal.

-- The crash was due to the PHB not having a pci_dn structure yet,
   when the phb is being added.

This code survived testing, of adding and removeig the PHB and all slots
underneath it, 17 times so far, as of this writing.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

emailed to 
To: paulus@samba.org
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
        johnrose@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] rpaphp: PCI Hotplug crash on PHB DLPAR add

on 4 October 2005


Index: linux-2.6.14-git3/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.14-git3.orig/drivers/pci/hotplug/rpadlpar_core.c	2005-11-02 14:29:02.115685162 -0600
+++ linux-2.6.14-git3/drivers/pci/hotplug/rpadlpar_core.c	2005-11-02 14:35:52.800111285 -0600
@@ -306,7 +306,7 @@
 {
 	struct pci_controller *phb;
 
-	if (PCI_DN(dn)->phb) {
+	if (PCI_DN(dn) && PCI_DN(dn)->phb) {
 		/* PHB already exists */
 		return -EINVAL;
 	}
