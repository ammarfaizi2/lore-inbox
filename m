Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTACSE7>; Fri, 3 Jan 2003 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbTACSE7>; Fri, 3 Jan 2003 13:04:59 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:31666 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267613AbTACSE5>; Fri, 3 Jan 2003 13:04:57 -0500
Date: Fri, 03 Jan 2003 10:05:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Avery Fay <avery_fay@symantec.com>, linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
Message-ID: <14000000.1041617118@flay>
In-Reply-To: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
References: <OFC4D9AF0E.DA93F4D7-ON85256CA3.0058C567-85256CA3.00592873@symantec.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
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
> 
> 1.) with smp I would get ~2.9 gb/s but the combined cpu utilization would 
> be that of one cpu at 90%.
> 2.) or with smp I would get more than ~2.9 gb/s.
> 
> Has anyone been able to utilize more than one cpu with pure forwarding?
> 
> Note: I realize that I am not using a stock kernel. I was in the past, but 
> I ran into the same problem (smp not improving performance), just at lower 
> speeds (redhat's kernel was faster). Therefore, this problem is neither 
> introduced nor solved by redhat's kernel. If anyone has suggestions for 
> improvements, I can move back to a stock kernel.
> 
> Note #2: I've tried tweaking a lot of different things including binding 
> irq's to specific cpus, playing around with e1000 modules settings, etc.
> 
> Thanks in advance and please CC me with any suggestions as I'm not 
> subscribed to the list.

Dual what Xeon? I presume a P4 thing. Can you cat /proc/interrupts? 
Are you using the irq_balance code? If so, I think you'll only use 
1 cpu to process all the interrupts from each gigabit card. Not that 
you have much choice, since Intel broke the P4's interrupt routing.

Which of the e1000 modules settings did you play with? tx_delay
and rx_delay? What rev of the e1000 chipset?

M.

