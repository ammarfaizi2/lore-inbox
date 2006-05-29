Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWE2VXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWE2VXl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWE2VXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:23:38 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:18130 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751321AbWE2VXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:23:03 -0400
Date: Mon, 29 May 2006 23:23:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 04/61] lock validator: mutex section binutils workaround
Message-ID: <20060529212323.GD3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

work around weird section nesting build bug causing smp-alternatives
failures under certain circumstances.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 kernel/mutex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -309,7 +309,7 @@ static inline int __mutex_trylock_slowpa
  * This function must not be used in interrupt context. The
  * mutex must be released by the same task that acquired it.
  */
-int fastcall mutex_trylock(struct mutex *lock)
+int fastcall __sched mutex_trylock(struct mutex *lock)
 {
 	return __mutex_fastpath_trylock(&lock->count,
 					__mutex_trylock_slowpath);
