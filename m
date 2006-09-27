Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWI0Qgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWI0Qgs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 12:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbWI0Qgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 12:36:48 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:19624 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751220AbWI0Qgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:36:47 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][AIO] Remove BUG_ON(unlikely) in include/linux/aio.h
Date: Wed, 27 Sep 2006 18:37:29 +0200
User-Agent: KMail/1.9.4
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609271837.29301.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BUG_ON() does this unlikely check itself, as bugs in Linux are unlikely
anyway :)

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
Acked-by: Zach Brown <zach.brown@oracle.com>

---
commit 0764f582b694c80d0cd1db8f3320db5112b9053c
tree ed9907f05b09d7b16d8c1a6e4013eaffd0f2b42b
parent f0544b86176beef7fa05f4c009bc46f142717cbf
author Rolf Eike Beer <eike-kernel@sf-tec.de> Fri, 28 Jul 2006 10:30:30 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Fri, 28 Jul 2006 10:30:30 +0200

 include/linux/aio.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/aio.h b/include/linux/aio.h
index 00c8efa..8a01933 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -213,11 +213,11 @@ int FASTCALL(io_submit_one(struct kioctx
 				  struct iocb *iocb));
 
 #define get_ioctx(kioctx) do {						\
-	BUG_ON(unlikely(atomic_read(&(kioctx)->users) <= 0));		\
+	BUG_ON(atomic_read(&(kioctx)->users) <= 0);			\
 	atomic_inc(&(kioctx)->users);					\
 } while (0)
 #define put_ioctx(kioctx) do {						\
-	BUG_ON(unlikely(atomic_read(&(kioctx)->users) <= 0));		\
+	BUG_ON(atomic_read(&(kioctx)->users) <= 0);			\
 	if (unlikely(atomic_dec_and_test(&(kioctx)->users))) 		\
 		__put_ioctx(kioctx);					\
 } while (0)
