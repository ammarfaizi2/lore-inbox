Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUIMNCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUIMNCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 09:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266657AbUIMNCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 09:02:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:19077 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266622AbUIMM73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 08:59:29 -0400
Date: Mon, 13 Sep 2004 05:58:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, ak@suse.de, bcasavan@sgi.com, anton@samba.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] undo more numa maxnode confusions
Message-Id: <20040913055848.1f9d5057.pj@sgi.com>
In-Reply-To: <20040913014622.3addde90.pj@sgi.com>
References: <20040912200253.3d7a6ff5.pj@sgi.com>
	<20040913065621.GB12185@wotan.suse.de>
	<20040913001548.278bf672.akpm@osdl.org>
	<20040913014622.3addde90.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Argh ... undo Andi's patch that undid Brent's patch that undid Andi's API ...

It was Linus' bk tree, not Andrew's *-mm tree, that needed the
"--maxnode" put back in.  Andrew's tree already has the "--maxnode"
that it should have in the "get_nodes()" routine.

If you apply Andi's patch to Andrew's *-mm tree, then a second nearby
similar looking routine "get_zonemask()" gets the second "--maxnode",
and she doesn't build anymore, failing with:

  mm/mempolicy.c: In function `get_zonemask':
  mm/mempolicy.c:419: error: `maxnode' undeclared (first use in this function)

This applies on top of 2.6.9-rc1-mm5.

Index: 2.6.9-rc1-mm5/mm/mempolicy.c
===================================================================
--- 2.6.9-rc1-mm5.orig/mm/mempolicy.c	2004-09-13 04:23:57.000000000 -0700
+++ 2.6.9-rc1-mm5/mm/mempolicy.c	2004-09-13 05:00:15.000000000 -0700
@@ -416,7 +416,6 @@ static void get_zonemask(struct mempolic
 {
 	int i;
 
-	--maxnode;
 	bitmap_zero(nodes, MAX_NUMNODES);
 	switch (p->policy) {
 	case MPOL_BIND:


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
