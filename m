Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWAUVja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWAUVja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 16:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWAUVja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 16:39:30 -0500
Received: from admingilde.org ([213.95.32.146]:11238 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932378AbWAUVj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 16:39:28 -0500
Date: Sat, 21 Jan 2006 22:39:24 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] DocBook: allow even longer return types
Message-ID: <20060121213924.GC30777@admingilde.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel-doc errored out because it could not understand the new
__copy_to_user definition. Now we allow return types with four words.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 scripts/kernel-doc |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

cb009807a1057eb1037c695b2e6e0282d4225621
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 9fd5f5b..b927fd2 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1529,7 +1529,7 @@ sub dump_function($$) {
     # the following functions' documentation still comes out right:
     # - parport_register_device (function pointer parameters)
     # - atomic_set (macro)
-    # - pci_match_device (long return type)
+    # - pci_match_device, __copy_to_user (long return type)
 
     if ($prototype =~ m/^()([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
 	$prototype =~ m/^(\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\(]*)\)/ ||
@@ -1544,7 +1544,9 @@ sub dump_function($$) {
 	$prototype =~ m/^(\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
 	$prototype =~ m/^(\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
-	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+)\s+([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/ ||
+	$prototype =~ m/^(\w+\s+\w+\s+\w+\s+\w+\s*\*)\s*([a-zA-Z0-9_~:]+)\s*\(([^\{]*)\)/)  {
 	$return_type = $1;
 	$declaration_name = $2;
 	my $args = $3;
-- 
0.99.9.GIT

-- 
Martin Waitz
