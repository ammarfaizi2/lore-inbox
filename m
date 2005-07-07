Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVGGWlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVGGWlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGGWlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:41:00 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:46493 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262028AbVGGWja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:39:30 -0400
Date: Thu, 7 Jul 2005 15:39:26 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] scripts/kernel-doc: don't use uninitialized SRCTREE
Message-Id: <20050707153926.0673793b.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Randy Dunlap <rdunlap@xenotime.net>

Current kernel-doc (perl) script generates this warning:
Use of uninitialized value in concatenation (.) or string at scripts/kernel-doc line 1668.

so explicitly check for SRCTREE in the ENV before using it,
and then if it is set, append a '/' to the end of it, otherwise
the SRCTREE + filename can (will) be missing the intermediate '/'.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>

diffstat:=
 scripts/kernel-doc |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletion(-)

diff -Naurp linux-2613-rc2/scripts/kernel-doc~kernel-doc-srctree linux-2613-rc2/scripts/kernel-doc
--- linux-2613-rc2/scripts/kernel-doc~kernel-doc-srctree	2005-06-17 12:48:29.000000000 -0700
+++ linux-2613-rc2/scripts/kernel-doc	2005-07-07 14:33:01.000000000 -0700
@@ -1665,11 +1665,17 @@ sub xml_escape($) {
 }
 
 sub process_file($) {
-    my ($file) = "$ENV{'SRCTREE'}@_";
+    my $file;
     my $identifier;
     my $func;
     my $initial_section_counter = $section_counter;
 
+    if (defined($ENV{'SRCTREE'})) {
+	$file = "$ENV{'SRCTREE'}" . "/" . "@_";
+    }
+    else {
+	$file = "@_";
+    }
     if (defined($source_map{$file})) {
 	$file = $source_map{$file};
     }

---
