Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVLJC3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVLJC3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbVLJC3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:29:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:41109 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932505AbVLJC3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:29:43 -0500
Subject: Re: 2.6.14-rt22
From: john stultz <johnstul@us.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1134172105.12624.27.camel@cmn3.stanford.edu>
References: <1134172105.12624.27.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 18:29:30 -0800
Message-Id: <1134181771.4002.4.camel@leatherman>
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

Hm. That's odd. Either your PM-Timer isn't running at the right
frequency, or something is going wrong in the calibration. I'm
suspecting its the second. If you add a "return 0;" to the top of
verify_pmtmr_rate() in drivers/clocksource/acpi_pm.c does the acpi_pm
timer keep proper time?

thanks
-john


