Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316372AbSE3BnW>; Wed, 29 May 2002 21:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316239AbSE3Ble>; Wed, 29 May 2002 21:41:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61678 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316163AbSE3Bkm>;
	Wed, 29 May 2002 21:40:42 -0400
Subject: Re: [RFC] [PATCH] Disable TSCs on CONFIG_MULTIQUAD
From: john stultz <johnstul@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022722675.4124.337.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 May 2002 18:36:40 -0700
Message-Id: <1022722601.2019.95.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not all the other places are "there is no TSC" most of them deal with
> the ability to use a TSC. There are other setups where TSC exists but
> isnt usable so distinguishing matters

Martin's clarification aside, I'll agree that distinguishing between no
TSC and unsynced TSCs is reasonable. There might be kernel code paths
that cannot migrate between cpus, use the TSC for timing, and do not
save the value in global structures. So in that case, reading the non
synced TSC would be safe and disabling TSCs totally w/ multiquad might
be a touch rash. I just haven't actually looked to see if such cases
exist. Are there other reasons unsynced TSCs might still be useful?

> Also there is one case where TSC that doesn't work matters specifically
> - you want to turn off RDTSC access from user space to avoid user space
> tools having little accidents

I was hoping that would fall into place when the X86_FEATURE_TSC bit of
boot_cpu_data.x86_capability (aka: cpu_has_tsc) was disabled. I'll
double check however, just to be sure. 

Thanks again.
-john
 


