Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318285AbSGYAKS>; Wed, 24 Jul 2002 20:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSGYAKS>; Wed, 24 Jul 2002 20:10:18 -0400
Received: from tomts9.bellnexxia.net ([209.226.175.53]:43909 "EHLO
	tomts9-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S318285AbSGYAKQ>; Wed, 24 Jul 2002 20:10:16 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] move slab pages to the lru, for 2.5.27
Date: Wed, 24 Jul 2002 20:12:59 -0400
X-Mailer: KMail [version 1.4]
Cc: Craig Kulesa <ckulesa@as.arizona.edu>, Steven Cole <elenstev@mesatop.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Steven Cole <scole@lanl.gov>, Rik van Riel <riel@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200207242012.59150.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch fixes the SMP problems for Steve.  It was a thinko I put in to check things...  In SMP 
it was just plain broken.  Patch is against 2.4.26 with Craig's patches but works on 2.5.27 and 
2.4.x too.  My bk tree with slablru based on linux-2.4-rmap at casa.dyndns.org:3334 has also 
been updated.

Thanks,
Ed Tomlinson


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.430   -> 1.431  
#	           mm/slab.c	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	ed@oscar.et.ca	1.431
# Prevent false out of memory reporting in SMP
# --------------------------------------------
#
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Wed Jul 24 17:22:31 2002
+++ b/mm/slab.c	Wed Jul 24 17:22:31 2002
@@ -1309,8 +1309,6 @@
 #else
 		locked = !in_interrupt() && spin_trylock(&pagemap_lru_lock);
 #endif
-		if (!locked && !in_interrupt())
-			goto opps1;
 	}
 
 	/* Get slab management. */

