Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWH1NfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWH1NfK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 09:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWH1NfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 09:35:10 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:14792 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750817AbWH1NfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 09:35:08 -0400
Date: Mon, 28 Aug 2006 15:34:56 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch -mm] s390: fix do_gettimeoffset
Message-ID: <20060828133456.GB9861@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

kill-wall_jiffies.patch breaks s390's do_gettimeoffset(). Fix this and do a
small whitespace cleanup while we are at it.

Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/time.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-mm3/arch/s390/kernel/time.c
===================================================================
--- linux-2.6.18-rc4-mm3.orig/arch/s390/kernel/time.c	2006-08-28 10:32:45.000000000 +0200
+++ linux-2.6.18-rc4-mm3/arch/s390/kernel/time.c	2006-08-28 10:42:33.000000000 +0200
@@ -85,7 +85,8 @@
 {
 	__u64 now;
 
-        now = (get_clock() - jiffies_timer_cc) >> 12;
+	now = (get_clock() - jiffies_timer_cc) >> 12;
+	now -= (__u64) jiffies * USECS_PER_JIFFY;
 	return (unsigned long) now;
 }
 
