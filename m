Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVCVGcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVCVGcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:32:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVCVCDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:03:55 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:23179 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262333AbVCVBfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:35:39 -0500
Message-Id: <20050322013458.457325000@abc>
References: <20050322013427.919515000@abc>
Date: Tue, 22 Mar 2005 02:24:03 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-doc-oren-firmware.patch
X-SA-Exim-Connect-IP: 217.231.55.169
Subject: [DVB patch 30/48] OREN or51211, or51132_qam and or51132_vsb firmware download info
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o add OREN or51211, or51132_qam and or51132_vsb firmware
o correct some links

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 contributors.txt |    3 +++
 get_dvb_firmware |   50 +++++++++++++++++++++++++++++++++++++++++++++-----
 readme.txt       |    7 ++++---
 3 files changed, 52 insertions(+), 8 deletions(-)

Index: linux-2.6.12-rc1-mm1/Documentation/dvb/get_dvb_firmware
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/get_dvb_firmware	2005-03-22 00:18:18.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/get_dvb_firmware	2005-03-22 00:18:42.000000000 +0100
@@ -22,14 +22,15 @@ use File::Temp qw/ tempdir /;
 use IO::Handle;
 
 @components = ( "sp8870", "sp887x", "tda10045", "tda10046", "av7110", "dec2000t",
-		"dec2540t", "dec3000s", "vp7041", "dibusb", "nxt2002" );
+		"dec2540t", "dec3000s", "vp7041", "dibusb", "nxt2002",
+		"or51211", "or51132_qam", "or51132_vsb");
 
 # Check args
 syntax() if (scalar(@ARGV) != 1);
 $cid = $ARGV[0];
 
 # Do it!
-for($i=0; $i < scalar(@components); $i++) {
+for ($i=0; $i < scalar(@components); $i++) {
     if ($cid eq $components[$i]) {
 	$outfile = eval($cid);
 	die $@ if $@;
@@ -122,9 +123,9 @@ sub tda10046 {
 }
 
 sub av7110 {
-    my $sourcefile = "dvb-ttpci-01.fw-261c";
-    my $url = "http://www.linuxtv.org/download/dvb/firmware/$sourcefile";
-    my $hash = "7b263de6b0b92d2347319c65adc7d4fb";
+    my $sourcefile = "dvb-ttpci-01.fw-261d";
+    my $url = "http://www.linuxtv.org/downloads/firmware/$sourcefile";
+    my $hash = "603431b6259715a8e88f376a53b64e2f";
     my $outfile = "dvb-ttpci-01.fw";
 
     checkstandard();
@@ -251,6 +252,45 @@ sub nxt2002 {
     $outfile;
 }
 
+sub or51211 {
+    my $fwfile = "dvb-fe-or51211.fw";
+    my $url = "http://linuxtv.org/downloads/firmware/$fwfile";
+    my $hash = "d830949c771a289505bf9eafc225d491";
+
+    checkstandard();
+
+    wgetfile($fwfile, $url);
+    verify($fwfile, $hash);
+
+    $fwfile;
+}
+
+sub or51132_qam {
+    my $fwfile = "dvb-fe-or51132-qam.fw";
+    my $url = "http://linuxtv.org/downloads/firmware/$fwfile";
+    my $hash = "7702e8938612de46ccadfe9b413cb3b5";
+
+    checkstandard();
+
+    wgetfile($fwfile, $url);
+    verify($fwfile, $hash);
+
+    $fwfile;
+}
+
+sub or51132_vsb {
+    my $fwfile = "dvb-fe-or51132-vsb.fw";
+    my $url = "http://linuxtv.org/downloads/firmware/$fwfile";
+    my $hash = "c16208e02f36fc439a557ad4c613364a";
+
+    checkstandard();
+
+    wgetfile($fwfile, $url);
+    verify($fwfile, $hash);
+
+    $fwfile;
+}
+
 # ---------------------------------------------------------------
 # Utilities
 
Index: linux-2.6.12-rc1-mm1/Documentation/dvb/contributors.txt
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/contributors.txt	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/contributors.txt	2005-03-22 00:18:42.000000000 +0100
@@ -72,5 +72,8 @@ Kenneth Aafløy <ke-aa@frisurf.no>
 Ernst Peinlich <e.peinlich@inode.at>
   for tuning/DiSEqC support for the DEC 3000-s
 
+Peter Beutner <p.beutner@gmx.net>
+  for the IR code for the ttusb-dec driver
+
 (If you think you should be in this list, but you are not, drop a
  line to the DVB mailing list)
Index: linux-2.6.12-rc1-mm1/Documentation/dvb/readme.txt
===================================================================
--- linux-2.6.12-rc1-mm1.orig/Documentation/dvb/readme.txt	2005-03-21 23:27:57.000000000 +0100
+++ linux-2.6.12-rc1-mm1/Documentation/dvb/readme.txt	2005-03-22 00:18:42.000000000 +0100
@@ -5,8 +5,9 @@ The main development site and CVS reposi
 drivers is http://linuxtv.org/.
 
 The developer mailing list linux-dvb is also hosted there,
-see http://linuxtv.org/mailinglists.xml. Please check
-the archive http://linuxtv.org/mailinglists/linux-dvb/
+see http://linuxtv.org/lists.php. Please check
+the archive http://linuxtv.org/pipermail/linux-dvb/
+and the Wiki http://linuxtv.org/wiki/
 before asking newbie questions on the list.
 
 API documentation, utilities and test/example programs
@@ -15,7 +16,7 @@ are available as part of the old driver 
 We plan to split this into separate packages, but it's not
 been done yet.
 
-http://linuxtv.org/download/dvb/
+http://linuxtv.org/downloads/
 
 What's inside this directory:
 

--

