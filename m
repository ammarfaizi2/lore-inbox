Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278702AbRKALWk>; Thu, 1 Nov 2001 06:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKALWa>; Thu, 1 Nov 2001 06:22:30 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:32756 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S278702AbRKALWX>; Thu, 1 Nov 2001 06:22:23 -0500
Message-ID: <3BE13035.30AC3E3D@mvista.com>
Date: Thu, 01 Nov 2001 03:21:25 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.30.0111010144570.31417-100000@gans.physik3.uni-rostock.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
~snip
> @@ -683,6 +683,34 @@
>         if (TQ_ACTIVE(tq_timer))
>                 mark_bh(TQUEUE_BH);
>  }
> +
> +
> +#if BITS_PER_LONG < 48
> +
> +u64 get_jiffies64(void)
> +{
> +       static unsigned long jiffies_hi = 0;
> +       static unsigned long jiffies_last = INITIAL_JIFFIES;
> +       unsigned long jiffies_tmp;
> +
> +       jiffies_tmp = jiffies;   /* avoid races */
> +       if (jiffies_tmp < jiffies_last)   /* We have a wrap */
> +               jiffies_hi++;
> +       jiffies_last = jiffies_tmp;
> +
> +       return (jiffies_tmp | ((u64)jiffies_hi) << BITS_PER_LONG);

Doesn't this need to be protected on SMP machines?  What if two cpus
call get_jiffies64() at the same time...  Seems like jiffies_hi could
get bumped twice instead of once.

George
