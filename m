Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbULAVs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbULAVs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 16:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbULAVs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 16:48:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:53010 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261462AbULAVsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 16:48:06 -0500
Date: Wed, 1 Dec 2004 22:48:02 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] i386 mca.c: small cleanups
Message-ID: <20041201214801.GV2650@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following cleanups:
- make spinlock mca_lock static
- make struct mca_standard_resources static


diffstat output:
 arch/i386/kernel/mca.c |    4 ++--
 include/asm-i386/mca.h |    3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/asm-i386/mca.h.old	2004-12-01 08:02:57.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/asm-i386/mca.h	2004-12-01 08:03:10.000000000 +0100
@@ -40,7 +40,4 @@
  */
 #define MCA_NUMADAPTERS (MCA_MAX_SLOT_NR+3)
 
-/* lock to protect access to the MCA registers */
-extern spinlock_t mca_lock;
-
 #endif
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/mca.c.old	2004-12-01 08:03:18.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/mca.c	2004-12-01 08:03:44.000000000 +0100
@@ -62,7 +62,7 @@
  *
  * Yes - Alan
  */
-spinlock_t mca_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t mca_lock = SPIN_LOCK_UNLOCKED;
 
 /* Build the status info for the adapter */
 
@@ -119,7 +119,7 @@
 
 /*--------------------------------------------------------------------*/
 
-struct resource mca_standard_resources[] = {
+static struct resource mca_standard_resources[] = {
 	{ "system control port B (MCA)", 0x60, 0x60 },
 	{ "arbitration (MCA)", 0x90, 0x90 },
 	{ "card Select Feedback (MCA)", 0x91, 0x91 },

