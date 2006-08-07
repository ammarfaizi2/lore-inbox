Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWHGNHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWHGNHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 09:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWHGNHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 09:07:35 -0400
Received: from ns.suse.de ([195.135.220.2]:35203 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750915AbWHGNHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 09:07:35 -0400
Date: Mon, 7 Aug 2006 15:07:29 +0200
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix hrtimer percpu usage typo
Message-ID: <20060807130729.GT4995@hasse.suse.de>
MIME-Version: 1.0
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="percpu-hrtimer-fix.diff"
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Blunck <jblunck@suse.de>
Subject: fix hrtimer percpu usage

The percpu variable is used incorrectly in switch_hrtimer_base().

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 kernel/hrtimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/kernel/hrtimer.c
===================================================================
--- linux-2.6.orig/kernel/hrtimer.c
+++ linux-2.6/kernel/hrtimer.c
@@ -187,7 +187,7 @@ switch_hrtimer_base(struct hrtimer *time
 {
 	struct hrtimer_base *new_base;
 
-	new_base = &__get_cpu_var(hrtimer_bases[base->index]);
+	new_base = &__get_cpu_var(hrtimer_bases)[base->index];
 
 	if (base != new_base) {
 		/*
