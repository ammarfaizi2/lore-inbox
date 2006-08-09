Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWHICqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWHICqP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 22:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWHICpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 22:45:24 -0400
Received: from cantor.suse.de ([195.135.220.2]:4785 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030428AbWHICpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 22:45:22 -0400
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [RFC][PATCH 1/6] x86_64: Enable arch-generic vsyscall support.
Date: Wed, 9 Aug 2006 04:29:49 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com> <20060809021714.23103.24280.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060809021714.23103.24280.sendpatchset@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608090429.49951.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/kernel/timer.c b/kernel/timer.c
> index b650f04..08b4a02 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -1023,6 +1023,12 @@ static int __init timekeeping_init_devic
>  
>  device_initcall(timekeeping_init_device);
>  
> +#ifdef CONFIG_GENERIC_TIME_VSYSCALL
> +extern void update_vsyscall(struct timespec* ts, struct clocksource* c);
> +#else
> +#define update_vsyscall(now, c)
> +#endif

Using a weak dummy function would be a bit cleaner.

-Andi

>
