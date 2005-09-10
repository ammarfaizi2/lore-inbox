Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVIJUfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVIJUfG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 16:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVIJUfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 16:35:05 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:59242 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S932289AbVIJUfD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 16:35:03 -0400
Date: Sat, 10 Sep 2005 22:36:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 5/7] kbuild: ignore all debugging info sections in scripts/reference_discarded.pl
Message-ID: <20050910203641.GE29334@mars.ravnborg.org>
References: <20050910200347.GA3762@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910200347.GA3762@mars.ravnborg.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 4 emits more DWARF debugging information than before and there is now a
.debug_loc section as well.  This causes "make buildcheck" to fail.  Rather
than just add that one to the special case list, I used a regexp to ignore
any .debug_ANYTHING sections in case more show up in the future.

Signed-off-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/reference_discarded.pl |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

caba0233bc85ec311159a35f138d957d05cf2fe8
diff --git a/scripts/reference_discarded.pl b/scripts/reference_discarded.pl
--- a/scripts/reference_discarded.pl
+++ b/scripts/reference_discarded.pl
@@ -91,12 +91,7 @@ foreach $object (keys(%object)) {
 		     $from !~ /\.exit\.data$/ &&
 		     $from !~ /\.altinstructions$/ &&
 		     $from !~ /\.pdr$/ &&
-		     $from !~ /\.debug_info$/ &&
-		     $from !~ /\.debug_aranges$/ &&
-		     $from !~ /\.debug_ranges$/ &&
-		     $from !~ /\.debug_line$/ &&
-		     $from !~ /\.debug_frame$/ &&
-		     $from !~ /\.debug_loc$/ &&
+		     $from !~ /\.debug_.*$/ &&
 		     $from !~ /\.exitcall\.exit$/ &&
 		     $from !~ /\.eh_frame$/ &&
 		     $from !~ /\.stab$/)) {

