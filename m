Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVCCKx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVCCKx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVCCKve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:51:34 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:7604 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261579AbVCCKmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:42:37 -0500
Date: Thu, 3 Mar 2005 11:42:23 +0100
Message-Id: <200503031042.j23AgNNq020741@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 9/16] DocBook: s/sgml/xml/ in scripts/kernel-doc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: s/sgml/xml/ in scripts/kernel-doc
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2033  -> 1.2034 
#	  scripts/kernel-doc	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/02/08	tali@admingilde.org	1.2034
# DocBook: s/sgml/xml/ in scripts/kernel-doc
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Thu Mar  3 11:42:30 2005
+++ b/scripts/kernel-doc	Thu Mar  3 11:42:30 2005
@@ -170,14 +170,14 @@
 			$type_param, "<tt><b>\$1</b></tt>" );
 my $blankline_html = "<p>";
 
-# sgml, docbook format
-my %highlights_sgml = ( "([^=])\\\"([^\\\"<]+)\\\"", "\$1<quote>\$2</quote>",
+# XML, docbook format
+my %highlights_xml = ( "([^=])\\\"([^\\\"<]+)\\\"", "\$1<quote>\$2</quote>",
 			$type_constant, "<constant>\$1</constant>",
 			$type_func, "<function>\$1</function>",
 			$type_struct, "<structname>\$1</structname>",
 			$type_env, "<envar>\$1</envar>",
 			$type_param, "<parameter>\$1</parameter>" );
-my $blankline_sgml = "</para><para>\n";
+my $blankline_xml = "</para><para>\n";
 
 # gnome, docbook format
 my %highlights_gnome = ( $type_constant, "<replaceable class=\"option\">\$1</replaceable>",
@@ -297,14 +297,14 @@
 	%highlights = %highlights_text;
 	$blankline = $blankline_text;
     } elsif ($cmd eq "-docbook") {
-	$output_mode = "sgml";
-	%highlights = %highlights_sgml;
-	$blankline = $blankline_sgml;
+	$output_mode = "xml";
+	%highlights = %highlights_xml;
+	$blankline = $blankline_xml;
     } elsif ($cmd eq "-gnome") {
 	$output_mode = "gnome";
 	%highlights = %highlights_gnome;
 	$blankline = $blankline_gnome;
-    } elsif ($cmd eq "-module") { # not needed for sgml, inherits from calling document
+    } elsif ($cmd eq "-module") { # not needed for XML, inherits from calling document
 	$modulename = shift @ARGV;
     } elsif ($cmd eq "-function") { # to only output specific functions
 	$function_only = 1;
@@ -547,7 +547,7 @@
     print "<hr>\n";
 }
 
-sub output_section_sgml(%) {
+sub output_section_xml(%) {
     my %args = %{$_[0]};
     my $section;    
     # print out each section
@@ -565,8 +565,8 @@
     }
 }
 
-# output function in sgml DocBook
-sub output_function_sgml(%) {
+# output function in XML DocBook
+sub output_function_xml(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
     my $count;
@@ -632,12 +632,12 @@
     }
     print "</refsect1>\n";
 
-    output_section_sgml(@_);
+    output_section_xml(@_);
     print "</refentry>\n\n";
 }
 
-# output struct in sgml DocBook
-sub output_struct_sgml(%) {
+# output struct in XML DocBook
+sub output_struct_xml(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
     my $id;
@@ -708,13 +708,13 @@
     print "  </variablelist>\n";
     print " </refsect1>\n";
 
-    output_section_sgml(@_);
+    output_section_xml(@_);
 
     print "</refentry>\n\n";
 }
 
-# output enum in sgml DocBook
-sub output_enum_sgml(%) {
+# output enum in XML DocBook
+sub output_enum_xml(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
     my $count;
@@ -769,13 +769,13 @@
     print "  </variablelist>\n";
     print "</refsect1>\n";
 
-    output_section_sgml(@_);
+    output_section_xml(@_);
 
     print "</refentry>\n\n";
 }
 
-# output typedef in sgml DocBook
-sub output_typedef_sgml(%) {
+# output typedef in XML DocBook
+sub output_typedef_xml(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
     my $id;
@@ -800,13 +800,13 @@
     print "  <synopsis>typedef ".$args{'typedef'}.";</synopsis>\n";
     print "</refsynopsisdiv>\n";
 
-    output_section_sgml(@_);
+    output_section_xml(@_);
 
     print "</refentry>\n\n";
 }
 
-# output in sgml DocBook
-sub output_intro_sgml(%) {
+# output in XML DocBook
+sub output_intro_xml(%) {
     my %args = %{$_[0]};
     my ($parameter, $section);
     my $count;
@@ -831,7 +831,7 @@
     print "\n\n";
 }
 
-# output in sgml DocBook
+# output in XML DocBook
 sub output_function_gnome {
     my %args = %{$_[0]};
     my ($parameter, $section);
@@ -1799,7 +1799,7 @@
     }
     if ($initial_section_counter == $section_counter) {
 	print STDERR "Warning(${file}): no structured comments found\n";
-	if ($output_mode eq "sgml") {
+	if ($output_mode eq "xml") {
 	    # The template wants at least one RefEntry here; make one.
 	    print "<refentry>\n";
 	    print " <refnamediv>\n";
