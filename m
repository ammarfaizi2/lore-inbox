Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVANTGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVANTGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 14:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVANTGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 14:06:14 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:63905 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261399AbVANS4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:56:23 -0500
Date: Fri, 14 Jan 2005 19:56:21 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 7/8] s390: vol1 partition recognition.
Message-ID: <20050114185621.GG6789@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 7/8] s390: vol1 partition recognition.

From: Carsten Otte <cotte@de.ibm.com>

Make the ECKD compatible disk layout labling detection conditional
to run only on ECKD compatible disk layout volumes, do a fall back
into the default LNX/unlabled case otherwise.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 fs/partitions/ibm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -urN linux-2.6/fs/partitions/ibm.c linux-2.6-patched/fs/partitions/ibm.c
--- linux-2.6/fs/partitions/ibm.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6-patched/fs/partitions/ibm.c	2005-01-14 19:45:21.000000000 +0100
@@ -114,7 +114,8 @@
 		}
 		put_partition(state, 1, offset*(blocksize >> 9),
 				 size-offset*(blocksize >> 9));
-	} else if (strncmp(type, "VOL1", 4) == 0) {
+	} else if ((strncmp(type, "VOL1", 4) == 0) &&
+		(!info->FBA_layout) && (!strcmp(info->type, "ECKD"))) {
 		/*
 		 * New style VOL1 labeled disk
 		 */
