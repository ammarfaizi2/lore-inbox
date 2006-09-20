Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWITCnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWITCnB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 22:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWITCnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 22:43:01 -0400
Received: from smtp-out.google.com ([216.239.45.12]:49179 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750782AbWITCnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 22:43:00 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:message-id:x-mailer:
	in-reply-to:references;
	b=VzIKFjBaK7Z9GusjiK/OZM51RJEITnAiw5npdysxSfSGQk4zm2xRvZG2fwzG4Ju5J
	jXRePyc04mUbgLYBZ+ubg==
From: Dmitriy Zavin <dmitriyz@google.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org
Subject: [PATCH 2/4] jiffies: Add 64bit jiffies compares (needed when long < 64bit).
Date: Tue, 19 Sep 2006 19:42:40 -0700
Message-Id: <11587201621900-git-send-email-dmitriyz@google.com>
X-Mailer: git-send-email 1.4.2
In-Reply-To: <11587201623187-git-send-email-dmitriyz@google.com>
References: <11587201623432-git-send-email-dmitriyz@google.com> <11587201623187-git-send-email-dmitriyz@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitriy Zavin <dmitriyz@google.com>
---
 include/linux/jiffies.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 329ebcf..dc74075 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -115,6 +115,18 @@ #define time_after_eq(a,b)	\
 	 ((long)(a) - (long)(b) >= 0))
 #define time_before_eq(a,b)	time_after_eq(b,a)
 
+#define time_after64(a,b)		\
+	(typecheck(__u64, a) && \
+	 typecheck(__u64, b) && \
+	 ((__s64)(b) - (__s64)(a) < 0))
+#define time_before64(a,b)	time_after64(b,a)
+
+#define time_after_eq64(a,b)	\
+	(typecheck(__u64, a) && \
+	 typecheck(__u64, b) && \
+	 ((__s64)(a) - (__s64)(b) >= 0))
+#define time_before_eq64(a,b)	time_after_eq64(b,a)
+
 /*
  * Have the 32 bit jiffies value wrap 5 minutes after boot
  * so jiffies wrap bugs show up earlier.
-- 
1.4.2

