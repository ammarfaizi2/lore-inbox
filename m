Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWA2Voo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWA2Voo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:44:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWA2Voo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:44:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52199 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751177AbWA2Voo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:44:44 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] pid: Since we aren't hashing pid 0 don't try
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 14:44:15 -0700
Message-ID: <m1vew27lqo.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a tidbit i missed in my code to stop hashing pid 0.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/pid.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

d634915984d3e2d7ac13aaff1ee0e23406fe0e74
diff --git a/kernel/pid.c b/kernel/pid.c
index 7c40310..aea6775 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -363,11 +363,4 @@ void __init pidmap_init(void)
 	pidmap_array->page = (void *)get_zeroed_page(GFP_KERNEL);
 	set_bit(0, pidmap_array->page);
 	atomic_dec(&pidmap_array->nr_free);
-
-	/*
-	 * Allocate PID 0, and hash it via all PID types:
-	 */
-
-	for (i = 0; i < PIDTYPE_MAX; i++)
-		attach_pid(current, i, 0);
 }
-- 
1.1.5.g3480

