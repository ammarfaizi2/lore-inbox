Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932438AbVHIELA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbVHIELA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 00:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVHIEK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 00:10:59 -0400
Received: from waste.org ([216.27.176.166]:18827 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932438AbVHIEK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 00:10:59 -0400
Date: Mon, 8 Aug 2005 21:10:27 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, sam@ravnborg.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, mercurial@selenic.com
Subject: [PATCH] fix make clean damaging hg repos
Message-ID: <20050809041026.GA11030@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User Matt Mackall <mpm@selenic.com>
# Node ID d3e83cde10ebc2a570503c1ff9c4d9e8f37f4af9
# Parent  915766b005c1a990ea360affa0c025087e45c723
Keep make clean from deleting files in .hg

Running 'make clean' was quietly deleting files in Mercurial kernel
repositories matching '.*.d', which was corrupting the tags portions
of the repository. Spotted and fixed by several people.

Signed-off-by: Matt Mackall <mpm@selenic.com>

diff -r 915766b005c1 -r d3e83cde10eb Makefile
--- a/Makefile	Sat Aug  6 20:06:30 2005
+++ b/Makefile	Tue Aug  9 04:08:06 2005
@@ -374,8 +374,8 @@
 
 # Files to ignore in find ... statements
 
-RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc \) -prune -o
-RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc
+RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg \) -prune -o
+RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg
 
 # ===========================================================================
 # Rules shared between *config targets and build targets


-- 
Mathematics is the supreme nostalgia of our time.
