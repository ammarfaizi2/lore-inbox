Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264688AbUEOXcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbUEOXcR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 19:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEOXcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 19:32:17 -0400
Received: from rs1.physik.Uni-Dortmund.DE ([129.217.168.30]:12514 "EHLO
	rs1.physik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264688AbUEOXcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 19:32:14 -0400
Date: Sun, 16 May 2004 01:30:39 +0200
From: Robert Fendt <fendt@physik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
Message-Id: <20040516013039.52cad4ca.fendt@physik.uni-dortmund.de>
In-Reply-To: <1084584998.12352.306.camel@dhcppc4>
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
	<1084584998.12352.306.camel@dhcppc4>
Organization: Lehrstuhl =?ISO-8859-1?B?Zvxy?= experimentelle Physik I,
 =?ISO-8859-1?B?VW5pdmVyc2l05HQ=?= Dortmund
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is possible that the system is getting into a high power saving
> mode on idle.  Device bus master activity or interrupts will wake
> it up -- but the latency to return from power savings mode may be
> so high that the device experiences receive buffer overruns.

Yes, I also thought in that direction, since the main difference between
the processor module loaded or not seems to be the idle handler.

> Some devices handle this latency better than others,
> and with a network, dropping RX packets can cause the
> connection to thrash, and it seems that is what you see.
> 
> If the 8139too has statistics counters showing if it gets
> RX buffer over-runs, that would be interseting to observe.

I seem to be unable to reproduce the problem on my home network. It is a
small (switched) 100BaseT network which is connected to the outside via an
asynchronous dsl line (128/768kbit). Maybe the different LAN topology or
the slow external link make the difference. I will retry on monday on the
corporate network. The latter is a large university net, with our section
consisting of 100BaseT-to-100BaseFX tranceiver switches. I do not have
information on the rest of the network.

> Also, to see what idle power saving states you have, their
> latency and their usage, please do this:
> cat /proc/acpi/processor/CPU0/power

betazed:~# cat /proc/acpi/processor/CPU1/power
active state:            C2
default state:           C1
bus master activity:     ffffffff
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00000010]
   *C2:                  promotion[C3] demotion[C1] latency[001] usage[00025200]
    C3:                  promotion[--] demotion[C2] latency[101] usage[00024564]

> It would also be interesting to know if you see the problem
> more frequently when running on battery power, since some
> systems have higher c-state exit latency when on battery.

I cannot say at this moment, since I cannot reproduce the problem at home
(see above). I will try to get some info on this matter on monday. Stay
tuned.

> It would also be interesting to know if you see the same
> frequency of the problem on 2.4, since it has 100HZ clock
> vs 1000HZ clock on 2.6 -- and this can have a significant
> effect on the effectivness of idle c-states.

Will try to install a 2.4 kernel on the box and see what happens.

Regards,
Robert
