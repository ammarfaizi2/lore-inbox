Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262575AbVCVJAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbVCVJAG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVCVJAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:00:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:51104 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262575AbVCVI7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:59:44 -0500
Date: Tue, 22 Mar 2005 09:59:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
Message-ID: <20050322085931.GB18896@elte.hu>
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322054345.GB1296@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


regarding this code:

void synchronize_kernel(void)
{
        long oldbatch;

        smp_mb();
        oldbatch = rcu_ctrlblk.batch;
        schedule_timeout(HZ/GRACE_PERIODS_PER_SEC);

what is the intent of that schedule_timeout() - a fixed-period delay? Is
that acceptable? In any case, it wont do what you think it does, you
should use mdelay(), or do current->state = TASK_UNINTERRUPTIBLE -
otherwise the call will just return when we are in TASK_RUNNING.

	Ingo
