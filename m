Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbVKDAzh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbVKDAzh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 19:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbVKDAzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 19:55:18 -0500
Received: from h-67-100-217-179.hstqtx02.covad.net ([67.100.217.179]:33172
	"EHLO mail.gnucash.org") by vger.kernel.org with ESMTP
	id S1161030AbVKDAys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 19:54:48 -0500
Date: Thu, 3 Nov 2005 18:54:47 -0600
From: Linas Vepstas <linas@linas.org>
To: paulus@samba.org, linuxppc64-dev@ozlabs.org
Cc: johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 37/42]: ppc64: set up the RTAS token just like the rest of them.
Message-ID: <20051104005447.GA27138@mail.gnucash.org>
Reply-To: linas@austin.ibm.com
References: <20051103235918.GA25616@mail.gnucash.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

237-eeh-bridge-token.patch

Minor: the rtas-bridge toekn should be set up the same way that all the 
other tokens rtas tokens are set up.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

Index: linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.14-git3.orig/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:47:07.798456202 -0600
+++ linux-2.6.14-git3/arch/powerpc/platforms/pseries/eeh.c	2005-11-02 14:47:38.997080468 -0600
@@ -84,6 +84,7 @@
 static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
 static int ibm_get_config_addr_info;
+static int ibm_configure_bridge;
 
 static int eeh_subsystem_enabled;
 
@@ -626,18 +627,14 @@
 rtas_configure_bridge(struct pci_dn *pdn)
 {
 	int config_addr;
-	int token = rtas_token ("ibm,configure-bridge");
 	int rc;
 
-	if (token == RTAS_UNKNOWN_SERVICE)
-		return;
-	
 	/* Use PE configuration address, if present */
 	config_addr = pdn->eeh_config_addr;
 	if (pdn->eeh_pe_config_addr)
 		config_addr = pdn->eeh_pe_config_addr;
 
-	rc = rtas_call(token,3,1, NULL,
+	rc = rtas_call(ibm_configure_bridge,3,1, NULL,
 	               config_addr,
 	               BUID_HI(pdn->phb->buid),
 	               BUID_LO(pdn->phb->buid));
@@ -789,6 +786,7 @@
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
 	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
+	ibm_configure_bridge = rtas_token ("ibm,configure-bridge");
 
 	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
 		return;
