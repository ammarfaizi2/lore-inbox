Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbVK1RX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbVK1RX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 12:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVK1RXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 12:23:25 -0500
Received: from fsmlabs.com ([168.103.115.128]:62896 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750719AbVK1RXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 12:23:25 -0500
X-ASG-Debug-ID: 1133198602-19073-1-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 28 Nov 2005 09:29:04 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Raj, Ashok" <ashok.raj@intel.com>,
       Stephen Hemminger <shemminger@osdl.org>
X-ASG-Orig-Subj: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
Subject: Re: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
In-Reply-To: <m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0511280928060.1595@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
 <20051127135833.GH20775@brahms.suse.de> <m1wtiufa9z.fsf@ebiederm.dsl.xmission.com>
 <Pine.LNX.4.61.0511270836120.20046@montezuma.fsmlabs.com>
 <m1psolfqvt.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5654
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2005, Eric W. Biederman wrote:

> diff --git a/arch/x86_64/kernel/reboot.c b/arch/x86_64/kernel/reboot.c
> index 75235ed..57117b8 100644
> --- a/arch/x86_64/kernel/reboot.c
> +++ b/arch/x86_64/kernel/reboot.c
> @@ -6,6 +6,7 @@
>  #include <linux/kernel.h>
>  #include <linux/ctype.h>
>  #include <linux/string.h>
> +#include <linux/pm.h>
>  #include <asm/io.h>
>  #include <asm/kdebug.h>
>  #include <asm/delay.h>
> @@ -154,10 +155,11 @@ void machine_halt(void)
>  
>  void machine_power_off(void)
>  {
> -	if (!reboot_force) {
> -		machine_shutdown();
> -	}
> -	if (pm_power_off)
> +	if (pm_power_off) {
> +		if (!reboot_force) {
> +			machine_shutdown();
> +		}
>  		pm_power_off();
> +	}
>  }

That makes sense, thanks Eric.

	Zwane

