Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTJUF6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 01:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbTJUF6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 01:58:22 -0400
Received: from diesel.grid4.com ([208.49.116.17]:18304 "EHLO diesel.grid4.com")
	by vger.kernel.org with ESMTP id S262941AbTJUF6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 01:58:20 -0400
Date: Tue, 21 Oct 2003 01:59:23 -0400
From: Paul <set@pobox.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ Routing. [A 2.6 question about smp irq balancing]
Message-ID: <20031021055923.GI13549@squish.home.loc>
Mail-Followup-To: Paul <set@pobox.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
References: <3F9396C7.50807@superbug.demon.co.uk> <763050000.1066659824@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <763050000.1066659824@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com>, on Mon Oct 20, 2003 [07:23:44 AM] said:
> > Are their any linux tools to allow the user to view irq routing details, 
> > and maybe change the routing after boot ?
> > 
> > This might be useful in special cases.
> 
> Yeah, "cat /proc/interrupts" and 
> "echo <cpu_bitmask> > /proc/irq/<number>/smp_affinity"
> 
> M.

	Hi;

	Here is my /proc/interrupts for 2.6.0-test6:

           CPU0       CPU1       
  0:      10442 1795758405    IO-APIC-edge  timer
  1:     737209          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade
  3:        517          1    IO-APIC-edge  serial
  4:  100488033          1    IO-APIC-edge  serial
  5:          0          0    IO-APIC-edge  eth0
  8:          2          0    IO-APIC-edge  rtc
 12:    1626560          1    IO-APIC-edge  i8042
 14:    8988748          8    IO-APIC-edge  ide0
 15:     377275          1    IO-APIC-edge  ide1
 16:    1364704          2   IO-APIC-level  eth1
 17:     857789     144630   IO-APIC-level  eth2
 19:     165579          1   IO-APIC-level  Ensoniq AudioPCI
NMI: 1795768424 1795763795 
LOC: 1795877980 1795878044 
ERR:          0
MIS:        351

	Now, on 2.4 kernels, both columns are about even.
Upon noticing this, I tried to get more interrupts on cpu1.
You can see I got some on eth2, by running many 'ping -f's at the
same time. I havent been able to get anything more out of ide[01]
for cpu1, even though Ive run many -j4 compiles of huge packages,
which coincided with other things that bring my load up to 8+ over
the course of 20 days of uptime. /proc/irq/<num>/smp_affinity
is 3 (ie. both cpus) for all <num>. I was able to induce interrupts
on cpu1 for ide0 by setting it to 2.
	Ok, my question is, is this how it is supposed to be?
I ask because I am seeing a throughput decrease on 2.6 v 2.4
on hdparm -t, bonnie, kernel compile benchmarks, though interactivity
seems to be better.

Paul
set@pobox.com
