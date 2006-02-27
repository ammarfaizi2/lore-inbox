Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751836AbWB0VY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbWB0VY7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbWB0VY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:24:59 -0500
Received: from hoster904.com ([66.211.137.19]:6101 "EHLO hoster904.com")
	by vger.kernel.org with ESMTP id S1751836AbWB0VY6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:24:58 -0500
From: bubshait <darkray@ic3man.com>
To: linux-kernel@vger.kernel.org
Subject: AMD64 X2 lost ticks on PM timer
Date: Tue, 28 Feb 2006 00:22:40 +0300
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280022.40769.darkray@ic3man.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been suffering from lost ticks for several months now ever since I 
switched to an X86_64 kernel with SMP. I have read previous posts about lost 
ticks due to TSC timer, but I have been having a different problem as I have 
only been using 2.6.14 and then 2.6.15 kernels and only PM timers. Also, this 
problem does not manifest itself immedietly, I could be using the system for 
anywhere from a few hours to a couple of days without any problems before I 
start losing ticks, but once it starts it would lose them constantly and my 
desktop becomes unstable (some apps crash, while other take 5 minutes to 
start up, this was what led me to discover the lost ticks) forcing me to 
reboot. The following error appears in dmesg at the time the system starts to 
act strange

	Losing some ticks... checking if CPU frequency changed.
	warning: many lost ticks.
	Your time source seems to be instable or some driver is hogging interupts
	rip __do_softirq+0x47/0xd1

adding report_lost_ticks only prints repeating messages like

	Lost 3 timer tick(s)! rip __do_softirq+0x47/0xd1

I have tried using acipmaintimer and acippmtimer, it would boot fine but I 
would notice the following in dmesg

	..MP-BIOS bug: 8254 timer not connected to IO-APIC
	timer doesn't work through the IO-APIC - disabling NMI Watchdog!
	Uhhuh. NMI received for unknown reason 3d.

And would still end up with lost ticks eventually. using acpi=off causes the 
entire system to come to a crawl (I am guessing this is due to the PM timer). 
For the life of me I can't seem to figure out what causes these lost ticks to 
start, but when they do the /proc/interrupts show a drop from roughly 1000 
interrupts/sec to around 700 and this persists until I reboot.

My hardware is an AMD64 X2 4800+ on an asus A8N-SLI.

Also, could I please be CC'ed to any replies. I don't mean to be rude by not 
subscribing but I couldn't handle the volume.

Thanks,
Abdulla Bubshait
