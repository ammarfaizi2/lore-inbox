Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293626AbSCPAtW>; Fri, 15 Mar 2002 19:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293630AbSCPAtD>; Fri, 15 Mar 2002 19:49:03 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:27893 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293626AbSCPAs7>;
	Fri, 15 Mar 2002 19:48:59 -0500
Date: Fri, 15 Mar 2002 16:48:45 -0800
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [QUESTION] Micro-Second timers in kernel ?
Message-ID: <20020315164845.A15889@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I'm wondering what is the lowest resolution of timers that can
be get in Linux across all platforms. The goal : I need to do
microsecond resolution delay in the hard_xmit function of the IrDA-USB
driver, and don't want to just grab the CPU.

	The function sys_nanosleep() seems to indicate that under 2ms,
we should not even bother using a timer. Well, on a modern CPU, 2ms is
a very long time (on the other hand, it seems OK for PDAs).
	The definition of "tick" in timer.c indicate that the timer_bh
is called at a maximum of HZ time per second (which is consistent with
the definition of jiffies). On i386, this would be one tick every
10ms.
	Well... I'm stuck. 10ms is a very long time at 4Mb/s. So, I
guess I'll continue to busy wait before sending each packet. Ugh !

	Regards,

	Jean
