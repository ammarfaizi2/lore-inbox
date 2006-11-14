Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753888AbWKNIEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbWKNIEt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbWKNIEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:04:49 -0500
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:997 "EHLO
	mail-in-13.arcor-online.net") by vger.kernel.org with ESMTP
	id S1753888AbWKNIEs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:04:48 -0500
Message-ID: <24916260.1163491486636.JavaMail.ngmail@webmail11>
Date: Tue, 14 Nov 2006 09:04:46 +0100 (CET)
From: "H. Nestler" <henry.ne@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: subj: [PATCH] initrd: Remove unused false condition for
 initrd_start
Cc: trivial@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 87.162.191.112
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Henry Nestler <henry.ne@arcor.de>

After LOADER_TYPE && INITRD_START are true, the short if-condition
for INITRD_START can never be false.

Remove unused code from the else condition.

Signed-off-by: Henry Nestler <henry.ne@arcor.de>
---
Grepped for all of these code style in all arch and changed here.

arch/frv/kernel/setup.c    |    2 +-
arch/i386/kernel/setup.c   |    3 +--
arch/m32r/kernel/setup.c   |    4 +---
arch/m32r/mm/discontig.c   |    4 +---
arch/sh/kernel/setup.c     |    3 +--
arch/sh64/kernel/setup.c   |    4 +---
arch/x86_64/kernel/setup.c |    3 +--
7 files changed, 7 insertions(+), 16 deletions(-)

Index: linux-2.6.19-rc5/arch/frv/kernel/setup.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/frv/kernel/setup.c
+++ linux-2.6.19-rc5/arch/frv/kernel/setup.c
@@ -947,7 +947,7 @@
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (low_top_pfn << PAGE_SHIFT)) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
-			initrd_start = INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+			initrd_start = INITRD_START + PAGE_OFFSET;
 			initrd_end = initrd_start + INITRD_SIZE;
 		}
 		else {
Index: linux-2.6.19-rc5/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/i386/kernel/setup.c
+++ linux-2.6.19-rc5/arch/i386/kernel/setup.c
@@ -1162,8 +1162,7 @@
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+			initrd_start = INITRD_START + PAGE_OFFSET;
 			initrd_end = initrd_start+INITRD_SIZE;
 		}
 		else {
Index: linux-2.6.19-rc5/arch/m32r/kernel/setup.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/m32r/kernel/setup.c
+++ linux-2.6.19-rc5/arch/m32r/kernel/setup.c
@@ -196,9 +196,7 @@
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
-			initrd_start = INITRD_START ?
-				INITRD_START + PAGE_OFFSET : 0;
-
+			initrd_start = INITRD_START + PAGE_OFFSET;
 			initrd_end = initrd_start + INITRD_SIZE;
 			printk("initrd:start[%08lx],size[%08lx]\n",
 				initrd_start, INITRD_SIZE);
Index: linux-2.6.19-rc5/arch/m32r/mm/discontig.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/m32r/mm/discontig.c
+++ linux-2.6.19-rc5/arch/m32r/mm/discontig.c
@@ -105,9 +105,7 @@
 		if (INITRD_START + INITRD_SIZE <= PFN_PHYS(max_low_pfn)) {
 			reserve_bootmem_node(NODE_DATA(0), INITRD_START,
 				INITRD_SIZE);
-			initrd_start = INITRD_START ?
-				INITRD_START + PAGE_OFFSET : 0;
-
+			initrd_start = INITRD_START + PAGE_OFFSET;
 			initrd_end = initrd_start + INITRD_SIZE;
 			printk("initrd:start[%08lx],size[%08lx]\n",
 				initrd_start, INITRD_SIZE);
Index: linux-2.6.19-rc5/arch/sh64/kernel/setup.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/sh64/kernel/setup.c
+++ linux-2.6.19-rc5/arch/sh64/kernel/setup.c
@@ -243,9 +243,7 @@
 		if (INITRD_START + INITRD_SIZE <= (PFN_PHYS(last_pfn))) {
 		        reserve_bootmem_node(NODE_DATA(0), INITRD_START + __MEMORY_START, INITRD_SIZE);
 
-			initrd_start =
-			  (long) INITRD_START ? INITRD_START + PAGE_OFFSET +  __MEMORY_START : 0;
-
+			initrd_start = (long) INITRD_START + PAGE_OFFSET + __MEMORY_START;
 			initrd_end = initrd_start + INITRD_SIZE;
 		} else {
 			printk("initrd extends beyond end of memory "
Index: linux-2.6.19-rc5/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.19-rc5/arch/x86_64/kernel/setup.c
@@ -471,8 +471,7 @@
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (end_pfn << PAGE_SHIFT)) {
 			reserve_bootmem_generic(INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+			initrd_start = INITRD_START + PAGE_OFFSET;
 			initrd_end = initrd_start+INITRD_SIZE;
 		}
 		else {
Index: linux-2.6.19-rc5/arch/sh/kernel/setup.c
===================================================================
--- linux-2.6.19-rc5.orig/arch/sh/kernel/setup.c
+++ linux-2.6.19-rc5/arch/sh/kernel/setup.c
@@ -332,8 +332,7 @@
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
 			reserve_bootmem_node(NODE_DATA(0), INITRD_START+__MEMORY_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET + __MEMORY_START : 0;
+			initrd_start = INITRD_START + PAGE_OFFSET + __MEMORY_START;
 			initrd_end = initrd_start + INITRD_SIZE;
 		} else {
 			printk("initrd extends beyond end of memory "
### End of patch. ### Sorry for followed footer from webmailer ###


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: günstig
und schnell mit DSL - das All-Inclusive-Paket für clevere Doppel-Sparer,
nur  44,85 €  inkl. DSL- und ISDN-Grundgebühr!
http://www.arcor.de/rd/emf-dsl-2
