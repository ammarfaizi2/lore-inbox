Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751058AbWFNT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWFNT3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWFNT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 15:29:22 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:34474 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751046AbWFNT3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 15:29:20 -0400
Date: Wed, 14 Jun 2006 21:29:20 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] tasklet_unlock_wait() cpu_relax()
Message-ID: <20060614192920.GD19938@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

use cpu_relax() here, too (instead of barrier()).

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc6-mm2.orig/include/linux/interrupt.h linux-2.6.17-rc6-mm2.my/include/linux/interrupt.h
--- linux-2.6.17-rc6-mm2.orig/include/linux/interrupt.h	2006-06-13 19:28:16.000000000 +0200
+++ linux-2.6.17-rc6-mm2.my/include/linux/interrupt.h	2006-06-14 20:35:49.000000000 +0200
@@ -227,7 +227,7 @@
 
 static inline void tasklet_unlock_wait(struct tasklet_struct *t)
 {
-	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { cpu_relax(); }
 }
 #else
 #define tasklet_trylock(t) 1
