Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUEMMNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUEMMNr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264165AbUEMMNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:13:47 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:58296 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S264154AbUEMMNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:13:41 -0400
Date: Thu, 13 May 2004 14:06:44 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: linux-kernel@vger.kernel.org, moqua@kurtenba.ch
Subject: Re: cpufreq and p4 prescott
Message-ID: <20040513120644.GB7940@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	linux-kernel@vger.kernel.org, moqua@kurtenba.ch
References: <20040512171433.GA10481@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512171433.GA10481@dominikbrodowski.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>[ck@holodeck:cpufreq] cat /proc/cpuinfo | grep Mhz
>>>cpu MHz         : 2807.131
>>>cpu MHz         : 2807.131
>> 
>> The cpu MHz entry in /proc/cpuinfo is the same for all CPUs, and no
>> reliable
>> source to detect the current cpu frequency anyway.  Use
>
> i thought this because on my ibook i can see different MHz
> entry's when cpudyn changes the frequence.

Well, on UP kernels cpu_khz can be and is changed by the cpufreq subsystem
-- on SMP kernels, it's impossible as cpu_khz is _one_ value and different
SMP CPUs may be put to different speeds [not really valid for
HyperThreading, but for real SMP, yes...]

> The reason why i want to throttle down my prescott is the heat.
> Strange is that when the frequence is changed to 350MHz
> (after 30min running with 2.8GHz), neither the CPU&System temperature

No surprise on that. I guess you weren't using 100% of the CPU? The CPU
is put into an idle state when it is unused anyways, and that idle state
consumes quite exactly as much power as when the CPU is throttled. So, as
long as the CPU isn't used 100%, you won't see a difference in power
consumption == heat generation between p4-clockmod throttling and idling.
p4-clockmod _only_ helps if the CPU needs to be limited to provide less than
100% processing power _or_ if the idling algorithm doesn't work.

> nor tools that calculate the CPU speed (like gkrellm-x86info)
> show a difference to 2.8GHz.

No surprise on that, too. x86info uses the TSC (time stamp counter) to 
determine the CPU frequency, and on P4s the TSC runs at a constant rate
even if the frequency is throttled. Always remember the difference between
scaling and throttling:

x is a CPU clock tick, * is a tick where nothing happens, but the TSC runs
as normal:

normal operations: x x x x x x x x x x x x x x x x x x x x x x x x 

throttling:        x x x x * * * * x x x x * * * * x x x x * * * *

scaling:           x   x   x   x   x   x   x   x   x   x   x   x  

> All voltages on my system are the same with 350MHz/2.8GHz, too.

'cause throttling doesn't lead to voltage scaling. You need a _voltage
sclaing capable_ CPU and chipset and system environment (motherboard, BIOS,
...) for that.

> So i'm not sure if throttling does work until now?

It does, AFAICS.

	Dominik
