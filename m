Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267527AbUIPHOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267527AbUIPHOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 03:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUIPHOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 03:14:23 -0400
Received: from rrzd2.rz.uni-regensburg.de ([132.199.1.12]:40900 "EHLO
	rrzd2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S267545AbUIPHJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 03:09:23 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: john stultz <johnstul@us.ibm.com>
Date: Thu, 16 Sep 2004 09:02:03 +0200
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
CC: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Message-ID: <4149568C.32693.473C38@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <1095274131.29408.2990.camel@cog.beaverton.ibm.com>
References: <Pine.LNX.4.58.0409151025090.3219@schroedinger.engr.sgi.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+93426@20040916.065318Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Sep 2004 at 11:48, john stultz wrote:

> NTP adjustments need to be applied smoothly and consistently as time
> progresses. Adjustment to the NTP parameters occur at do_adjtimex and at

Actually I think (constant) NTP adjustments need to be applied any time. That's 
why I even tried to correct the TSC interpolation between ticks (If you visit the 
PPSkit patch, that's the "nanoscale" thing). The "constant adjustment values" are 
updated regularly also (per tick, per second, per NTP update).

The basic thought was: If the time between two ticks is not 1/HZ the TSC 
interpolation (that is calibrated against the timer ticks) also will not 
interpolate between 1/HZ ticks. I assumed the TSC interpolations is wrong by the 
same percentage the timer interrupts are. Thus I tried to reversely apply the 
frequency error learnt through NTP even to the TSC interpolation (in addition to 
the time increments every tick). My code however has the problem that I ran out of 
significant bits during several muliplies and divides, while supporting that 
maximum imaginable frequency range for TSC. Even with the best oscillator, it 
won't reach single nanosecond precision as I don't have enough bits for them.

Regards,
Ulrich


