Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWFQJ1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWFQJ1I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 05:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWFQJ1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 05:27:08 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:50937 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751226AbWFQJ1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 05:27:07 -0400
Subject: [Patch] statistics infrastructure - update 4
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Wu Fengguang <wfg@mail.ustc.edu.cn>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 11:26:55 +0200
Message-Id: <1150536415.2989.9.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an endless loop that might hang the statistics code
when it is parsing options. I assume it also fixes the soft
lockup reported by Wu. Please apply.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 statistic.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

--- a/lib/statistic.c	13 Jun 2006 15:14:27 -0000	1.49
+++ b/lib/statistic.c	13 Jun 2006 15:23:19 -0000	1.50
@@ -721,12 +721,7 @@
 		for (offset = 0; offset < seg->offset; offset += seg_nl->size) {
 			seg_nl = kmalloc(sizeof(struct sgrb_seg), GFP_KERNEL);
 			if (unlikely(!seg_nl))
-				/*
-				 * FIXME:
-				 * Should we omit other new settings because we
-				 * could not process this line of definitions?
-				 */
-				continue;
+				goto out;
 			seg_nl->address = seg->address + offset;
 			nl = strnchr(seg_nl->address,
 				     seg->offset - offset, '\n');
@@ -745,6 +740,7 @@
 			}
 		}
 	}
+out:
 	if (!list_empty(&line_lh))
 		statistic_parse(interface, &line_lh, line_size);
 	return statistic_generic_close(inode, file);


