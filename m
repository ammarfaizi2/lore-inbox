Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130577AbRCTRnO>; Tue, 20 Mar 2001 12:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRCTRnF>; Tue, 20 Mar 2001 12:43:05 -0500
Received: from cpe.atm0-0-0-180310.boanxx4.customer.tele.dk ([62.243.2.100]:6819
	"HELO marvin.athome.dk") by vger.kernel.org with SMTP
	id <S130577AbRCTRmr>; Tue, 20 Mar 2001 12:42:47 -0500
Message-ID: <3AB79669.3060405@fugmann.dhs.org>
Date: Tue, 20 Mar 2001 18:42:01 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8.1) Gecko/20010314
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BH implementation question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi I have a couple of questions to the kernel code.

I have been trying to fully inderstand (and doccument) the changes in 
2.4 wrt. Tasklets and softirq's, BH's and task queues.

In my try to understand how it all works, I came across the code:

(linux/kernel/softirq.c: 246)

static void bh_action(unsigned long nr)
{
	int cpu = smp_processor_id();

	if (!spin_trylock(&global_bh_lock))
		goto resched;

	if (!hardirq_trylock(cpu))
		goto resched_unlock;

	if (bh_base[nr])
		bh_base[nr]();

	hardirq_endlock(cpu);
	spin_unlock(&global_bh_lock);
	return;

resched_unlock:
	spin_unlock(&global_bh_lock);
resched:
	mark_bh(nr);
}

Now all of this but the hardirq_trylock(cpu) and hardirq_endlock(cpu) 
makes perfectly sence.

Anyone care to explain the what theese lines do.

Secondly.

Is there a reason why to implement a queue (TASKLET_HI) for the old 
BH's, instead of just using a single tasklet for all BH administraton. 
Would'ent this guarentee that no BH is executed at the same time, and at 
the same time reduce code complexity, and remove the global_bh_lock?


TIA
Anders Fugmann



-- 
Hi. I'm a .signature virus.
Please copy me into your .signature file and help me spread.

