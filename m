Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWICNCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWICNCM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWICNCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 09:02:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:24205 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751021AbWICNCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 09:02:10 -0400
Date: Sun, 3 Sep 2006 14:54:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc5-mm1 + all hotfixes -- BUG: MAX_STACK_TRACE_ENTRIES too low!
Message-ID: <20060903125458.GA21390@elte.hu>
References: <a44ae5cd0609022003i2b3157a2kb8bcd6f4f778b6c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44ae5cd0609022003i2b3157a2kb8bcd6f4f778b6c9@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Miles Lane <miles.lane@gmail.com> wrote:

> Sorry Andrew.  I don't see clues here to help me target the report to 
> a maintainer. I hope this helps.
> 
> BUG: MAX_STACK_TRACE_ENTRIES too low!
> turning off the locking correctness validator.

Miles, could you try the patch below? (Andrew: if this solves Miles' 
problem then i think this is v2.6.18 material too. [The other 
possibility would be some permanent stack-trace entries leak, in which 
case the patch will not help. If that happens then we'll have to debug 
this some more.])

	Ingo

---------------->
From: Ingo Molnar <mingo@elte.hu>
Subject: lockdep: double the number of stack-trace entries

Miles Lane reported the "BUG: MAX_STACK_TRACE_ENTRIES too low!" message,
which means that during normal use his system produced enough lockdep
events so that the 128-thousand entries stack-trace array got exhausted.
Double the size of the array.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/lockdep_internals.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/lockdep_internals.h
===================================================================
--- linux.orig/kernel/lockdep_internals.h
+++ linux/kernel/lockdep_internals.h
@@ -27,7 +27,7 @@
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
  */
-#define MAX_STACK_TRACE_ENTRIES	131072UL
+#define MAX_STACK_TRACE_ENTRIES	262144UL
 
 extern struct list_head all_lock_classes;
 

-- 
VGER BF report: U 0.5
