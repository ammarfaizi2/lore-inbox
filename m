Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317591AbSGXVX1>; Wed, 24 Jul 2002 17:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317602AbSGXVX1>; Wed, 24 Jul 2002 17:23:27 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:19720 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317591AbSGXVXG>;
	Wed, 24 Jul 2002 17:23:06 -0400
Date: Wed, 24 Jul 2002 23:33:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel-doc: Fix warnings [4/9]
Message-ID: <20020724233336.C12782@mars.ravnborg.org>
References: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724232021.A12622@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jul 24, 2002 at 11:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.434   -> 1.435  
#	  scripts/kernel-doc	1.10    -> 1.11   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.435
# [PATCH] kernel-doc: Fix warnings [4/9]
# During processing of skbuff.h three warnings were issued,
# becasue members of an enum within a struct were nor documented.
# This patch fixes kernel-doc not to spit out these non-valid warnings.
# Originally by Thunder.
# --------------------------------------------
#
diff -Nru a/scripts/kernel-doc b/scripts/kernel-doc
--- a/scripts/kernel-doc	Wed Jul 24 23:26:04 2002
+++ b/scripts/kernel-doc	Wed Jul 24 23:26:04 2002
@@ -646,6 +646,7 @@
     print "  <programlisting>\n";
     print $args{'type'}." ".$args{'struct'}." {\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+	defined($args{'parameterdescs'}{$parameter}) || next;
         ($args{'parameterdescs'}{$parameter} ne $undescribed) || next;
 	$type = $args{'parametertypes'}{$parameter};
 	if ($type =~ m/([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)/) {
@@ -666,6 +667,7 @@
 
     print "  <variablelist>\n";
     foreach $parameter (@{$args{'parameterlist'}}) {
+      defined($args{'parameterdescs'}{$parameter}) || next;
       ($args{'parameterdescs'}{$parameter} ne $undescribed) || next;
       print "    <varlistentry>";
       print "      <term>$parameter</term>\n";
