Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbTJDUVW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbTJDUVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:21:22 -0400
Received: from msdo0001.xtend.de ([217.27.0.68]:43436 "EHLO msdo0001.xtend.de")
	by vger.kernel.org with ESMTP id S262754AbTJDUVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:21:18 -0400
Message-ID: <3F7F2BAB.9020407@triaton-webhosting.com>
Date: Sat, 04 Oct 2003 22:20:59 +0200
From: Georg Chini <georg.chini@triaton-webhosting.com>
User-Agent: Mozilla/5.0 (X11; U; Linux sparc64; en-US; rv:1.4a) Gecko/20030510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Sparc32 - sched_clock missing
References: <3F7ED071.7080005@triaton-webhosting.com> <20031004115455.42d8263e.akpm@osdl.org>
In-Reply-To: <20031004115455.42d8263e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, I can compile and boot the kernel now.
But still the keyboard does not work...

Regards
        Georg Chini

Andrew Morton wrote:
> Georg Chini <georg.chini@triaton-webhosting.com> wrote:
> 
>>Hello out there,
>>
>>tried to build Kernel 2.6.0-test6-bk4 on my
>>sparc32 machine and found that the function
>>sched_clock is missing in time.c. Can anyone
>>tell me what I have to put there? Please CC
>>to me.
>>
> 
> 
> This is the minimal version to get you going.
> 
> A better implementation would use a higer-resolution counter, if the
> hardware has such a thing.
> 
> 
> diff -puN arch/sparc/kernel/time.c~sparc32-sched_clock arch/sparc/kernel/time.c
> --- 25/arch/sparc/kernel/time.c~sparc32-sched_clock	2003-10-04 11:53:19.000000000 -0700
> +++ 25-akpm/arch/sparc/kernel/time.c	2003-10-04 11:53:41.000000000 -0700
> @@ -617,3 +617,12 @@ static int set_rtc_mmss(unsigned long no
>  		return -1;
>  	}
>  }
> +
> +/*
> + * Returns nanoseconds
> +  */
> +
> +unsigned long long sched_clock(void)
> +{
> +	return (unsigned long long)jiffies * (1000000000 / HZ);
> +}
> 
> _


