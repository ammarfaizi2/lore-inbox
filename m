Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWB0DZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWB0DZx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 22:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750877AbWB0DZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 22:25:53 -0500
Received: from static-151-204-232-50.bos.east.verizon.net ([151.204.232.50]:47629
	"EHLO mail2.sicortex.com") by vger.kernel.org with ESMTP
	id S1750868AbWB0DZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 22:25:53 -0500
Date: Sun, 26 Feb 2006 22:25:46 -0500
From: Aaron Brooks <aaron.brooks@sicortex.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: namespace.pl is not CROSS_COMPILE happy
Message-ID: <20060227032546.GQ11744@sicortex.com>
References: <20060208184506.GS11744@sicortex.com> <20060208202251.GA9550@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208202251.GA9550@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the fixed path to /usr/bin/{nm,objdump} does not allow
CROSS_COMPILE environments to use namespace.pl. This patch causes
namespace.pl to use $NM and $OBJDUMP if defined or fall back to the nm
and objdump found in the path.

Signed-off-by: Aaron Brooks <aaron.brooks@sicortex.com>
---

 Patch applies to current torvalds/linux-2.6.git head.

 namespace.pl |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
Index: linux/scripts/namespace.pl
===================================================================
--- linux-2.6.15/scripts/namespace.pl  (revision 14607)
+++ linux-2.6.15/scripts/namespace.pl  (working copy)
@@ -66,8 +66,8 @@
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
+my $nm = ($ENV{'NM'} || "nm") . " -p";
+my $objdump = ($ENV{'OBJDUMP'} || "objdump") . " -s -j .comment";
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
