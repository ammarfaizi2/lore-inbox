Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313443AbSDPBHo>; Mon, 15 Apr 2002 21:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313444AbSDPBHn>; Mon, 15 Apr 2002 21:07:43 -0400
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:50824 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S313443AbSDPBHm>;
	Mon, 15 Apr 2002 21:07:42 -0400
Message-ID: <3CBB795E.7080902@candelatech.com>
Date: Mon, 15 Apr 2002 18:07:42 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: bk://linux.bkbits.net/linux-2.4 busted
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feeling lucky, I tried pulling down the bkbits linux-2.4
repository.  It does not compile as usual:

Changing num_smp_cpus to NR_CPUS, as shown below, fixes one
compile problem, but I'm not sure if it's the right fix or not.

 From file: kernel_stat.h:
/*
  * Number of interrupts per specific IRQ source, since bootup
  */
static inline int kstat_irqs (int irq)
{
	int i, sum=0;

	for (i = 0 ; i < NR_CPUS ; i++)
		sum += kstat.irqs[cpu_logical_map(i)][irq];

	return sum;
}
#endif


With this 'fix', it gets all the way to the end and then fails to link:
fs/fs.o: In function `dput':
fs/fs.o(.text+0x11f68): undefined reference to `atomic_dec_and_lock'
make: *** [vmlinux] Error 1


I'm beginning to think that no-one is actually using the repository.
If anyone has any suggestions for a better up-kept bk (or CVS) repository,
please let me know.


Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


