Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWCPD0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWCPD0R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCPD0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:26:17 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39609 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932254AbWCPD0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:26:16 -0500
Date: Thu, 16 Mar 2006 12:25:06 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [4/19] under drivers/acpi
Message-Id: <20060316122506.72afc921.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.
under drivers/acpi/
 processor_perflib.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.16-rc6-mm1/drivers/acpi/processor_perflib.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/drivers/acpi/processor_perflib.c
+++ linux-2.6.16-rc6-mm1/drivers/acpi/processor_perflib.c
@@ -626,7 +626,7 @@ int acpi_processor_preregister_performan
 	retval = 0;
 
 	/* Call _PSD for all CPUs */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr) {
 			/* Look only at processors in ACPI namespace */
@@ -657,7 +657,7 @@ int acpi_processor_preregister_performan
 	 * Now that we have _PSD data from all CPUs, lets setup P-state 
 	 * domain info.
 	 */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr)
 			continue;
@@ -678,7 +678,7 @@ int acpi_processor_preregister_performan
 	}
 
 	cpus_clear(covered_cpus);
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr)
 			continue;
@@ -702,7 +702,7 @@ int acpi_processor_preregister_performan
 			pr->performance->shared_type = CPUFREQ_SHARED_TYPE_ANY;
 		}
 
-		for_each_cpu(j) {
+		for_each_possible_cpu(j) {
 			if (i == j)
 				continue;
 
@@ -731,7 +731,7 @@ int acpi_processor_preregister_performan
 			count++;
 		}
 
-		for_each_cpu(j) {
+		for_each_possible_cpu(j) {
 			if (i == j)
 				continue;
 
@@ -755,7 +755,7 @@ err_ret:
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error while parsing _PSD domain information. Assuming no coordination\n"));
 	}
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		pr = processors[i];
 		if (!pr || !pr->performance)
 			continue;
