Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267318AbUHIWkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267318AbUHIWkC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267327AbUHIWkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:40:02 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:11746 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267318AbUHIWj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:39:58 -0400
Date: Mon, 9 Aug 2004 17:39:55 -0500
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-mm@kvack.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] get_nodes mask miscalculation
Message-ID: <Pine.SGI.4.58.0408091731270.21911@kzerza.americas.sgi.com>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears there is a nodemask miscalculation in the get_nodes()
function in mm/mempolicy.c.  This bug has two effects:

1. It is impossible to specify a length 1 nodemask.
2. It is impossible to specify a nodemask containing the last node.

The following patch against 2.6.8-rc3 has been confirmed to solve
both problems.

Signed-off-by: Brent Casavant <bcasavan@sgi.com>

--- linux-2.6.8-rc3/mm/mempolicy.c      2004-08-03 16:28:51.000000000 -0500
+++ linux-work/mm/mempolicy.c   2004-08-09 14:56:44.000000000 -0500
@@ -132,7 +132,6 @@
        unsigned long nlongs;
        unsigned long endmask;

-       --maxnode;
        bitmap_zero(nodes, MAX_NUMNODES);
        if (maxnode == 0 || !nmask)
                return 0;

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
