Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbVIJBN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVIJBN4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 21:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVIJBN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 21:13:56 -0400
Received: from yue.linux-ipv6.org ([203.178.140.15]:30220 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S932665AbVIJBNz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 21:13:55 -0400
Date: Sat, 10 Sep 2005 10:15:27 +0900 (JST)
Message-Id: <20050910.101527.70689095.yoshfuji@linux-ipv6.org>
To: johnstul@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ioe-lkml@rameria.de, george@mvista.com,
       ulrich.windl@rz.uni-regensburg.de, zippel@linux-m68k.org,
       yoshfuji@linux-ipv6.org
Subject: Re: [RFC][PATCH] NTP shiftR cleanup
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1126314217.3455.10.camel@cog.beaverton.ibm.com>
References: <1126314217.3455.10.camel@cog.beaverton.ibm.com>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1126314217.3455.10.camel@cog.beaverton.ibm.com> (at Fri, 09 Sep 2005 18:03:37 -0700), john stultz <johnstul@us.ibm.com> says:

> diff --git a/kernel/time.c b/kernel/time.c
> --- a/kernel/time.c
> +++ b/kernel/time.c
> @@ -338,30 +338,20 @@ int do_adjtimex(struct timex *txc)
>  		        if (mtemp >= MINSEC) {
>  			    ltemp = (time_offset / mtemp) << (SHIFT_USEC -
>  							      SHIFT_UPDATE);
> -			    if (ltemp < 0)
> -			        time_freq -= -ltemp >> SHIFT_KH;
> -			    else
> -			        time_freq += ltemp >> SHIFT_KH;
> +			    time_freq = shiftR(ltemp, SHIFT_KH);
>  			} else /* calibration interval too short (p. 12) */
>  				result = TIME_ERROR;

Maybe, "time_freq += shiftR(ltemp, SHIFT_KH);"?

--yoshfuji
