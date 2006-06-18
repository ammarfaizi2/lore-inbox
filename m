Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWFRHou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWFRHou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 03:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWFRHot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 03:44:49 -0400
Received: from 1wt.eu ([62.212.114.60]:51720 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932127AbWFRHos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 03:44:48 -0400
Date: Sun, 18 Jun 2006 09:42:48 +0200
From: Willy Tarreau <w@1wt.eu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
Message-ID: <20060618074247.GF13255@w.ods.org>
References: <200606181732.48952.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606181732.48952.kernel@kolivas.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

On Sun, Jun 18, 2006 at 05:32:48PM +1000, Con Kolivas wrote:
> Make 250 HZ a value that is not selected by default and give some better
> recommendations in help.
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
> 
>  kernel/Kconfig.hz |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> Index: linux-ck-dev/kernel/Kconfig.hz
> ===================================================================
> --- linux-ck-dev.orig/kernel/Kconfig.hz	2006-06-18 15:23:58.000000000 +1000
> +++ linux-ck-dev/kernel/Kconfig.hz	2006-06-18 15:24:28.000000000 +1000
> @@ -21,14 +21,17 @@ choice
>  	help
>  	  100 HZ is a typical choice for servers, SMP and NUMA systems
>  	  with lots of processors that may show reduced performance if
> -	  too many timer interrupts are occurring.
> +	  too many timer interrupts are occurring. Laptops may also show
> +	  improved battery life.
>  
> -	config HZ_250
> +	config HZ_250_NODEFAULT
>  		bool "250 HZ"
>  	help
> -	 250 HZ is a good compromise choice allowing server performance
> -	 while also showing good interactive responsiveness even
> -	 on SMP and NUMA systems.
> +	 250 HZ is a lousy compromise choice allowing server interactivity
> +	 while also showing desktop throughput and no extra power saving on
> +	 laptops. Good for when you can't make up your mind.
> +
> +	 Recommend 100 or 1000 instead.

In fact, I use this value (250 Hz) on servers because it provides slightly
finer scheduling precision than 100 Hz without the performance impact of
1000 Hz. It also has the advantage that conversions between ms<->jiffies
are performed by bit shifts only and no divide nor multiply. I really do
not notice any performance hit between 100 and 250 Hz, while I do between
250 and 1000.

Cheers,
Willy

