Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWFSM2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWFSM2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFSMZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:25:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1214 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932420AbWFSMZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:25:15 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 11/15] frv: NULL noise removal in frv xchg()
Date: Mon, 19 Jun 2006 13:25:07 +0100
To: torvalds@osdl.org, akpm@osdl.org, viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060619122507.10060.93376.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
References: <20060619122445.10060.97532.stgit@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Clean up the FRV arch's xchg() function.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-Off-By: David Howells <dhowells@redhat.com>
---

 include/asm-frv/atomic.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-frv/atomic.h b/include/asm-frv/atomic.h
index 5d9f84b..68a8e8d 100644
--- a/include/asm-frv/atomic.h
+++ b/include/asm-frv/atomic.h
@@ -228,7 +228,7 @@ ({										\
 		break;								\
 										\
 	default:								\
-		__xg_orig = 0;							\
+		__xg_orig = (__typeof__(__xg_orig))0;				\
 		asm volatile("break");						\
 		break;								\
 	}									\
@@ -248,7 +248,7 @@ ({												\
 	switch (sizeof(__xg_orig)) {								\
 	case 4: __xg_orig = (__typeof__(*(ptr))) __xchg_32((uint32_t) x, __xg_ptr);	break;	\
 	default:										\
-		__xg_orig = 0;									\
+		__xg_orig = (__typeof__(__xg_orig))0;									\
 		asm volatile("break");								\
 		break;										\
 	}											\

