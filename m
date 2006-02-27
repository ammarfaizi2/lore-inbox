Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWB0WV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWB0WV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWB0WV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:21:58 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:2440 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S964839AbWB0WV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:21:58 -0500
Date: Mon, 27 Feb 2006 17:21:52 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: bubshait <darkray@ic3man.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD64 X2 lost ticks on PM timer
Message-ID: <20060227222152.GA26541@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	bubshait <darkray@ic3man.com>, linux-kernel@vger.kernel.org
References: <200602280022.40769.darkray@ic3man.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602280022.40769.darkray@ic3man.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 12:22:40AM +0300, bubshait wrote:
> 	Losing some ticks... checking if CPU frequency changed.
> 	warning: many lost ticks.
> 	Your time source seems to be instable or some driver is hogging interupts
> 	rip __do_softirq+0x47/0xd1
> 
> adding report_lost_ticks only prints repeating messages like
> 
> 	Lost 3 timer tick(s)! rip __do_softirq+0x47/0xd1

I'm seeing tons of these on a Tyan 2895 (Nvidia CKO4) running FC4 with
kernel-2.6.15-1.1830 (2.6.15.2) SMP: 

time.c: Lost 1 timer tick(s)! rip default_idle+0x37/0x7a)
time.c: Lost 2 timer tick(s)! rip __do_softirq+0x55/0xd4)

[I've seen the same thing with earlier FC 2.6.14 kernels.]

On our systems the __do_softirq messages are strongly correlated with
sata_nv interrupts, especially during our nightly tripwire-like fs
checksum job.  Unfortunately, the log messages are not very informative.
I'm not sure what ever happened to the following patch,

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.64/2.5.64-mm3/broken-out/report-lost-ticks.patch

but it was dropped.

Unfortunately, I need to spend tomorrow patching kernels in search of a
fix or workaround, as I have to start using these boxes in production,
and they need to keep time.

Regards,

	Bill Rugolsky
