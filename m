Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUAGGHg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUAGGHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:07:36 -0500
Received: from brain.sedal.usyd.edu.au ([129.78.24.68]:53479 "EHLO
	brain.sedal.usyd.edu.au") by vger.kernel.org with ESMTP
	id S264898AbUAGGHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:07:25 -0500
Message-ID: <3FFAF8AC.5040307@sedal.usyd.edu.au>
Date: Wed, 07 Jan 2004 05:04:28 +1100
From: sena <auntvini@sedal.usyd.edu.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: holt@sgi.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: uid-task_struct Code after Proper Naming and indentation
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

ps way of reading uid is good.

 Though they are in 2 differant modes (kernel and user)

 Will that be a problem?

Herewith I am sending to you the code after proper indentation.

In timer.c file I have included and then updated all the neccessary 
functions else where accordingly.

unsigned long numof_root_tasks;    //for root uid<500, I am getting this 
uidArray[0] is for storing uid (assumed 100 for all <500)
unsigned long numof_uid500_tasks;    //for 500
unsigned long numof_uid501_tasks;    //for 501
unsigned long numof_uid502_tasks;    //for 502
unsigned long numof_uid503_tasks;    //for 503
unsigned long numof_uid504_tasks;    // for 504

unsigned int uidArray[7];

static unsigned long
count_active_tasks(void)
{
    struct task_struct *p;
    unsigned long nr = 0;

    int s = 0;
    int i = 0;
    int j = 0;
    int k = 0;
    int m = 0;


    read_lock(&tasklist_lock);

    for_each_task(p) {
        if ((p->state == TASK_RUNNING ||
             (p->state & TASK_UNINTERRUPTIBLE))) {

            nr += FIXED_1;    //nr total tasks
            if (i == 0) {
                uidArray[0] = 100;

                if (p->uid < 500) {
                    numof_root_tasks += FIXED_1;
                } else {
                    uidArray[1] = p->uid;
                    numof_uid500_tasks += FIXED_1;
                    k++;
                }
                k++;
            } else {
                for (j = 0; j < k; j++) {
                    if ((j == 0) && (p->uid < 500)
                        && (s == 0)) {
                        numof_root_tasks +=
                            FIXED_1;
                        s = 1;
                        break;
                    } else if ((uidArray[j] == p->uid)
                           && s == 0) {
                        if (j == 1) {
                            numof_uid500_tasks
                                += FIXED_1;
                        }
                        if (j == 2) {
                            numof_uid501_tasks
                                += FIXED_1;
                        }
                        if (j == 3) {
                            numof_uid502_tasks
                                += FIXED_1;
                        }
                        if (j == 4) {
                            numof_uid503_tasks
                                += FIXED_1;
                        }
                        if (j == 5) {
                            numof_uid504_tasks
                                += FIXED_1;
                        }
                        s = 1;
                        break;
                    }
                }
                if (s == 0) {

                    if (k < 6) {
                        k++;
                        j = k - 1;
                        uidArray[j] = p->uid;
                        if (j == 1) {
                            numof_uid500_tasks
                                += FIXED_1;
                        }
                        if (j == 2) {
                            numof_uid501_tasks
                                += FIXED_1;
                        }
                        if (j == 3) {
                            numof_uid502_tasks
                                += FIXED_1;
                        }
                        if (j == 4) {
                            numof_uid503_tasks
                                += FIXED_1;
                        }
                        if (j == 5) {
                            numof_uid504_tasks
                                += FIXED_1;
                        }
                    }

                }

                s = 0;
            }
            i++;
        }

    }
    read_unlock(&tasklist_lock);
    return nr;

}

unsigned long avenrun[6];

unsigned long avenrunT;

static inline void
calc_load(unsigned long ticks)
{
    unsigned long active_tasks;    /*fixed-point */
    static int count = LOAD_FREQ;

    count -= ticks;
    if (count < 0) {
        count += LOAD_FREQ;
        active_tasks = count_active_tasks();

        CALC_LOAD(avenrunT, EXP_5, active_tasks);
        CALC_LOAD(avenrun[0], EXP_5, numof_root_tasks);
        CALC_LOAD(avenrun[1], EXP_5, numof_uid500_tasks);
        CALC_LOAD(avenrun[2], EXP_5, numof_uid501_tasks);
        CALC_LOAD(avenrun[3], EXP_5, numof_uid502_tasks);
        CALC_LOAD(avenrun[4], EXP_5, numof_uid503_tasks);
        CALC_LOAD(avenrun[5], EXP_5, numof_uid504_tasks);
    }
}

Thanks
Sena Seneviratene
Computer Engineering Lab
Sydney University









