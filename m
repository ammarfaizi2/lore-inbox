Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVCNTCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVCNTCp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 14:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVCNTCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 14:02:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:46721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261707AbVCNTC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 14:02:28 -0500
Date: Mon, 14 Mar 2005 11:02:09 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: kaos@ocs.com.au, akpm <akpm@osdl.org>
Subject: [PATCH] buildcheck: reduce DEBUG_INFO noise from reference* scripts
Message-Id: <20050314110209.5ced9d9d.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce noise in 'make buildcheck' that is caused by CONFIG_DEBUG_INFO=y.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 scripts/reference_discarded.pl |    3 +++
 scripts/reference_init.pl      |    1 +
 2 files changed, 4 insertions(+)

diff -Naurp ./scripts/reference_discarded.pl~ref_init_debugs ./scripts/reference_discarded.pl
--- ./scripts/reference_discarded.pl~ref_init_debugs	2005-03-01 23:38:08.000000000 -0800
+++ ./scripts/reference_discarded.pl	2005-03-14 10:38:47.000000000 -0800
@@ -82,6 +82,8 @@ foreach $object (keys(%object)) {
 		}
 		if (($line =~ /\.text\.exit$/ ||
 		     $line =~ /\.exit\.text$/ ||
+		     $line =~ /\.text\.init$/ ||
+		     $line =~ /\.init\.text$/ ||
 		     $line =~ /\.data\.exit$/ ||
 		     $line =~ /\.exit\.data$/ ||
 		     $line =~ /\.exitcall\.exit$/) &&
@@ -96,6 +98,7 @@ foreach $object (keys(%object)) {
 		     $from !~ /\.debug_ranges$/ &&
 		     $from !~ /\.debug_line$/ &&
 		     $from !~ /\.debug_frame$/ &&
+		     $from !~ /\.debug_loc$/ &&
 		     $from !~ /\.exitcall\.exit$/ &&
 		     $from !~ /\.eh_frame$/ &&
 		     $from !~ /\.stab$/)) {
diff -Naurp ./scripts/reference_init.pl~ref_init_debugs ./scripts/reference_init.pl
--- ./scripts/reference_init.pl~ref_init_debugs	2005-03-01 23:38:17.000000000 -0800
+++ ./scripts/reference_init.pl	2005-03-14 10:40:19.000000000 -0800
@@ -98,6 +98,7 @@ foreach $object (sort(keys(%object))) {
 		     $from !~ /\.pdr$/ &&
 		     $from !~ /\__param$/ &&
 		     $from !~ /\.altinstructions/ &&
+		     $from !~ /\.eh_frame/ &&
 		     $from !~ /\.debug_/)) {
 			printf("Error: %s %s refers to %s\n", $object, $from, $line);
 		}

---
