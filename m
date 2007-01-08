Return-Path: <linux-kernel-owner+w=401wt.eu-S1161179AbXAHGQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbXAHGQc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 01:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161180AbXAHGQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 01:16:32 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:26653 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161179AbXAHGQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 01:16:31 -0500
Date: Sun, 7 Jan 2007 22:15:18 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] kernel-doc: allow more whitespace
Message-Id: <20070107221518.b8c72ee3.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Allow whitespace in pointer-to-function
	[accept "(* done)", not just "(*done)"].

Allow tabs (spaces are already allowed) between "#define" and a macro name.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 scripts/kernel-doc |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2620-rc4.orig/scripts/kernel-doc
+++ linux-2620-rc4/scripts/kernel-doc
@@ -1433,7 +1433,7 @@ sub create_parameterlist($$$) {
 	} elsif ($arg =~ m/\(.*\*/) {
 	    # pointer-to-function
 	    $arg =~ tr/#/,/;
-	    $arg =~ m/[^\(]+\(\*([^\)]+)\)/;
+	    $arg =~ m/[^\(]+\(\*\s*([^\)]+)\)/;
 	    $param = $1;
 	    $type = $arg;
 	    $type =~ s/([^\(]+\(\*)$param/$1/;
@@ -1536,7 +1536,7 @@ sub dump_function($$) {
     $prototype =~ s/^__always_inline +//;
     $prototype =~ s/^noinline +//;
     $prototype =~ s/__devinit +//;
-    $prototype =~ s/^#define +//; #ak added
+    $prototype =~ s/^#define\s+//; #ak added
     $prototype =~ s/__attribute__ \(\([a-z,]*\)\)//;
 
     # Yes, this truly is vile.  We are looking for:


---
