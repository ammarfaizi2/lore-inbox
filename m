Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWAWMD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWAWMD2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWAWMD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:03:28 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:65452 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750893AbWAWMD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:03:28 -0500
Date: Mon, 23 Jan 2006 13:03:03 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Subject: [PATCH 4/4] s390: Add missing memory constraint to stcrw().
Message-ID: <20060123120303.GF9241@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Add missing memory constraint to stcrw() inline assembly.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/s390mach.h |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff -urpN linux-2.6/drivers/s390/s390mach.h linux-2.6-patched/drivers/s390/s390mach.h
--- linux-2.6/drivers/s390/s390mach.h	2006-01-03 04:21:10.000000000 +0100
+++ linux-2.6-patched/drivers/s390/s390mach.h	2006-01-23 10:05:33.000000000 +0100
@@ -90,15 +90,16 @@ struct crw {
 
 static inline int stcrw(struct crw *pcrw )
 {
-        int ccode;
+	int ccode;
 
-        __asm__ __volatile__(
-                "STCRW 0(%1)\n\t"
-                "IPM %0\n\t"
-                "SRL %0,28\n\t"
-                : "=d" (ccode) : "a" (pcrw)
-                : "cc", "1" );
-        return ccode;
+	__asm__ __volatile__(
+		"stcrw 0(%2)\n\t"
+		"ipm %0\n\t"
+		"srl %0,28\n\t"
+		: "=d" (ccode), "=m" (*pcrw)
+		: "a" (pcrw)
+		: "cc" );
+	return ccode;
 }
 
 #endif /* __s390mach */
