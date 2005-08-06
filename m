Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbVHFA0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbVHFA0Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 20:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVHFA0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 20:26:16 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:49600 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262172AbVHFA0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 20:26:06 -0400
Date: Sat, 6 Aug 2005 02:26:03 +0200
From: benoit.boissinot@ens-lyon.fr
To: schwidefsky@de.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: fix invalid kmalloc flags
Message-ID: <20050806002603.GA29515@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fixes the compilation (defconfig) of s390:

arch/s390/mm/built-in.o(.text+0x152c): In function `query_segment_type':
extmem.c: undefined reference to `__your_kmalloc_flags_are_not_valid'
arch/s390/mm/built-in.o(.text+0x19ec): In function `segment_load':
: undefined reference to `__your_kmalloc_flags_are_not_valid'


Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- a/arch/s390/mm/extmem.c	2005-08-06 01:32:56.000000000 +0200
+++ b/arch/s390/mm/extmem.c	2005-07-31 17:46:36.000000000 +0200
@@ -172,8 +172,8 @@ dcss_diag_translate_rc (int vm_rc) {
 static int
 query_segment_type (struct dcss_segment *seg)
 {
-	struct qin64  *qin = kmalloc (sizeof(struct qin64), GFP_DMA);
-	struct qout64 *qout = kmalloc (sizeof(struct qout64), GFP_DMA);
+	struct qin64  *qin = kmalloc (sizeof(struct qin64), GFP_DMA|GFP_KERNEL);
+	struct qout64 *qout = kmalloc (sizeof(struct qout64), GFP_DMA|GFP_KERNEL);
 
 	int diag_cc, rc, i;
 	unsigned long dummy, vmrc;
@@ -332,7 +332,7 @@ static int
 __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long *end)
 {
 	struct dcss_segment *seg = kmalloc(sizeof(struct dcss_segment),
-			GFP_DMA);
+			GFP_DMA|GFP_KERNEL);
 	int dcss_command, rc, diag_cc;
 
 	if (seg == NULL) {
