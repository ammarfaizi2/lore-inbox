Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263091AbTJJTQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbTJJTQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:16:40 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:25987 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263091AbTJJTQi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:16:38 -0400
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031010184241.GC32600@redhat.com>
References: <1065784536.2071.3.camel@paragon.slim>
	 <20031010184241.GC32600@redhat.com>
Content-Type: text/plain
Message-Id: <1065813288.1861.4.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 10 Oct 2003 21:14:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more details. Although this is an 800MHz CPU
/sys/devices/system/cpu/cpu0/cpufreq gives:

[root@paradox cpufreq]# more *
::::::::::::::
cpuinfo_max_freq
::::::::::::::
995
::::::::::::::
cpuinfo_min_freq
::::::::::::::
399
::::::::::::::
scaling_available_governors
::::::::::::::
userspace
::::::::::::::
scaling_driver
::::::::::::::
longhaul
::::::::::::::
scaling_governor
::::::::::::::
userspace
::::::::::::::
scaling_max_freq
::::::::::::::
995
::::::::::::::
scaling_min_freq
::::::::::::::
399
::::::::::::::
scaling_setspeed
::::::::::::::
798

I can overclock my machine to 995MHz..;-) Setting scaling_setspeed
doesn't seem to do anything.

Cheers,

Jurgen

On Fri, 2003-10-10 at 20:42, Dave Jones wrote:
> On Fri, Oct 10, 2003 at 01:15:37PM +0200, Jurgen Kramer wrote:
> 
>  > It seems that longhaul support in 2.6.0-test7 is still not working
>  > properly...:-(. 
>  > 
>  > longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v2 supported.
>  > longhaul: Bogus values Min:0.000 Max:0.000. Voltage scaling disabled.
>  > longhaul: MinMult=5.0x MaxMult=6.0x
>  > longhaul: FSB: 0MHz Lowestspeed=0MHz Highestspeed=0MHz
> 
> Oh boy, this is a real egg-on-face bug if I'm right..
> edit arch/i386/kernel/cpu/cpufreq/longhaul.c and change line
> 394 to read longhaul_version = 1;
> I suspect things will suddenly start making a lot more sense.
> 
> 		Dave

