Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTACUTG>; Fri, 3 Jan 2003 15:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267646AbTACUTG>; Fri, 3 Jan 2003 15:19:06 -0500
Received: from navgwout.symantec.com ([198.6.49.12]:5289 "EHLO
	navgwout.symantec.com") by vger.kernel.org with ESMTP
	id <S267641AbTACUS6>; Fri, 3 Jan 2003 15:18:58 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gigabit/SMP performance problem
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 5.0.9a  January 7, 2002
Message-ID: <OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>
From: "Avery Fay" <avery_fay@symantec.com>
Date: Fri, 3 Jan 2003 15:25:53 -0500
X-MIMETrack: Serialize by Router on USCU-SMTPOB01-1/GLOBE-ADMIN/SYMANTEC(Release 5.0.11
  |July 24, 2002) at 01/03/2003 12:35:45 PM,
	Serialize complete at 01/03/2003 12:35:45 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dual Pentium 4 Xeon at 2.4 Ghz. I believe I am using irq load balancing as 
shown below (seems to be applied to Red Hat's kernel). Here's 
/proc/interrupts:

           CPU0       CPU1 
  0:     179670     182501    IO-APIC-edge  timer
  1:        386        388    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:          9          9    IO-APIC-edge  PS/2 Mouse
 14:       1698       1511    IO-APIC-edge  ide0
 24:    1300174    1298071   IO-APIC-level  eth2
 25:    1935085    1935625   IO-APIC-level  eth3
 28:    1162013    1162734   IO-APIC-level  eth4
 29:    1971246    1967758   IO-APIC-level  eth5
 48:    2753990    2753821   IO-APIC-level  eth0
 49:    2047386    2043894   IO-APIC-level  eth1
 72:     838987     841143   IO-APIC-level  eth6
 73:    2767885    2768307   IO-APIC-level  eth7
NMI:          0          0 
LOC:     362009     362008 
ERR:          0
MIS:          0

I started traffic at different times on the various interfaces so the 
number of interrupts per interface aren't uniform.

I modified RxIntDelay, TxIntDelay, RxAbsIntDelay, TxAbsIntDelay, 
FlowControl, RxDescriptors, TxDescriptors. Increasing the various 
IntDelays seemed to improve performance slightly.

I'm using 3 Intel PRO/1000 MT Dual Port Server adapters as well as 2 
onboard Intel PRO/1000 ports. The adapters use the 82546EB chips. I 
believe that the onboard ports use the same although I'm not sure.

Should I get rid of IRQ load balancing? And what do you mean "Intel broke the P4's interrupt routing"?

Thanks,
Avery Fay





"Martin J. Bligh" <mbligh@aracnet.com>
01/03/2003 01:05 PM

 
        To:     Avery Fay <avery_fay@symantec.com>, linux-kernel@vger.kernel.org
        cc: 
        Subject:        Re: Gigabit/SMP performance problem


> I'm working with a dual xeon platform with 4 dual e1000 cards on 
different 
> pci-x buses. I'm having trouble getting better performance with the 
second 
> cpu enabled (ht disabled). With a UP kernel (redhat's 2.4.18), I can 
route 
> about 2.9 gigabits/s at around 90% cpu utilization. With a SMP kernel 
> (redhat's 2.4.18), I can route about 2.8 gigabits/s with both cpus at 
> around 90% utilization. This suggests to me that the network code is 
> serialized. I would expect one of two things from my understanding of 
the 
> 2.4.x networking improvements (softirqs allowing execution on more than 
> one cpu):
> 
> 1.) with smp I would get ~2.9 gb/s but the combined cpu utilization 
would 
> be that of one cpu at 90%.
> 2.) or with smp I would get more than ~2.9 gb/s.
> 
> Has anyone been able to utilize more than one cpu with pure forwarding?
> 
> Note: I realize that I am not using a stock kernel. I was in the past, 
but 
> I ran into the same problem (smp not improving performance), just at 
lower 
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




