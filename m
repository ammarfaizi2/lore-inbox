Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbTJJUFT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 16:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTJJUFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 16:05:19 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:29827 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262436AbTJJUFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 16:05:11 -0400
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031010195800.GK25856@redhat.com>
References: <1065784536.2071.3.camel@paragon.slim>
	 <20031010184241.GC32600@redhat.com> <1065813288.1861.4.camel@paragon.slim>
	 <20031010193434.GJ25856@redhat.com> <1065815651.1904.4.camel@paragon.slim>
	 <20031010195800.GK25856@redhat.com>
Content-Type: text/plain
Message-Id: <1065816203.1904.6.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 10 Oct 2003 22:03:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-10 at 21:58, Dave Jones wrote:
> On Fri, Oct 10, 2003 at 09:54:11PM +0200, Jurgen Kramer wrote:
>  > >  > 995
>  > > wtf, it still displays "Highestspeed=798MHz" on startup though right ?
>  > Yep,
> 
> another stupid bug.
> calc_speed should look like this..
> 
> static unsigned int calc_speed (int mult, int fsb)
> {
>     int mhz;
>     mhz = (mult/10)*fsb;
>     if (mult%10)
>         mhz += fsb/2;
>     return mhz;
> }
> 

Fixed that one:

[root@paradox cpufreq]# more *
::::::::::::::
cpuinfo_max_freq
::::::::::::::
798
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
798
::::::::::::::
scaling_min_freq
::::::::::::::
399
::::::::::::::
scaling_setspeed
::::::::::::::
798


