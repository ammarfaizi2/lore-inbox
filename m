Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757734AbWLCRCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbWLCRCd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 12:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757736AbWLCRCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 12:02:33 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:29064 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1757688AbWLCRCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 12:02:32 -0500
Date: Sun, 3 Dec 2006 18:02:31 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: radix-tree.c:__lookup_slot() dead code removal
Message-ID: <20061203170231.GA20298@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the code suggests that it is valid to insert a NULL item,
possibly a zero item with pointer cast. However, in __lookup_slot()
whether or not the slot is found seems to depend on the actual value
of the item in one special case. But further on it doesn't make any
difference so to remove some dead code:

--- a/lib/radix-tree.c	2006-12-03 13:23:00.000000000 +0100
+++ b/lib/radix-tree.c	2006-12-03 17:57:03.000000000 +0100
@@ -319,9 +319,6 @@ static inline void **__lookup_slot(struc
 	if (index > radix_tree_maxindex(height))
 		return NULL;
 
-	if (height == 0 && root->rnode)
-		return (void **)&root->rnode;
-
 	shift = (height-1) * RADIX_TREE_MAP_SHIFT;
 	slot = &root->rnode;
 

-- 
Frank
