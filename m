Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVCCLJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVCCLJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 06:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCCLIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:08:53 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:2228 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262524AbVCCKlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:41:35 -0500
Date: Thu, 3 Mar 2005 11:41:21 +0100
Message-Id: <200503031041.j23AfLSx020688@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 2/16] DocBook: allow preprocessor directives between kernel-doc and function
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: allow preprocessor directives between kernel-doc and function
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2026  -> 1.2027 
#	  scripts/kernel-doc	1.24    -> 1.25   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/01/26	tali@admingilde.org	1.2027
# DocBook: allow preprocessor directives between kernel-doc and function
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Thu Mar  3 11:41:25 2005
+++ b/scripts/kernel-doc	Thu Mar  3 11:41:25 2005
@@ -1578,13 +1578,13 @@
     my $x = shift;
     my $file = shift;
 
-    if ($x =~ m#\s*/\*\s+MACDOC\s*#io) {
+    if ($x =~ m#\s*/\*\s+MACDOC\s*#io || ($x =~ /^#/ && $x !~ /^#define/)) {
 	# do nothing
     }
     elsif ($x =~ /([^\{]*)/) {
         $prototype .= $1;
     }
-    if (($x =~ /\{/) || ($x =~ /\#/) || ($x =~ /;/)) {
+    if (($x =~ /\{/) || ($x =~ /\#define/) || ($x =~ /;/)) {
         $prototype =~ s@/\*.*?\*/@@gos;	# strip comments.
 	$prototype =~ s@[\r\n]+@ @gos; # strip newlines/cr's.
 	$prototype =~ s@^\s+@@gos; # strip leading spaces
