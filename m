Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262127AbSIYWzE>; Wed, 25 Sep 2002 18:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262136AbSIYWzE>; Wed, 25 Sep 2002 18:55:04 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:32964 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S262127AbSIYWzC>;
	Wed, 25 Sep 2002 18:55:02 -0400
Date: Wed, 25 Sep 2002 16:00:15 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200209252300.g8PN0FGO019455@napali.hpl.hp.com>
To: akpm@digeo.com
cc: linux-kernel@vger.kernel.org
Subject: [patch] make mprotect() work again
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-to: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

 ChangeSet@1.536.31.4, 2002-09-17 20:35:47-07:00, akpm@digeo.com
  [PATCH] consolidate the VMA splitting code

broke mprotect().  The patch below makes it work again.

	--david

===== mm/mprotect.c 1.16 vs edited =====
--- 1.16/mm/mprotect.c	Tue Sep 17 11:05:14 2002
+++ edited/mm/mprotect.c	Wed Sep 25 15:48:39 2002
@@ -186,8 +186,10 @@
 		/*
 		 * Try to merge with the previous vma.
 		 */
-		if (mprotect_attempt_merge(vma, *pprev, end, newflags))
+		if (mprotect_attempt_merge(vma, *pprev, end, newflags)) {
+			change_protection(vma, start, end, newprot);
 			return 0;
+		}
 	} else {
 		error = split_vma(mm, vma, start, 1);
 		if (error)
