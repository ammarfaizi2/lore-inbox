Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWCUQ2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWCUQ2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWCUQ1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:27:33 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44300 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030421AbWCUQVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:21 -0500
Cc: Aaron Brooks <aaron.brooks@sicortex.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 27/46] kbuild: make namespace.pl CROSS_COMPILE happy
In-Reply-To: <11429580563456-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:56 +0100
Message-Id: <11429580561595-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the fixed path to /usr/bin/{nm,objdump} does not allow
CROSS_COMPILE environments to use namespace.pl. This patch causes
namespace.pl to use $NM and $OBJDUMP if defined or fall back to the nm
and objdump found in the path.

Signed-off-by: Aaron Brooks <aaron.brooks@sicortex.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/namespace.pl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

3a25f0b19f2eefd158955ab809c8947ed8feadf1
diff --git a/scripts/namespace.pl b/scripts/namespace.pl
index 88e30e8..f343738 100644
--- a/scripts/namespace.pl
+++ b/scripts/namespace.pl
@@ -66,8 +66,8 @@ require 5;	# at least perl 5
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
+my $nm = ($ENV{'NM'} || "nm") . " -p";
+my $objdump = ($ENV{'OBJDUMP'} || "objdump") . " -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
-- 
1.0.GIT


