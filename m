Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423163AbWF1FVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423163AbWF1FVG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 01:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423184AbWF1FUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 01:20:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:63619 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423163AbWF1FUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 01:20:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Mis/dprEH6AsFupYFgjb5c9zcZ3NKhEglzXazQalTS8T/1AzohZnOc1ooOuZl59L8AhQtsF7PQsJHMpHNk+68d2KXcpaJw89eg3CyetvPZR9+F2AXrsDB7G8yu6DixsOgh9MOrqw7F62xlaT92m8EZzSVg7+pI5yQal3ZL81g4M=
Message-ID: <615cd8d10606272220w1cfe00b2u62a68d4689b6960d@mail.gmail.com>
Date: Wed, 28 Jun 2006 05:20:00 +0000
From: "Brian Hsu" <brianhsu.hsu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to switch to another process at schedule() ?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm here again.

I'm trying to do a homework which teacher ask us impelement a simple
EDF scheduling policy.
Now I have maintain a EDF process link-list successfully, and the
link-list is well sorted too.

Then I went to schedule() function, add something like this:

What I want to do is if the scheduler selected an EDF process as next process,
I will like to do is compare this process with the first one process
in EDF link-list.

If it is same process, then we have nothing to do, just context switch
to new process
because it has the earlist deadline.

But if it is not the same process, I would like to replace the "next"
process by the first
process in the EDF linked-list.

I have tried some method, but still can get it work. The following one
works fine,
but when the process has earlier deadline exit, the former process
would not get back
to run queue.

What sould I check now?

Following is the code I tried to get it work, but faild.

================ Code ========================
        next = list_entry(queue->next, task_t, run_list);

        if ( next->policy == SCHED_EDF ) {

            struct task_struct * task = list_entry( edf_queue.next, task_t,
                                                    edf_node );

            if ( task != next ) {
                printk ( "Active EDF[%d]\n", task->pid );
                printk ( "Deactive EDF[%d]\n", next->pid );

                // Works Fine.
                // But how can I get next back to run queue?
                dequeue_task ( task, array );
                set_tsk_need_resched ( next );
		enqueue_task_head (task, array);

                // It will hang up if I let the former process stay in queue.
                /*
                //dequeue_task ( task, array );
                //set_tsk_need_resched (next );
       		enqueue_task_head (task, array);
                rq->nr_running++;
                */
                next = task;
            }
        }
====================== End ==========================
