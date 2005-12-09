Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVLIXtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVLIXtL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 18:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbVLIXtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 18:49:11 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:25484 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S964903AbVLIXtK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 18:49:10 -0500
Subject: 2.6.14-rt22
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Cc: nando@ccrma.Stanford.EDU
Content-Type: text/plain
Date: Fri, 09 Dec 2005 15:48:25 -0800
Message-Id: <1134172105.12624.27.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, I'm running 2.6.14-rt22 and just noticed something strange. I
have not installed it in all machines yet, but in some of them (same
hardware as others that seems to work fine) the TSC was selected as the
main clock for the kernel. Remember this is one of the Athlon X2
machines in which the TCS's drift...

dmesg shows this:
  PM-Timer running at invalid rate: 2172% of normal - aborting.

and after that the tsc is selected as the timing source.
  Time: tsc clocksource has been installed.

The strange thing is that this is the same hardware as on other
machines. I have to install this kernel on more machines, will report
then...

This is what's available after the boot:
# cat /sys/devices/system/clocksource/clocksource0/available_clocksource
jiffies tsc pit

So I selected by hand:
# cat /sys/devices/system/clocksource/clocksource0/current_clocksource
pit

On the machine that's not selecting tsc the options are:
# cat /sys/devices/system/clocksource/clocksource0/available_clocksource
acpi_pm jiffies tsc pi
(and acpi_pm is selected, of course).

I think TSC's should never be selected on this hardware and it is known
not to work. 

-- Fernando


