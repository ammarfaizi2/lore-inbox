Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945953AbWJZWB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945953AbWJZWB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945956AbWJZWB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:01:58 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6638 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1945953AbWJZWB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:01:58 -0400
Subject: Re: 2.6.19-rc2 and very unstable NTP
From: john stultz <johnstul@us.ibm.com>
To: linux@horizon.com
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061026123051.3831.qmail@science.horizon.com>
References: <20061026123051.3831.qmail@science.horizon.com>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 14:59:46 -0700
Message-Id: <1161899986.960.59.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-26 at 08:30 -0400, linux@horizon.com wrote:
> First of all, nobody get too excited, yet.  I'm seeing an odd divergence
> between the offset recorded in ntp's peerstats file (the log of the
> measured time differences between each clock source) and the offset in
> the loopstats file (the consensus value it uses to control the local
> clock oscillator) that I need to investigate first.

Ok, let us know if you find anything there.

> If you're deeply suspiscious of a simple device driver, with publicly
> available code, that adds timestamping to the handling of DCD changed
> events from the serial ports, and exports those timestamps to user space,
> I can remove it.  The Acutime 2000 can timestamp pulses sent to it
> (via the RTS line), so I can get sub-microsecond time measurements anyway.

One of the recent changes was removing the in-kernel PPS code. This was
done because there were no in-kernel users of the interface (the only
ones being I believe in a variant of this LinuxPPS patch). While from
the diffstat below it doesn't look like the patch affects the
timekeeping code, it would be good to first reproduce the issue without
the patch.


> Having PPS as well was just a nice redundancy feature.
> 
> But here's the diffstat, with newly created files marked with a leading "+".
>  drivers/Kconfig              |    2 +
>  drivers/Makefile             |    1 +
> +drivers/pps/Kconfig          |   43 ++++
> +drivers/pps/Makefile         |    7 +
> +drivers/pps/clients/Kconfig  |   23 ++
> +drivers/pps/clients/Makefile |    6 +
> +drivers/pps/clients/ktimer.c |  107 +++++++++
> +drivers/pps/kapi.c           |  172 ++++++++++++++
> +drivers/pps/pps.c            |  385 +++++++++++++++++++++++++++++++
> +drivers/pps/procfs.c         |  180 +++++++++++++++
>  drivers/serial/8250.c        |   85 +++++++-
>  include/linux/netlink.h      |    2 +-
> +include/linux/pps.h          |   93 ++++++++
> +include/linux/timepps.h      |  515 ++++++++++++++++++++++++++++++++++++++++++
>  14 files changed, 1617 insertions(+), 4 deletions(-)
> 
> I *really* doubt it has any effect on the kernel timekeeping code.


Could you also send me a copy of your full dmesg? 

thanks
-john

