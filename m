Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVCOXNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVCOXNP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 18:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVCOXM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 18:12:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44977 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262126AbVCOXKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:10:48 -0500
Date: Tue, 15 Mar 2005 23:59:01 +0100
From: Pavel Machek <pavel@suse.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max Asbock <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday arch specific hooks  (v. A3)
Message-ID: <20050315225901.GB21143@elf.ucw.cz>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com> <1110590710.30498.329.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110590710.30498.329.camel@cog.beaverton.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> diff -Nru a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
> --- a/arch/i386/kernel/apm.c	2005-03-11 17:02:30 -08:00
> +++ b/arch/i386/kernel/apm.c	2005-03-11 17:02:30 -08:00
> @@ -224,6 +224,7 @@
>  #include <linux/smp_lock.h>
>  #include <linux/dmi.h>
>  #include <linux/suspend.h>
> +#include <linux/timeofday.h>
>  
>  #include <asm/system.h>
>  #include <asm/uaccess.h>
> @@ -1204,6 +1205,7 @@
>  	device_suspend(PMSG_SUSPEND);
>  	device_power_down(PMSG_SUSPEND);
>  
> +	timeofday_suspend_hook();
>  	/* serialize with the timer interrupt */
>  	write_seqlock_irq(&xtime_lock);
>  

Could you just register timeofday subsystem as a system device? Then
device_power_down will call you automagically..... And you'll not have
to modify apm, acpi, swsusp, ppc suspend, arm suspend, ...

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
