Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTAWOte>; Thu, 23 Jan 2003 09:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265306AbTAWOte>; Thu, 23 Jan 2003 09:49:34 -0500
Received: from robur.slu.se ([130.238.98.12]:57362 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S265285AbTAWOtd>;
	Thu, 23 Jan 2003 09:49:33 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15920.796.897388.111085@robur.slu.se>
Date: Thu, 23 Jan 2003 15:58:36 +0100
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Robert.Olsson@data.slu.se
Subject: ksoftirqd_CPU0 spinning in 2.4.21-pre3
In-Reply-To: <3E2EF490.20402@candelatech.com>
References: <3E2EF490.20402@candelatech.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ben Greear writes:
 > I happened to notice that my ksoftirqd_CPU0 process started spinning
 > at 99% CPU when I plugged in the ports to a tulip NIC.  I didn't see
 > any significant amount of interrupts when I looked at /proc/interrupts,
 > and there was no traffic running.
 > 
 > However, this is also running a hacked up tulip-napi driver, so it
 > could very well be my problem.  I have not seen this on any other kernel
 > in several months though...
 > 
 > Anyway, if anyone has seen this, I'd like to know.  Otherwise, I'll blame
 > my code and start poking at things...

 Well it can be normal operation if box is highly loaded...

 At high loads network interrupts are disabled not to trash performance or 
 DoS the kernel. Which in turn does succesive polls via RX-softirq to devices 
 at rate the it can process. So no interrupts when resources are scarce.
 
 The lack of interrupts makes ksoftirqd run the RX-softirq so the network load
 becomes visable here. Also review the discussion about ksoftirqd priority.

 Cheers.
							--ro
 
