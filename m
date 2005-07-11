Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261990AbVGKQhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261990AbVGKQhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVGKQes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:34:48 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:12932 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261990AbVGKQdm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:33:42 -0400
Date: Mon, 11 Jul 2005 18:33:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 3/12] s390: atomic64 inline functions.
Message-ID: <20050711163340.GC10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/12] s390: atomic64 inline functions.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The atomic64 primitives are supposed to have 64-bit parameters
instead of int.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 include/asm-s390/atomic.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/include/asm-s390/atomic.h linux-2.6-patched/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/atomic.h	2005-07-11 17:37:43.000000000 +0200
@@ -123,19 +123,19 @@ typedef struct {
 #define atomic64_read(v)          ((v)->counter)
 #define atomic64_set(v,i)         (((v)->counter) = (i))
 
-static __inline__ void atomic64_add(int i, atomic64_t * v)
+static __inline__ void atomic64_add(long long i, atomic64_t * v)
 {
 	       __CSG_LOOP(v, i, "agr");
 }
-static __inline__ long long atomic64_add_return(int i, atomic64_t * v)
+static __inline__ long long atomic64_add_return(long long i, atomic64_t * v)
 {
 	return __CSG_LOOP(v, i, "agr");
 }
-static __inline__ long long atomic64_add_negative(int i, atomic64_t * v)
+static __inline__ long long atomic64_add_negative(long long i, atomic64_t * v)
 {
 	return __CSG_LOOP(v, i, "agr") < 0;
 }
-static __inline__ void atomic64_sub(int i, atomic64_t * v)
+static __inline__ void atomic64_sub(long long i, atomic64_t * v)
 {
 	       __CSG_LOOP(v, i, "sgr");
 }
