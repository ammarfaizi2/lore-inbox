Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVEaH0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVEaH0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbVEaH0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:26:13 -0400
Received: from apollo.nbase.co.il ([194.90.137.2]:19726 "EHLO
	apollo.nbase.co.il") by vger.kernel.org with ESMTP id S261284AbVEaH0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:26:09 -0400
Message-ID: <429C1206.5000707@mrv.com>
Date: Tue, 31 May 2005 10:28:06 +0300
From: emann@mrv.com (Eran Mann)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc5-V0.7.47-10
References: <20050527072810.GA7899@elte.hu>
In-Reply-To: <20050527072810.GA7899@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.47-10 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/
> 

I tried to compile -V0.7.47-15 and it fails to compile.
net/sunrpc/sched.c: In function `rpc_run_timer':
net/sunrpc/sched.c:107: error: `RPC_TASK_HAS_TIMER' undeclared (first 
use in this function)
...

It seems the following hunk of the patch is bogus as it removes a 
required define:

--- linux/include/linux/sunrpc/sched.h.orig
+++ linux/include/linux/sunrpc/sched.h
@@ -138,7 +138,6 @@ typedef void 
(*rpc_action)(struct rpc_
  #define RPC_TASK_RUNNING       0
  #define RPC_TASK_QUEUED                1
  #define RPC_TASK_WAKEUP                2
-#define RPC_TASK_HAS_TIMER     3

  #define RPC_IS_RUNNING(t)      (test_bit(RPC_TASK_RUNNING, 
&(t)->tk_runstate))
  #define rpc_set_running(t)     (set_bit(RPC_TASK_RUNNING, 
&(t)->tk_runstate))

