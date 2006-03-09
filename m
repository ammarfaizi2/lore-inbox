Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWCINB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWCINB7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWCINB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:01:59 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:37851 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751260AbWCINB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:01:58 -0500
Date: Thu, 9 Mar 2006 13:01:50 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix scripts/namespace.pl portability
Message-ID: <20060309130150.GA10275@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/namespace.pl was assuming the nm and objdump tools to use are
always just named that which breaks things in a crosscompilation
environment.

Fixed by honouring $NM and $OBJDUMP if passed by make, otherwise
defaulting to just nm rsp. objdump just as we used to.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

---
 scripts/namespace.pl |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/namespace.pl b/scripts/namespace.pl
index 88e30e8..59dcb25 100644
--- a/scripts/namespace.pl
+++ b/scripts/namespace.pl
@@ -66,8 +66,14 @@ require 5;	# at least perl 5
 use strict;
 use File::Find;
 
-my $nm = "/usr/bin/nm -p";
-my $objdump = "/usr/bin/objdump -s -j .comment";
+my $nm = "nm";
+$nm = "$ENV{'NM'}" if (exists($ENV{'NM'}));
+$nm = "$nm" . " -p";
+my $objdump = "objdump";
+
+$objdump = "$ENV{'OBJDUMP'}" if (exists($ENV{'OBJDUMP'}));
+$objdump = $objdump . " -s -j .comment";
+
 my $srctree = "";
 my $objtree = "";
 $srctree = "$ENV{'srctree'}/" if (exists($ENV{'srctree'}));
