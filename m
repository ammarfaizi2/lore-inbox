Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWHXLaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWHXLaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWHXLaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:30:20 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:5866 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751157AbWHXLaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:30:18 -0400
Date: Thu, 24 Aug 2006 13:30:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, fpavlic@de.ibm.com
Subject: [patch] s390: qdio_get_micros return value.
Message-ID: <20060824113015.GF7022@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Pavlic <fpavlic@de.ibm.com>

[S390] qdio_get_micros return value.

qdio_get_micros is supposed to return microseconds. The get_clock()
return value needs to be shifted by 12 to get to microseconds. 

Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2006-08-24 12:09:54.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2006-08-24 12:10:57.000000000 +0200
@@ -115,7 +115,7 @@ qdio_min(int a,int b)
 static inline __u64 
 qdio_get_micros(void)
 {
-        return (get_clock() >> 10); /* time>>12 is microseconds */
+	return (get_clock() >> 12); /* time>>12 is microseconds */
 }
 
 /* 
