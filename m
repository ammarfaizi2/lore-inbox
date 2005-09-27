Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964874AbVI0JOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbVI0JOf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 05:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964875AbVI0JOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 05:14:35 -0400
Received: from gate.corvil.net ([213.94.219.177]:12292 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S964874AbVI0JOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 05:14:34 -0400
Message-ID: <43390D65.6050706@draigBrady.com>
Date: Tue, 27 Sep 2005 10:14:13 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Kaloudoff <kalou@kalou.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: watchdog with P4SCI and 2.6.9 (Supermicro)
References: <Pine.LNX.4.62.0509261920340.15689@s1.ckr-solutions.com>
In-Reply-To: <Pine.LNX.4.62.0509261920340.15689@s1.ckr-solutions.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Kaloudoff wrote:
> Hi !
> 
> 
>     I'm happy to say that watchdog for P4SCi is detected
> fine with my 2.6.9-freevps-1.5-1 kernel (centos 4.1 patched with freevps 
> 1.5-1)

Note detected is too strong a word.
Watchdog driver generally can't detect that
the appropriate watchdog hardware is present.

> 
> [root@shinwey ~]# uname -a
> Linux shinwey 2.6.9-freevps-1.5-1 #1 SMP Sun Sep 25 23:07:51 CEST 2005 
> i686 i686 i386 GNU/Linux
> 
> 
> Sep 26 10:55:18 shinwey kernel: WDT500/501-P driver 0.10 at 0x0240 
> (Interrupt 11). heartbeat=60 sec (nowayout=0)
> 
> Sep 26 10:55:18 shinwey kernel: wdt: Fan Tachometer is Disabled
> Sep 26 10:55:18 shinwey kernel: w83877f_wdt: cannot register miscdev on 
> minor=130 (err=-16)
> 
> Sep 26 10:55:18 shinwey kernel: WDT driver for the Winbond(TM) W83627HF 
> Super I/O chip initialising.
> 
> Sep 26 10:55:18 shinwey kernel: w83627hf WDT: cannot register miscdev on 
> minor=130 (err=-16)
> 
> 
> Unfortunatelly, I set up a 4 minutes delay in the bios, the server takes 
> less than 2 minutes to boot and detect the watchdog chip, but reboot takes
> place ...

I notice you are loading multiple watchdog drivers
which will probably clash with each other.
You need to identify the watchdog on the motherboard
and only load the appropriate module. Google suggests
the driver could be i8xx-tco or w83627hf?

I wrote the w83627hf driver and did a recent change
to fix immediate reboot on module loading on certain systems.
The cause was when the BIOS starts the watchdog with
a timeout of X minutes, the hardware is in "minute mode".
However when the watchdog loads in changes it to "seconds mode",
causing a reboot within 4 seconds in your case.

The good news is if the machine is rebooting within 4 seconds
of loading the w83627hf module then you know that it is
the appropriate module to load, and a fix is available.

Other watchdog drivers may have the same issue.

Pádraig.

