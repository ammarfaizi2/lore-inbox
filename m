Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVLJBVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVLJBVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 20:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLJBVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 20:21:40 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:48353 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932489AbVLJBVj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 20:21:39 -0500
Subject: Re: 2.6.14-rt22 (acpi_pm vs tsc vs BIOS)
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel@vger.kernel.org
Cc: cc@ccrma.Stanford.EDU, nando@ccrma.Stanford.EDU,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <1134172105.12624.27.camel@cmn3.stanford.edu>
References: <1134172105.12624.27.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 17:21:11 -0800
Message-Id: <1134177671.4811.4.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 15:48 -0800, Fernando Lopez-Lezcano wrote:
> Hi all, I'm running 2.6.14-rt22 and just noticed something strange. I
> have not installed it in all machines yet, but in some of them (same
> hardware as others that seems to work fine) the TSC was selected as the
> main clock for the kernel. Remember this is one of the Athlon X2
> machines in which the TCS's drift...
> 
> dmesg shows this:
>   PM-Timer running at invalid rate: 2172% of normal - aborting.
> 
> and after that the tsc is selected as the timing source.
>   Time: tsc clocksource has been installed.
> 
> The strange thing is that this is the same hardware as on other
> machines. 

Aha! Yes but no. The BIOS makes a difference. The first BIOS that has
support for the X2 processors on this particular motherboard works fine
with regards to the acpi_pm clock source, subsequent ones make linux say
things like:
  PM-Timer running at invalid rate: 2159% of normal - aborting.
and then tsc is selected as the clock source...

> I have to install this kernel on more machines, will report
> then...
> 
> This is what's available after the boot:
> # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> jiffies tsc pit
> 
> So I selected by hand:
> # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> pit
> 
> On the machine that's not selecting tsc the options are:
> # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> acpi_pm jiffies tsc pi
> (and acpi_pm is selected, of course).
> 
> I think TSC's should never be selected on this hardware and it is known
> not to work. 

-- Fernando


