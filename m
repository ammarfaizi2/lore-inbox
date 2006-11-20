Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756594AbWKTCzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbWKTCzD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756819AbWKTCzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:55:03 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:28764 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1756594AbWKTCzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:55:01 -0500
Date: Sun, 19 Nov 2006 18:52:28 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: davej@codemonkey.org.uk, akpm <akpm@osdl.org>
Subject: [PATCH] agp-amd64: section mismatches with HOTPLUG=n
Message-Id: <20061119185228.ba33163f.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

When CONFIG_HOTPLUG=n, agp_amd64_resume() calls nforce3_agp_init(),
which is __devinit == __init, so has been discarded and is not
usable for resume.

WARNING: drivers/char/agp/amd64-agp.o - Section mismatch: reference to .init.text: from .text between 'agp_amd64_resume' (at offset 0x249) and 'amd64_tlbflush'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/char/agp/amd64-agp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2619-rc6g2.orig/drivers/char/agp/amd64-agp.c
+++ linux-2619-rc6g2/drivers/char/agp/amd64-agp.c
@@ -459,7 +459,7 @@ static const struct aper_size_info_32 nf
 
 /* Handle shadow device of the Nvidia NForce3 */
 /* CHECK-ME original 2.4 version set up some IORRs. Check if that is needed. */
-static int __devinit nforce3_agp_init(struct pci_dev *pdev)
+static int nforce3_agp_init(struct pci_dev *pdev)
 {
 	u32 tmp, apbase, apbar, aplimit;
 	struct pci_dev *dev1;


---
