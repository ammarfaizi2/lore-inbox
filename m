Return-Path: <linux-kernel-owner+w=401wt.eu-S1754217AbWLRXAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbWLRXAH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbWLRXAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:00:07 -0500
Received: from mx1.cs.washington.edu ([128.208.5.52]:41143 "EHLO
	mx1.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbWLRXAG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:00:06 -0500
X-Greylist: delayed 1392 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 18:00:06 EST
Date: Mon, 18 Dec 2006 14:36:23 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] ppc : Use syslog macro for the printk log level.
In-Reply-To: <Pine.LNX.4.64.0612181658070.8277@localhost.localdomain>
Message-ID: <Pine.LNX.4.64N.0612181434220.3836@attu4.cs.washington.edu>
References: <Pine.LNX.4.64.0612181658070.8277@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the remaining hard-coded printk levels.

Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 arch/arm/lib/io-acorn.S         |    4 +++-
 arch/arm/vfp/vfphw.S            |    8 +++++---
 arch/arm26/lib/io-acorn.S       |    4 +++-
 drivers/isdn/i4l/isdn_bsdcomp.c |    4 ++--
 drivers/net/bsd_comp.c          |    4 ++--
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/lib/io-acorn.S b/arch/arm/lib/io-acorn.S
index 1b197ea..19656f1 100644
--- a/arch/arm/lib/io-acorn.S
+++ b/arch/arm/lib/io-acorn.S
@@ -13,11 +13,13 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
+#define KERN_WARNING	"<4>"
+
 		.text
 		.align
 
 .Liosl_warning:
-		.ascii	"<4>insl/outsl not implemented, called from %08lX\0"
+		.ascii	KERN_WARNING "insl/outsl not implemented, called from %08lX\0"
 		.align
 
 /*
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index e51e667..0dd4077 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -18,13 +18,15 @@ #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
 #include "../kernel/entry-header.S"
 
+#define KERN_DEBUG	"<7>"
+
 	.macro	DBGSTR, str
 #ifdef DEBUG
 	stmfd	sp!, {r0-r3, ip, lr}
 	add	r0, pc, #4
 	bl	printk
 	b	1f
-	.asciz  "<7>VFP: \str\n"
+	.asciz  KERN_DEBUG "VFP: \str\n"
 	.balign 4
 1:	ldmfd	sp!, {r0-r3, ip, lr}
 #endif
@@ -37,7 +39,7 @@ #ifdef DEBUG
 	add	r0, pc, #4
 	bl	printk
 	b	1f
-	.asciz  "<7>VFP: \str\n"
+	.asciz  KERN_DEBUG "VFP: \str\n"
 	.balign 4
 1:	ldmfd	sp!, {r0-r3, ip, lr}
 #endif
@@ -52,7 +54,7 @@ #ifdef DEBUG
 	add	r0, pc, #4
 	bl	printk
 	b	1f
-	.asciz  "<7>VFP: \str\n"
+	.asciz  KERN_DEBUG "VFP: \str\n"
 	.balign 4
 1:	ldmfd	sp!, {r0-r3, ip, lr}
 #endif
diff --git a/arch/arm26/lib/io-acorn.S b/arch/arm26/lib/io-acorn.S
index 5f62ade..6547f37 100644
--- a/arch/arm26/lib/io-acorn.S
+++ b/arch/arm26/lib/io-acorn.S
@@ -11,6 +11,8 @@ #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/hardware.h>
 
+#define KERN_WARNING	"<4>"
+
 		.text
 		.align
 
@@ -40,7 +42,7 @@ #include <asm/hardware.h>
 		.endm
 
 .iosl_warning:
-		.ascii	"<4>insl/outsl not implemented, called from %08lX\0"
+		.ascii	KERN_WARNING "insl/outsl not implemented, called from %08lX\0"
 		.align
 
 /*
diff --git a/drivers/isdn/i4l/isdn_bsdcomp.c b/drivers/isdn/i4l/isdn_bsdcomp.c
index a20f33b..948f514 100644
--- a/drivers/isdn/i4l/isdn_bsdcomp.c
+++ b/drivers/isdn/i4l/isdn_bsdcomp.c
@@ -430,7 +430,7 @@ #ifdef DEBUG
 static unsigned short *lens_ptr(struct bsd_db *db, int idx)
 {
 	if ((unsigned int) idx > (unsigned int) db->maxmaxcode) {
-		printk (KERN_DEBUG "<9>ppp: lens_ptr(%d) > max\n", idx);
+		printk (KERN_DEBUG "ppp: lens_ptr(%d) > max\n", idx);
 		idx = 0;
 	}
 	return lens_ptrx (db, idx);
@@ -439,7 +439,7 @@ static unsigned short *lens_ptr(struct b
 static struct bsd_dict *dict_ptr(struct bsd_db *db, int idx)
 {
 	if ((unsigned int) idx >= (unsigned int) db->hsize) {
-		printk (KERN_DEBUG "<9>ppp: dict_ptr(%d) > max\n", idx);
+		printk (KERN_DEBUG "ppp: dict_ptr(%d) > max\n", idx);
 		idx = 0;
 	}
 	return dict_ptrx (db, idx);
diff --git a/drivers/net/bsd_comp.c b/drivers/net/bsd_comp.c
index 7845eaf..af3f83f 100644
--- a/drivers/net/bsd_comp.c
+++ b/drivers/net/bsd_comp.c
@@ -531,7 +531,7 @@ static unsigned short *lens_ptr(struct b
   {
     if ((unsigned int) idx > (unsigned int) db->maxmaxcode)
       {
-	printk ("<9>ppp: lens_ptr(%d) > max\n", idx);
+	printk (KERN_DEBUG "ppp: lens_ptr(%d) > max\n", idx);
 	idx = 0;
       }
     return lens_ptrx (db, idx);
@@ -541,7 +541,7 @@ static struct bsd_dict *dict_ptr(struct 
   {
     if ((unsigned int) idx >= (unsigned int) db->hsize)
       {
-	printk ("<9>ppp: dict_ptr(%d) > max\n", idx);
+	printk (KERN_DEBUG "ppp: dict_ptr(%d) > max\n", idx);
 	idx = 0;
       }
     return dict_ptrx (db, idx);
