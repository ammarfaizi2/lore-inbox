Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266339AbUBDU3e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUBDU2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:28:40 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:51228 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S266574AbUBDU2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:28:05 -0500
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200402042027.i14KRwIa020339@fsgi900.americas.sgi.com>
Subject: [PATCH 2.6] small Altix mod [2/2]
To: linux-kernel@vger.kernel.org
Date: Wed, 4 Feb 2004 14:27:58 -0600 (CST)
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another little ditty for Altix ....


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
