Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVDFFiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVDFFiN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 01:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVDFFiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 01:38:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43973 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262106AbVDFFh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 01:37:57 -0400
Date: Wed, 6 Apr 2005 01:37:53 -0400
From: Dave Jones <davej@redhat.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: chelsio build failure
Message-ID: <20050406053753.GC15168@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

building this sucker as a module caused grief.

drivers/net/chelsio/cxgb2.c:113: error: `__mod_pci_device_table' aliased
to external symbol `t1_pci_tbl'.

This seems to do the trick. (untested beyond compile)

Signed-off-by: Dave Jones <davej@redhat.com>

		Dave

--- 2.6.12rc2mm1/drivers/net/chelsio/cxgb2.c~	2005-04-06 01:30:07.000000000 -0400
+++ 2.6.12rc2mm1/drivers/net/chelsio/cxgb2.c	2005-04-06 01:30:20.000000000 -0400
@@ -110,7 +110,6 @@ static char driver_version[] = "2.1.0";
 MODULE_DESCRIPTION(MODULE_DESC);
 MODULE_AUTHOR("Chelsio Communications");
 MODULE_LICENSE("GPL");
-MODULE_DEVICE_TABLE(pci, t1_pci_tbl);
 
 static int dflt_msg_enable = DFLT_MSG_ENABLE;
 
--- 2.6.12rc2mm1/drivers/net/chelsio/subr.c~	2005-04-06 01:30:25.000000000 -0400
+++ 2.6.12rc2mm1/drivers/net/chelsio/subr.c	2005-04-06 01:30:35.000000000 -0400
@@ -307,6 +307,7 @@ struct pci_device_id t1_pci_tbl[] = {
 	CH_DEVICE(10, 1, CH_BRD_N210_1F),
 	{ 0, }
 };
+MODULE_DEVICE_TABLE(pci, t1_pci_tbl);
 
 /*
  * Return the board_info structure with a given index.  Out-of-range indices
