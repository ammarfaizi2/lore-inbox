Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbUK3Hsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUK3Hsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 02:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUK3Hsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 02:48:37 -0500
Received: from apollo.nbase.co.il ([194.90.137.2]:54543 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S262005AbUK3Hrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 02:47:49 -0500
Message-ID: <41AA2A43.4000507@mrv.com>
Date: Sun, 28 Nov 2004 21:42:59 +0200
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, remi.colinet@wanadoo.fr
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Ingo,
> 
> I'm getting this error with V0.7.31-13
> 
...
> CC kernel/latency.o
> kernel/latency.c: In function `check_critical_timing':
> kernel/latency.c:730: too few arguments to function `___trace'
> kernel/latency.c:730: warning: too few arguments passed to inline function, suppressing inlining
> kernel/latency.c: In function `__start_critical_timing':
> kernel/latency.c:810: incompatible type for argument 1 of `____trace'
> kernel/latency.c:810: warning: passing arg 2 of `____trace' makes pointer from integer without a cast
...

> kernel/latency.c:810: warning: too few arguments passed to inline function, suppressing inlining
> make[1]: *** [kernel/latency.o] Error 1
> make: *** [kernel] Error 2
> [root@tigre01 im]#
> 
> Regards
> Remi
I'm guessing here, but with the following patch it at least compiles:

--- kernel/latency.c.orig       2004-11-28 21:32:04.757015856 +0200
+++ kernel/latency.c    2004-11-28 21:28:28.000000000 +0200
@@ -727,7 +727,7 @@
         tr->critical_end = parent_eip;

  #ifdef CONFIG_LATENCY_TRACE
-       ___trace(CALLER_ADDR0, parent_eip);
+       ___trace(TRACE_FN, CALLER_ADDR0, parent_eip, 0, 0, 0);
         update_max_trace(tr);
  #endif

@@ -807,7 +807,7 @@
         tr->critical_start = eip;
  #ifdef CONFIG_LATENCY_TRACE
         tr->trace_idx = 0;
-       ____trace(tr, eip, parent_eip, 0, 0, 0);
+       ____trace(TRACE_FN, tr, eip, parent_eip, 0, 0, 0);
  #endif

         atomic_dec(&tr->disabled);

-- 
Eran Mann
Senior Software Engineer
MRV International
Tel: 972-4-9936297
Fax: 972-4-9890430
www.mrv.com
