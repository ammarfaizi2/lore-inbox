Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266252AbUAGRQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266253AbUAGRQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:16:29 -0500
Received: from zeus.kernel.org ([204.152.189.113]:23769 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266252AbUAGRQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:16:02 -0500
Date: Wed, 7 Jan 2004 11:12:40 -0600
From: Robin Holt <holt@sgi.com>
To: sena <auntvini@sedal.usyd.edu.au>
Cc: holt@sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uid-task_struct Code after Proper Naming and indentation
Message-ID: <20040107171240.GA31870@lnx-holt>
References: <3FFAF8AC.5040307@sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFAF8AC.5040307@sedal.usyd.edu.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 05:04:28AM +1100, sena wrote:

I haven't looked at your code to see what it is trying to
do.

I have, however made a simple module that will print out
the pid, uid, and euid for all processes.  On my system,
it clearly shows processes with non-zero pids and they
match exactly with what ps is showing.

Can you compile and run this to see if you have different
results?

As for the telnetd process, that _SHOULD_ have a uid
of 0.  That process is started as root.  It then forks,
sets uid and euid to the user it is starting, and then
execs the users shell.  The process remains around for
reaping children and then cleaning up the session when
the user logs off.  If you are expecting telnet to have
anything other than uid of 0, you need to look at what
it is designed to do.

Thanks,
Robin

#include <linux/sched.h>
#include <linux/module.h>


static int
count_active_tasks(void)
{
        struct task_struct *p;

        read_lock(&tasklist_lock);

        for_each_task(p) {
                printk(KERN_EMERG "Pid %d uid %d euid %d\n",
                       p->pid, p->uid, p->euid);
        }
        read_unlock(&tasklist_lock);
        return -1;
}

module_init(count_active_tasks);

> Hi Robin,
> 
> ps way of reading uid is good.
> 
> Though they are in 2 differant modes (kernel and user)
> 
> Will that be a problem?
> 
> Herewith I am sending to you the code after proper indentation.
> 
> In timer.c file I have included and then updated all the neccessary 
> functions else where accordingly.
> 
> unsigned long numof_root_tasks;    //for root uid<500, I am getting this 
> uidArray[0] is for storing uid (assumed 100 for all <500)
> unsigned long numof_uid500_tasks;    //for 500
> unsigned long numof_uid501_tasks;    //for 501
> unsigned long numof_uid502_tasks;    //for 502
> unsigned long numof_uid503_tasks;    //for 503
> unsigned long numof_uid504_tasks;    // for 504
> 
> unsigned int uidArray[7];
> 
> static unsigned long
> count_active_tasks(void)
> {
>    struct task_struct *p;
>    unsigned long nr = 0;
> 
>    int s = 0;
>    int i = 0;
>    int j = 0;
>    int k = 0;
>    int m = 0;
> 
> 
>    read_lock(&tasklist_lock);
> 
>    for_each_task(p) {
>        if ((p->state == TASK_RUNNING ||
>             (p->state & TASK_UNINTERRUPTIBLE))) {
> 
>            nr += FIXED_1;    //nr total tasks
>            if (i == 0) {
>                uidArray[0] = 100;
> 
>                if (p->uid < 500) {
>                    numof_root_tasks += FIXED_1;
>                } else {
>                    uidArray[1] = p->uid;
>                    numof_uid500_tasks += FIXED_1;
>                    k++;
>                }
>                k++;
>            } else {
>                for (j = 0; j < k; j++) {
>                    if ((j == 0) && (p->uid < 500)
>                        && (s == 0)) {
>                        numof_root_tasks +=
>                            FIXED_1;
>                        s = 1;
>                        break;
>                    } else if ((uidArray[j] == p->uid)
>                           && s == 0) {
>                        if (j == 1) {
>                            numof_uid500_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 2) {
>                            numof_uid501_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 3) {
>                            numof_uid502_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 4) {
>                            numof_uid503_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 5) {
>                            numof_uid504_tasks
>                                += FIXED_1;
>                        }
>                        s = 1;
>                        break;
>                    }
>                }
>                if (s == 0) {
> 
>                    if (k < 6) {
>                        k++;
>                        j = k - 1;
>                        uidArray[j] = p->uid;
>                        if (j == 1) {
>                            numof_uid500_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 2) {
>                            numof_uid501_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 3) {
>                            numof_uid502_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 4) {
>                            numof_uid503_tasks
>                                += FIXED_1;
>                        }
>                        if (j == 5) {
>                            numof_uid504_tasks
>                                += FIXED_1;
>                        }
>                    }
> 
>                }
> 
>                s = 0;
>            }
>            i++;
>        }
> 
>    }
>    read_unlock(&tasklist_lock);
>    return nr;
> 
> }
> 
> unsigned long avenrun[6];
> 
> unsigned long avenrunT;
> 
> static inline void
> calc_load(unsigned long ticks)
> {
>    unsigned long active_tasks;    /*fixed-point */
>    static int count = LOAD_FREQ;
> 
>    count -= ticks;
>    if (count < 0) {
>        count += LOAD_FREQ;
>        active_tasks = count_active_tasks();
> 
>        CALC_LOAD(avenrunT, EXP_5, active_tasks);
>        CALC_LOAD(avenrun[0], EXP_5, numof_root_tasks);
>        CALC_LOAD(avenrun[1], EXP_5, numof_uid500_tasks);
>        CALC_LOAD(avenrun[2], EXP_5, numof_uid501_tasks);
>        CALC_LOAD(avenrun[3], EXP_5, numof_uid502_tasks);
>        CALC_LOAD(avenrun[4], EXP_5, numof_uid503_tasks);
>        CALC_LOAD(avenrun[5], EXP_5, numof_uid504_tasks);
>    }
> }
> 
> Thanks
> Sena Seneviratene
> Computer Engineering Lab
> Sydney University
> 
> 
> 
> 
> 
> 
> 
> 
