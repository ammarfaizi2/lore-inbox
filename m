Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757425AbWKWQvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbWKWQvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 11:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757428AbWKWQvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 11:51:17 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:40841
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1757429AbWKWQvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 11:51:15 -0500
Date: Thu, 23 Nov 2006 16:50:41 +0000
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Mel Gorman <mel@csn.ul.ie>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] lumpy take the other active inactive pages in the area
Message-ID: <a7271f89e386843830843a2dfcd5b877@pinky>
References: <exportbomb.1164300519@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1164300519@pinky>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lumpy: take the other active/inactive pages in the area

When we scan an order N aligned area around our tag page take any
other pages with a matching active state to that of the tag page.
This will tend to demote areas of the order we are interested from
the active list to the inactive list and from the end of the inactive
list, increasing the chances of such areas coming free together.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/mm/vmscan.c b/mm/vmscan.c
index e3be888..50e95ed 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -713,7 +713,7 @@ static unsigned long isolate_lru_pages(u
 			case 0:
 				list_move(&tmp->lru, dst);
 				nr_taken++;
-				continue;
+				break;
 
 			case -EBUSY:
 				/* else it is being freed elsewhere */
@@ -721,7 +721,6 @@ static unsigned long isolate_lru_pages(u
 			default:
 				break;
 			}
-			break;
 		}
 	}
 
