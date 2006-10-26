Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423448AbWJZMax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423448AbWJZMax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 08:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423457AbWJZMax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 08:30:53 -0400
Received: from science.horizon.com ([192.35.100.1]:23869 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1423448AbWJZMaw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 08:30:52 -0400
Date: 26 Oct 2006 08:30:51 -0400
Message-ID: <20061026123051.3831.qmail@science.horizon.com>
From: linux@horizon.com
To: linux@horizon.com, zippel@linux-m68k.org
Subject: Re: 2.6.19-rc2 and very unstable NTP
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610261218350.6761@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, nobody get too excited, yet.  I'm seeing an odd divergence
between the offset recorded in ntp's peerstats file (the log of the
measured time differences between each clock source) and the offset in
the loopstats file (the consensus value it uses to control the local
clock oscillator) that I need to investigate first.

> Did you ask the author? It would really help to have more specific 
> information here, e.g. what kernel interfaces are actually used in this 
> configuration.

Er... I thought I *was* asking the authors of the Linux kernel/time*
code.

If you're deeply suspiscious of a simple device driver, with publicly
available code, that adds timestamping to the handling of DCD changed
events from the serial ports, and exports those timestamps to user space,
I can remove it.  The Acutime 2000 can timestamp pulses sent to it
(via the RTS line), so I can get sub-microsecond time measurements anyway.

Having PPS as well was just a nice redundancy feature.

But here's the diffstat, with newly created files marked with a leading "+".
 drivers/Kconfig              |    2 +
 drivers/Makefile             |    1 +
+drivers/pps/Kconfig          |   43 ++++
+drivers/pps/Makefile         |    7 +
+drivers/pps/clients/Kconfig  |   23 ++
+drivers/pps/clients/Makefile |    6 +
+drivers/pps/clients/ktimer.c |  107 +++++++++
+drivers/pps/kapi.c           |  172 ++++++++++++++
+drivers/pps/pps.c            |  385 +++++++++++++++++++++++++++++++
+drivers/pps/procfs.c         |  180 +++++++++++++++
 drivers/serial/8250.c        |   85 +++++++-
 include/linux/netlink.h      |    2 +-
+include/linux/pps.h          |   93 ++++++++
+include/linux/timepps.h      |  515 ++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 1617 insertions(+), 4 deletions(-)

I *really* doubt it has any effect on the kernel timekeeping code.
