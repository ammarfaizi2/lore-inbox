Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUAHCqP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 21:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUAHCqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 21:46:15 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:429 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S263595AbUAHCpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 21:45:50 -0500
Message-Id: <5.1.1.5.2.20040107143645.0396fbb8@brain.sedal.usyd.edu.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Wed, 07 Jan 2004 14:42:53 +1100
To: Robin Holt <holt@sgi.com>
From: auntvini <auntvini@sedal.usyd.edu.au>
Subject: Re: uid-task_struct Code after Proper Naming and indentation
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040107171240.GA31870@lnx-holt>
References: <3FFAF8AC.5040307@sedal.usyd.edu.au>
 <3FFAF8AC.5040307@sedal.usyd.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

Thanks for that and I will run the module and let you know the results.

It would be  pretty much the same as we are reading uids again from the 
task_struct.

This is what I have been doing as well.

In fact Robin this is what my problem is.

I thought that in ps uid are correctly shown even if they are started by 
telnet.

Thanks
Sena Seneviratene
Computer engineering Lab
Sydney University


At 11:12 AM 1/7/2004 -0600, you wrote:
>On Wed, Jan 07, 2004 at 05:04:28AM +1100, sena wrote:
>
>I haven't looked at your code to see what it is trying to
>do.
>
>I have, however made a simple module that will print out
>the pid, uid, and euid for all processes.  On my system,
>it clearly shows processes with non-zero pids and they
>match exactly with what ps is showing.
>
>Can you compile and run this to see if you have different
>results?
>
>As for the telnetd process, that _SHOULD_ have a uid
>of 0.  That process is started as root.  It then forks,
>sets uid and euid to the user it is starting, and then
>execs the users shell.  The process remains around for
>reaping children and then cleaning up the session when
>the user logs off.  If you are expecting telnet to have
>anything other than uid of 0, you need to look at what
>it is designed to do.
>
>Thanks,
>Robin
>
>#include <linux/sched.h>
>#include <linux/module.h>
>
>
>static int
>count_active_tasks(void)
>{
>         struct task_struct *p;
>
>         read_lock(&tasklist_lock);
>
>         for_each_task(p) {
>                 printk(KERN_EMERG "Pid %d uid %d euid %d\n",
>                        p->pid, p->uid, p->euid);
>         }
>         read_unlock(&tasklist_lock);
>         return -1;
>}
>
>module_init(count_active_tasks);
>
> > Hi Robin,
> >
> > ps way of reading uid is good.
> >
> > Though they are in 2 differant modes (kernel and user)
> >
> > Will that be a problem?
> >
> > Herewith I am sending to you the code after proper indentation.
> >
> > In timer.c file I have included and then updated all the neccessary
> > functions else where accordingly.
> >
> > unsigned long numof_root_tasks;    //for root uid<500, I am getting this
> > uidArray[0] is for storing uid (assumed 100 for all <500)
> > unsigned long numof_uid500_tasks;    //for 500
> > unsigned long numof_uid501_tasks;    //for 501
> > unsigned long numof_uid502_tasks;    //for 502
> > unsigned long numof_uid503_tasks;    //for 503
> > unsigned long numof_uid504_tasks;    // for 504
> >
> > unsigned int uidArray[7];
> >
> > static unsigned long
> > count_active_tasks(void)
> > {
> >    struct task_struct *p;
> >    unsigned long nr = 0;
> >
> >    int s = 0;
> >    int i = 0;
> >    int j = 0;
> >    int k = 0;
> >    int m = 0;
> >
> >
> >    read_lock(&tasklist_lock);
> >
> >    for_each_task(p) {
> >        if ((p->state == TASK_RUNNING ||
> >             (p->state & TASK_UNINTERRUPTIBLE))) {
> >
> >            nr += FIXED_1;    //nr total tasks
> >            if (i == 0) {
> >                uidArray[0] = 100;
> >
> >                if (p->uid < 500) {
> >                    numof_root_tasks += FIXED_1;
> >                } else {
> >                    uidArray[1] = p->uid;
> >                    numof_uid500_tasks += FIXED_1;
> >                    k++;
> >                }
> >                k++;
> >            } else {
> >                for (j = 0; j < k; j++) {
> >                    if ((j == 0) && (p->uid < 500)
> >                        && (s == 0)) {
> >                        numof_root_tasks +=
> >                            FIXED_1;
> >                        s = 1;
> >                        break;
> >                    } else if ((uidArray[j] == p->uid)
> >                           && s == 0) {
> >                        if (j == 1) {
> >                            numof_uid500_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 2) {
> >                            numof_uid501_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 3) {
> >                            numof_uid502_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 4) {
> >                            numof_uid503_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 5) {
> >                            numof_uid504_tasks
> >                                += FIXED_1;
> >                        }
> >                        s = 1;
> >                        break;
> >                    }
> >                }
> >                if (s == 0) {
> >
> >                    if (k < 6) {
> >                        k++;
> >                        j = k - 1;
> >                        uidArray[j] = p->uid;
> >                        if (j == 1) {
> >                            numof_uid500_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 2) {
> >                            numof_uid501_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 3) {
> >                            numof_uid502_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 4) {
> >                            numof_uid503_tasks
> >                                += FIXED_1;
> >                        }
> >                        if (j == 5) {
> >                            numof_uid504_tasks
> >                                += FIXED_1;
> >                        }
> >                    }
> >
> >                }
> >
> >                s = 0;
> >            }
> >            i++;
> >        }
> >
> >    }
> >    read_unlock(&tasklist_lock);
> >    return nr;
> >
> > }
> >
> > unsigned long avenrun[6];
> >
> > unsigned long avenrunT;
> >
> > static inline void
> > calc_load(unsigned long ticks)
> > {
> >    unsigned long active_tasks;    /*fixed-point */
> >    static int count = LOAD_FREQ;
> >
> >    count -= ticks;
> >    if (count < 0) {
> >        count += LOAD_FREQ;
> >        active_tasks = count_active_tasks();
> >
> >        CALC_LOAD(avenrunT, EXP_5, active_tasks);
> >        CALC_LOAD(avenrun[0], EXP_5, numof_root_tasks);
> >        CALC_LOAD(avenrun[1], EXP_5, numof_uid500_tasks);
> >        CALC_LOAD(avenrun[2], EXP_5, numof_uid501_tasks);
> >        CALC_LOAD(avenrun[3], EXP_5, numof_uid502_tasks);
> >        CALC_LOAD(avenrun[4], EXP_5, numof_uid503_tasks);
> >        CALC_LOAD(avenrun[5], EXP_5, numof_uid504_tasks);
> >    }
> > }
> >
> > Thanks
> > Sena Seneviratene
> > Computer Engineering Lab
> > Sydney University
> >
> >
> >
> >
> >
> >
> >
> >
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

