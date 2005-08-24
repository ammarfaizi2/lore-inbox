Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932345AbVHXWlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbVHXWlb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbVHXWlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:41:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932346AbVHXWla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:41:30 -0400
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ignore all debugging info sections in scripts/reference_discarded.pl
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Message-Id: <20050824224116.96ACB180A18@magilla.sf.frob.com>
Date: Wed, 24 Aug 2005 15:41:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 4 emits more DWARF debugging information than before and there is now a
.debug_loc section as well.  This causes "make buildcheck" to fail.
Rather than just add that one to the special case list, I used a regexp to
ignore any .debug_ANYTHING sections in case more show up in the future.

Signed-off-by: Roland McGrath <roland@redhat.com>
---

 scripts/reference_discarded.pl |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

a91d80398d6f8c1f335a0af34342b5747f153c13
diff --git a/scripts/reference_discarded.pl b/scripts/reference_discarded.pl
--- a/scripts/reference_discarded.pl
+++ b/scripts/reference_discarded.pl
@@ -91,11 +91,7 @@ foreach $object (keys(%object)) {
 		     $from !~ /\.exit\.data$/ &&
 		     $from !~ /\.altinstructions$/ &&
 		     $from !~ /\.pdr$/ &&
-		     $from !~ /\.debug_info$/ &&
-		     $from !~ /\.debug_aranges$/ &&
-		     $from !~ /\.debug_ranges$/ &&
-		     $from !~ /\.debug_line$/ &&
-		     $from !~ /\.debug_frame$/ &&
+		     $from !~ /\.debug_.*$/ &&
 		     $from !~ /\.exitcall\.exit$/ &&
 		     $from !~ /\.eh_frame$/ &&
 		     $from !~ /\.stab$/)) {
