Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVCCLDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVCCLDh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVCCKp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:45:59 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:16308 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261558AbVCCKn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:43:28 -0500
Date: Thu, 3 Mar 2005 11:43:17 +0100
Message-Id: <200503031043.j23AhHan020786@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 15/16] [DocBook] factor out escaping of XML special characters
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DocBook] factor out escaping of XML special characters
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2039  -> 1.2040 
#	  scripts/kernel-doc	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/03/03	tali@admingilde.org	1.2040
# [DocBook] factor out escaping of XML special characters
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Thu Mar  3 11:43:21 2005
+++ b/scripts/kernel-doc	Thu Mar  3 11:43:21 2005
@@ -1624,6 +1624,15 @@
     }
 }
 
+# replace <, >, and &
+sub xml_escape($) {
+	shift;
+	s/\&/\\\\\\amp;/g;
+	s/\</\\\\\\lt;/g;
+	s/\>/\\\\\\gt;/g;
+	return $_;
+}
+
 sub process_file($) {
     my ($file) = "$ENV{'SRCTREE'}@_";
     my $identifier;
@@ -1695,10 +1704,7 @@
 		$newcontents = $2;
 
 		if ($contents ne "") {
-		    $contents =~ s/\&/\\\\\\amp;/g;
-		    $contents =~ s/\</\\\\\\lt;/g;
-		    $contents =~ s/\>/\\\\\\gt;/g;
-		    dump_section($section, $contents);
+		    dump_section($section, xml_escape($contents));
 		    $section = $section_default;
 		}
 
@@ -1710,10 +1716,7 @@
 	    } elsif (/$doc_end/) {
 
 		if ($contents ne "") {
-		    $contents =~ s/\&/\\\\\\amp;/g;
-		    $contents =~ s/\</\\\\\\lt;/g;
-		    $contents =~ s/\>/\\\\\\gt;/g;
-		    dump_section($section, $contents);
+		    dump_section($section, xml_escape($contents));
 		    $section = $section_default;
 		    $contents = "";
 		}
@@ -1727,10 +1730,7 @@
 		# @parameter line to signify start of description
 		if ($1 eq "" && 
 			($section =~ m/^@/ || $section eq $section_context)) {
-		    $contents =~ s/\&/\\\\\\amp;/g;
-		    $contents =~ s/\</\\\\\\lt;/g;
-		    $contents =~ s/\>/\\\\\\gt;/g;
-		    dump_section($section, $contents);
+		    dump_section($section, xml_escape($contents));
 		    $section = $section_default;
 		    $contents = "";
 		} else {
