Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUBLQpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUBLQpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:45:10 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:24491 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S266519AbUBLQoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:44:54 -0500
Date: Thu, 12 Feb 2004 10:44:47 -0600 (CST)
From: Pat Gefre <pfg@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] small Altix mod [2/2]
Message-ID: <Pine.SGI.3.96.1040212104409.6390B-100000@fsgi900.americas.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another little ditty for Altix .... Can you take this Andrew ?


-- Pat

Patrick Gefre
Silicon Graphics, Inc.                     (E-Mail)  pfg@sgi.com
2750 Blue Water Rd                         (Voice)   (651) 683-3127
Eagan, MN 55121-1400                       (FAX)     (651) 683-3054



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1555  -> 1.1556 
#	arch/ia64/sn/io/sn2/ml_SN_init.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/03	pfg@attica.americas.sgi.com	1.1556
# arch/ia64/sn/io/sn2/ml_SN_init.c
#     skip init_platform_hubinfo() if on the simulator
# --------------------------------------------
#
diff -Nru a/arch/ia64/sn/io/sn2/ml_SN_init.c b/arch/ia64/sn/io/sn2/ml_SN_init.c
--- a/arch/ia64/sn/io/sn2/ml_SN_init.c	Tue Feb  3 00:42:24 2004
+++ b/arch/ia64/sn/io/sn2/ml_SN_init.c	Tue Feb  3 00:42:24 2004
@@ -17,6 +17,7 @@
 #include <asm/sn/sn_private.h>
 #include <asm/sn/klconfig.h>
 #include <asm/sn/sn_cpuid.h>
+#include <asm/sn/simulator.h>
 
 int		maxcpus;
 
@@ -69,12 +70,15 @@
 }
 
 void
-init_platform_hubinfo(nodepda_t **nodepdaindr) {
+init_platform_hubinfo(nodepda_t **nodepdaindr)
+{
 	cnodeid_t       cnode;
 	hubinfo_t hubinfo;
 	nodepda_t *npda;
 	extern int numionodes;
 
+	if (IS_RUNNING_ON_SIMULATOR())
+		return;
 	for (cnode = 0; cnode < numionodes; cnode++) {
 		npda = nodepdaindr[cnode];
 		hubinfo = (hubinfo_t)npda->pdinfo;

