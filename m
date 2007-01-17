Return-Path: <linux-kernel-owner+w=401wt.eu-S1751664AbXAQVbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbXAQVbI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 16:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbXAQVbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 16:31:08 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:45122 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbXAQVbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 16:31:07 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 17 Jan 2007 16:21:19 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Introduce two new maturlty levels:  DEPRECATED and OBSOLETE.
Message-ID: <Pine.LNX.4.64.0701171616140.4060@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  To go along with the EXPERIMENTAL kernel config status, introduce
two new states:  DEPRECATED and OBSOLETE.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  just adding these config variables to init/Kconfig shouldn't affect
the current build status, but it will allow developers to start to
move over their portions of tree at their convenience.

  in particular, features that are truly obsolete should be tagged as
OBSOLETE, as opposed to EXPERIMENTAL.


diff --git a/init/Kconfig b/init/Kconfig
index a3f83e2..f861efd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -29,9 +29,10 @@ config EXPERIMENTAL
 	  <file:Documentation/BUG-HUNTING>, and
 	  <file:Documentation/oops-tracing.txt> in the kernel source).

-	  This option will also make obsoleted drivers available. These are
-	  drivers that have been replaced by something else, and/or are
-	  scheduled to be removed in a future kernel release.
+	  At the moment, this option also makes obsolete drivers available,
+	  but such drivers really should be removed from the EXPERIMENTAL
+	  category and added to either DEPRECATED or OBSOLETE, depending
+	  on their status.

 	  Unless you intend to help test and develop a feature or driver that
 	  falls into this category, or you have a situation that requires
@@ -40,6 +41,23 @@ config EXPERIMENTAL
 	  you say Y here, you will be offered the choice of using features or
 	  drivers that are currently considered to be in the alpha-test phase.

+config DEPRECATED
+	bool "Prompt for deprecated code/drivers"
+	---help---
+	  Code that has tagged as "deprecated" is officially still available
+	  for use but will typically have already been scheduled for removal
+	  at some point, so it's in your best interests to start looking for
+	  an alternative.
+
+config OBSOLETE
+	bool "Prompt for obsolete code/drivers"
+	---help---
+	  Code that has tagged as "obsolete" is officially no longer supported
+	  and shouldn't play a part in any normal build, but those features
+	  might still be available if you absolutely need access to them.
+
+	  It's *strongly* discouraged to continue to depend on obsolete code.
+
 config BROKEN
 	bool


