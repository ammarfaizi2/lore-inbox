Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314192AbSDQWpZ>; Wed, 17 Apr 2002 18:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314193AbSDQWpZ>; Wed, 17 Apr 2002 18:45:25 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:65520 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S314192AbSDQWpY>; Wed, 17 Apr 2002 18:45:24 -0400
Message-Id: <5.1.0.14.2.20020418082824.03112008@localhost>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 18 Apr 2002 08:44:45 +1000
To: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: IDE/raid performance
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020417125838.GA27648@dark.x.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:58 PM 17/04/2002 +0200, Baldur Norddahl wrote:
>It is clear that the 33 MHz PCI bus maxes out at 75 MB/s. Is there a reason
>it doesn't reach 132 MB/s?

welcome to the world of PC hardware, real-world performance and theoretical 
numbers.

in theory, a 32/33 PCI bus can get 132mbyte/sec.

in reality, the more cards you have on a bus, the more arbitration you 
have, the less overall efficiency.

in theory, with neither the initiator or target inserting wait-states, and 
with continual bursting, you can achieve maximum throughput.
in reality, continual bursting doesn't happen very often and/or many 
hardware devices are not designed to either perform i/o without some 
wait-states in some conditions or provide continual bursting.

in short: you're working on theoretical numbers.  reality is typically far 
far different!


something you may want to try:
   if your motherboard supports it, change the "PCI Burst" settings and see 
what effect this has.
   you can probably extract another 20-25% performance by changing the PCI 
Burst from 32 to 64.

>Second, why are the md devices so slow? I would have expected it to reach
>130+ MB/s on both md0 and md1. It even has spare CPU time to do it with.

you don't mention actually what your motherboard or chipset actually is -- 
and where the 32/33 and 64/66 PCI connect in.
you also don't mention what your FSB & memory clock-speed are, or how these 
are connected to the PCI busses.


it is likely that you have a motherboard where the throughput between PCI 
to memory will also contend with the FSB.
given you're using "time dd if=/dev/hdo1 of=/dev/null bs=1M count=1" as 
your test, you're effectively issuing read() and write() system-calls from 
user-space to kernel.
this implies a memory-copy.
count the number of times you're doing a memory-copy (or, more correctly, 
moving data across the front-side-bus), and you should be able to see 
another reason for the bottlenecks you see.


cheers,

lincoln.

