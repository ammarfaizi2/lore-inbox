Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVKWCER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVKWCER (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 21:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965197AbVKWCER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 21:04:17 -0500
Received: from [210.76.114.22] ([210.76.114.22]:56224 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S964807AbVKWCEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 21:04:16 -0500
Message-ID: <4383CE48.60007@ccoss.com.cn>
Date: Wed, 23 Nov 2005 10:04:56 +0800
From: liyu <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] I doublt on spin_lock again.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All.

    I come here again.

    I have two questions on spin_lock. these are:

    1. I found these use spin_lock(&rq->lock) in set_user_nice(), but 
not disable interrput ( e.g.  when sys_nice() call it ),  if the one 
timer interrput come before we unlock the spin_lock, Shall
we dead lock here?  Since the scheduler_tick() may try to hold the same 
lock.

    2. I also found some function name in its definition have some 
postfix, I show here two classical examples:

static void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
    __acquires(rq1->lock)
    __acquires(rq2->lock)
{ ... }

static void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
    __releases(rq1->lock)
    __releases(rq2->lock)
{ ... }

    In the related header files, they are defined as two preprocess 
macroes, are follow:

# define __acquires(x)    __attribute__((context(0,1)))
# define __releases(x)    __attribute__((context(1,0)))
# define __acquire(x)    __context__(1)
# define __release(x)    __context__(-1)


    I guess they are some extensions of gcc for C language, but I did 
not  found any information in GCC manual.

    Would you like reply these questions? Thank advanced.

-liyu









