Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUHUTbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUHUTbs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 15:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267697AbUHUTbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 15:31:48 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:3076 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id S267686AbUHUTbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 15:31:43 -0400
Date: Sat, 21 Aug 2004 20:31:42 +0100
From: John Levon <levon@movementarian.org>
To: torvalds@osdl.org, akpm@osdl.org, oprofile-list@lists.sf.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix OProfile events with zero event values
Message-ID: <20040821193142.GB9501@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1BybaY-000Auw-Bu*aQAErCO.wGo*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A silly bug prevented certain events from being used.

Please apply

regards
john


Index: linux-cvs/arch/i386/oprofile/op_model_athlon.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/arch/i386/oprofile/op_model_athlon.c,v
retrieving revision 1.7
diff -u -a -p -r1.7 op_model_athlon.c
--- linux-cvs/arch/i386/oprofile/op_model_athlon.c	21 Aug 2003 23:57:03 -0000	1.7
+++ linux-cvs/arch/i386/oprofile/op_model_athlon.c	21 Aug 2004 20:28:53 -0000
@@ -70,7 +70,7 @@ static void athlon_setup_ctrs(struct op_
 
 	/* enable active counters */
 	for (i = 0; i < NUM_COUNTERS; ++i) {
-		if (counter_config[i].event) {
+		if (counter_config[i].enabled) {
 			reset_value[i] = counter_config[i].count;
 
 			CTR_WRITE(counter_config[i].count, msrs, i);
Index: linux-cvs/arch/i386/oprofile/op_model_p4.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/arch/i386/oprofile/op_model_p4.c,v
retrieving revision 1.11
diff -u -a -p -r1.11 op_model_p4.c
--- linux-cvs/arch/i386/oprofile/op_model_p4.c	30 Jun 2004 22:50:31 -0000	1.11
+++ linux-cvs/arch/i386/oprofile/op_model_p4.c	21 Aug 2004 20:28:53 -0000
@@ -578,7 +578,7 @@ static void p4_setup_ctrs(struct op_msrs
 	
 	/* setup all counters */
 	for (i = 0 ; i < num_counters ; ++i) {
-		if (counter_config[i].event) {
+		if (counter_config[i].enabled) {
 			reset_value[i] = counter_config[i].count;
 			pmc_setup_one_p4_counter(i);
 			CTR_WRITE(counter_config[i].count, VIRT_CTR(stag, i));
Index: linux-cvs/arch/i386/oprofile/op_model_ppro.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/arch/i386/oprofile/op_model_ppro.c,v
retrieving revision 1.8
diff -u -a -p -r1.8 op_model_ppro.c
--- linux-cvs/arch/i386/oprofile/op_model_ppro.c	19 Feb 2004 04:56:30 -0000	1.8
+++ linux-cvs/arch/i386/oprofile/op_model_ppro.c	21 Aug 2004 20:28:53 -0000
@@ -67,7 +67,7 @@ static void ppro_setup_ctrs(struct op_ms
 
 	/* enable active counters */
 	for (i = 0; i < NUM_COUNTERS; ++i) {
-		if (counter_config[i].event) {
+		if (counter_config[i].enabled) {
 			reset_value[i] = counter_config[i].count;
 
 			CTR_WRITE(counter_config[i].count, msrs, i);
Index: linux-cvs/arch/arm/oprofile/op_model_xscale.c
===================================================================
RCS file: /home/moz/cvs//linux-2.5/arch/arm/oprofile/op_model_xscale.c,v
retrieving revision 1.3
diff -u -a -p -r1.3 op_model_xscale.c
--- linux-cvs/arch/arm/oprofile/op_model_xscale.c	29 Apr 2004 14:10:01 -0000	1.3
+++ linux-cvs/arch/arm/oprofile/op_model_xscale.c	21 Aug 2004 20:28:53 -0000
@@ -7,7 +7,7 @@
  * @remark Copyright 2004 Dave Jiang <dave.jiang@intel.com>
  * @remark Copyright 2004 Intel Corporation
  * @remark Copyright 2004 Zwane Mwaikambo <zwane@arm.linux.org.uk>
- * @remark Copyright 2004 Oprofile Authors
+ * @remark Copyright 2004 OProfile Authors
  *
  * @remark Read the file COPYING
  *
@@ -249,7 +249,7 @@ static int xscale_setup_ctrs(void)
 	int i;
 
 	for (i = CCNT; i < MAX_COUNTERS; i++) {
-		if (counter_config[i].event)
+		if (counter_config[i].enabled)
 			continue;
 
 		counter_config[i].event = EVT_UNUSED;
