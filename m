Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751805AbWG0RTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbWG0RTa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWG0RTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:19:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:18571 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751805AbWG0RT3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:19:29 -0400
Subject: [PATCH] timer: Fix tvec_bases initializer
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 10:19:28 -0700
Message-Id: <1154020768.12517.87.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/timer.c defines a (per-cpu) pointer to tvec_base_t, but initializes it
using { &a_tvec_base_t }, which sparse warns about; change this to just
&a_tvec_base_t.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/timer.c b/kernel/timer.c
index 05809c2..793a847 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -84,7 +84,7 @@ typedef struct tvec_t_base_s tvec_base_t
 
 tvec_base_t boot_tvec_bases;
 EXPORT_SYMBOL(boot_tvec_bases);
-static DEFINE_PER_CPU(tvec_base_t *, tvec_bases) = { &boot_tvec_bases };
+static DEFINE_PER_CPU(tvec_base_t *, tvec_bases) = &boot_tvec_bases;
 
 static inline void set_running_timer(tvec_base_t *base,
 					struct timer_list *timer)


