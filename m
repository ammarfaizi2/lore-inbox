Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751817AbWG0RVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbWG0RVp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWG0RVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:21:45 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:48533 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751817AbWG0RVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:21:44 -0400
Subject: [PATCH] timer: Add lock annotation to lock_timer_base
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 10:21:46 -0700
Message-Id: <1154020906.12517.88.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lock_timer_base acquires a lock and returns with that lock held.  Add a lock
annotation to this function so that sparse can check callers for lock pairing,
and so that sparse will not complain about this function since it
intentionally uses the lock in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/timer.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 05809c2..c1dc57d 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -175,6 +175,7 @@ static inline void detach_timer(struct t
  */
 static tvec_base_t *lock_timer_base(struct timer_list *timer,
 					unsigned long *flags)
+	__acquires(timer->base->lock)
 {
 	tvec_base_t *base;
 


