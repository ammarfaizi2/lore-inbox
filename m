Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262578AbVAPUXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262578AbVAPUXe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVAPUXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:23:33 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:50627 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262578AbVAPUWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:22:54 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>, akpm.osdl.org@ocs.com.au
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] scripts/reference*.pl - treat built-in.o as conglomerate
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 06:50:34 +1100
Message-ID: <15580.1105905034@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/reference*.pl - treat built-in.o as conglomerate.  Ignore
references from altinstructions to init text/data.

Signed-off-by: Keith Owens <kaos@ocs.com.au>

Index: 2.6.10/scripts/reference_discarded.pl
===================================================================
--- 2.6.10.orig/scripts/reference_discarded.pl	2004-10-19 07:54:07.000000000 +1000
+++ 2.6.10/scripts/reference_discarded.pl	2005-01-16 17:13:03.997955187 +1100
@@ -62,7 +62,7 @@ foreach $object (keys(%object)) {
 		$l = read(OBJECT, $comment, $size);
 		die "read $size bytes from $object .comment failed" if ($l != $size);
 		close(OBJECT);
-		if ($comment =~ /GCC\:.*GCC\:/m) {
+		if ($comment =~ /GCC\:.*GCC\:/m || $object =~ /built-in.\o/) {
 			++$ignore;
 			delete($object{$object});
 		}
Index: 2.6.10/scripts/reference_init.pl
===================================================================
--- 2.6.10.orig/scripts/reference_init.pl	2004-12-25 10:26:19.000000000 +1100
+++ 2.6.10/scripts/reference_init.pl	2005-01-16 17:12:50.449024044 +1100
@@ -70,7 +70,7 @@ foreach $object (keys(%object)) {
 		$l = read(OBJECT, $comment, $size);
 		die "read $size bytes from $object .comment failed" if ($l != $size);
 		close(OBJECT);
-		if ($comment =~ /GCC\:.*GCC\:/m) {
+		if ($comment =~ /GCC\:.*GCC\:/m || $object =~ /built-in\.o/) {
 			++$ignore;
 			delete($object{$object});
 		}
@@ -96,6 +96,7 @@ foreach $object (sort(keys(%object))) {
 		     $from !~ /\.pci_fixup_header$/ &&
 		     $from !~ /\.pci_fixup_final$/ &&
 		     $from !~ /\__param$/ &&
+		     $from !~ /\.altinstructions/ &&
 		     $from !~ /\.debug_/)) {
 			printf("Error: %s %s refers to %s\n", $object, $from, $line);
 		}


