Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWFYCMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWFYCMf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 22:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWFYCMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 22:12:35 -0400
Received: from tus-mailout1.raytheon.com ([199.46.245.198]:464 "EHLO
	tus-mailout1.ext.ray.com") by vger.kernel.org with ESMTP
	id S1751352AbWFYCMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 22:12:34 -0400
Message-ID: <449DF0FC.1050609@raytheon.com>
Date: Sat, 24 Jun 2006 19:12:12 -0700
From: Robert Crocombe <rwcrocombe@raytheon.com>
Organization: Raytheon Missile Systems -- Tucson, AZ, U.S.
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
Subject: 2.6.17-rt1: Patch for NUMA mm/slab.c
Content-Type: multipart/mixed;
 boundary="------------020809000908010002050501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020809000908010002050501
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed

Needed to add this_cpu in a couple of places.  Compiled and no problems 
so far...

Hopefully not mangled by mailer.

Signed-off-by: Robert Crocombe <rwcrocombe@raytheon.com>

-- 
Robert Crocombe
rwcrocombe@raytheon.com

--------------020809000908010002050501
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="missing_this_cpu_in_slab_c"
Content-Disposition: inline;
 filename="missing_this_cpu_in_slab_c"

--- linux-2.6.17/mm/slab.c	2006-06-24 16:17:08.000000000 -0700
+++ 2.6.17-rt/mm/slab.c	2006-06-24 15:39:40.000000000 -0700
@@ -3243,14 +3243,16 @@
 				if (unlikely(alien->avail == alien->limit)) {
 					STATS_INC_ACOVERFLOW(cachep);
 					__drain_alien_cache(cachep,
-							    alien, nodeid);
+							    alien, nodeid,
+                                                            this_cpu);
 				}
 				alien->entry[alien->avail++] = objp;
 				spin_unlock(&alien->lock);
 			} else {
 				spin_lock(&(cachep->nodelists[nodeid])->
 					  list_lock);
-				free_block(cachep, &objp, 1, nodeid);
+				free_block(cachep, &objp, 1, nodeid,
+                                                this_cpu);
 				spin_unlock(&(cachep->nodelists[nodeid])->
 					    list_lock);
 			}

--------------020809000908010002050501--

