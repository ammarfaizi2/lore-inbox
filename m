Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTADD3s>; Fri, 3 Jan 2003 22:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTADD3s>; Fri, 3 Jan 2003 22:29:48 -0500
Received: from dp.samba.org ([66.70.73.150]:17090 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265894AbTADD3r>;
	Fri, 3 Jan 2003 22:29:47 -0500
Date: Sat, 4 Jan 2003 14:33:45 +1100
From: Anton Blanchard <anton@samba.org>
To: Avery Fay <avery_fay@symantec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
Message-ID: <20030104033345.GC19888@krispykreme>
References: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I'm working with a dual xeon platform with 4 dual e1000 cards on different 
> pci-x buses. I'm having trouble getting better performance with the second 
> cpu enabled (ht disabled). With a UP kernel (redhat's 2.4.18), I can route 
> about 2.9 gigabits/s at around 90% cpu utilization. With a SMP kernel 
> (redhat's 2.4.18), I can route about 2.8 gigabits/s with both cpus at 
> around 90% utilization. This suggests to me that the network code is 
> serialized. I would expect one of two things from my understanding of the 
> 2.4.x networking improvements (softirqs allowing execution on more than 
> one cpu):

The Fujitsu guys have a nice summary of this:

http://www.labs.fujitsu.com/en/techinfo/linux/lse-0211/index.html

Skip forward to page 8.

Dont blame the networking code just yet :) Notice how worse UP vs SMP
performance is on the P4 compared to the P3?

This brings up another point, is a single CPU with hyperthreading worth
it? As Rusty will tell you, you need to compare it with a UP kernel
since it avoids all the locking overhead. I suspect for a lot of cases
HT will be a loss (imagine your case, comparing UP and one CPU HT)

Anton
