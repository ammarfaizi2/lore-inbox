Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263653AbUECMXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263653AbUECMXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbUECMXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:23:08 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33688 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263653AbUECMXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:23:02 -0400
Date: Mon, 3 May 2004 17:54:12 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-ID: <20040503122412.GB7143@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040430113751.GA18296@in.ibm.com> <20040430191901.510ae947.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430191901.510ae947.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 07:19:01PM -0700, Andrew Morton wrote:
> Yes, the logic in worker_thread() is a bit dorky, but I
> don't believe that there is a race in there.

worker_thread examines kthread_should_stop() while its state
is TASK_RUNNING, after which it sets its state to TASK_INTERRUPTIBLE.
If kthread_stop were to come after kthread_should_stop and before
worker_thread has set its state to TASK_INTERRUPTIBLE (which is possible
because of a CPU going dead), wouldn't kthread_stop block forever? 
Note that in case of CPU going dead, it is possible that a worker
thread bound to the dead cpu continues executing on a different cpu 
before it is killed in CPU_DEAD processing.

Am I missing something here?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
