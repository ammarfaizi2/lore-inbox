Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbVCQO4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVCQO4L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 09:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbVCQO4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 09:56:11 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:16075 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S263079AbVCQO4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 09:56:05 -0500
Date: Thu, 17 Mar 2005 15:56:17 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/8] s390: define atomic_sub_return.
Message-ID: <20050317145617.GB4807@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/8] s390: define atomic_sub_return.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add missing atomic_sub_return for skb_release_data.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-s390/atomic.h |    4 ++++
 1 files changed, 4 insertions(+)

diff -urN linux-2.6/include/asm-s390/atomic.h linux-2.6-patched/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/atomic.h	2005-03-17 15:35:58.000000000 +0100
@@ -61,6 +61,10 @@
 {
 	       __CS_LOOP(v, i, "sr");
 }
+static __inline__ int atomic_sub_return(int i, atomic_t * v)
+{
+	return __CS_LOOP(v, i, "sr");
+}
 static __inline__ void atomic_inc(volatile atomic_t * v)
 {
 	       __CS_LOOP(v, 1, "ar");
