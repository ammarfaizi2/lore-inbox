Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVEaMAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVEaMAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 08:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEaMAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 08:00:23 -0400
Received: from mail.renesas.com ([202.234.163.13]:55021 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261878AbVEaMAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 08:00:15 -0400
Date: Tue, 31 May 2005 21:00:02 +0900 (JST)
Message-Id: <20050531.210002.796978732.takata.hirokazu@renesas.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc5-mm1] m32r: Insert set_tsk_need_resched() to
 cpu_idle() (was Re: 2.6.12-rc5-mm1)
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20050525134933.5c22234a.akpm@osdl.org>
References: <20050525134933.5c22234a.akpm@osdl.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>
Subject: 2.6.12-rc5-mm1
Date: Wed, 25 May 2005 13:49:33 -0700
> - The CPU scheduler is probably busted on the less-common architectures. 
>   For now, those architectures will need to emulate
>   sched-remove-set_tsk_need_resched-from-init_idle-v2-ia64-fix.patch

Here is a patch for m32r.
Please apply.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -ruNp a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
--- a/arch/m32r/kernel/process.c	2005-03-07 14:10:21.000000000 +0900
+++ b/arch/m32r/kernel/process.c	2005-05-31 10:49:03.000000000 +0900
@@ -94,6 +94,8 @@ static void poll_idle (void)
  */
 void cpu_idle (void)
 {
+	set_tsk_need_resched(current);
+
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {


--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
