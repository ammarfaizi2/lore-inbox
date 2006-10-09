Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWJIE7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWJIE7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 00:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWJIE7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 00:59:34 -0400
Received: from xenotime.net ([66.160.160.81]:59014 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751622AbWJIE7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 00:59:33 -0400
Date: Sun, 8 Oct 2006 22:00:57 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: make parameter description indentation uniform
Message-Id: <20061008220057.bcc89888.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

- In parameter descriptions, strip all whitespace between the parameter
  name (e.g., @len) and its description so that the description is
  indented uniformly in text and man page modes.  Previously, spaces
  or tabs (which are used for cleaner source code viewing) affected
  the produced output in a negative way.

Before (man mode):
       to            Destination address, in user space.
       from        Source address, in kernel space.
       n              Number of bytes to copy.

After (man mode):
       to          Destination address, in user space.
       from        Source address, in kernel space.
       n           Number of bytes to copy.

- Fix/clarify a few function description comments.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 scripts/kernel-doc |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

--- linux-2619-rc1g3.orig/scripts/kernel-doc
+++ linux-2619-rc1g3/scripts/kernel-doc
@@ -1262,7 +1262,9 @@ sub output_intro_text(%) {
 }
 
 ##
-# generic output function for typedefs
+# generic output function for all types (function, struct/union, typedef, enum);
+# calls the generated, variable output_ function name based on
+# functype and output_mode
 sub output_declaration {
     no strict 'refs';
     my $name = shift;
@@ -1278,8 +1280,7 @@ sub output_declaration {
 }
 
 ##
-# generic output function - calls the right one based
-# on current output mode.
+# generic output function - calls the right one based on current output mode.
 sub output_intro {
     no strict 'refs';
     my $func = "output_intro_".$output_mode;
@@ -1782,8 +1783,9 @@ sub process_file($) {
 		$in_doc_sect = 1;
 		$contents = $newcontents;
 		if ($contents ne "") {
-		    if (substr($contents, 0, 1) eq " ") {
-			$contents = substr($contents, 1);
+		    while ((substr($contents, 0, 1) eq " ") ||
+			substr($contents, 0, 1) eq "\t") {
+			    $contents = substr($contents, 1);
 		    }
 		    $contents .= "\n";
 		}


---
