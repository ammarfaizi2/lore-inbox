Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271302AbSISP56>; Thu, 19 Sep 2002 11:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271374AbSISP56>; Thu, 19 Sep 2002 11:57:58 -0400
Received: from ns2.nealtech.net ([64.29.20.117]:17304 "EHLO nealtech.net")
	by vger.kernel.org with ESMTP id <S271302AbSISP55>;
	Thu, 19 Sep 2002 11:57:57 -0400
Message-Id: <200209191602.MAA30225@nealtech.net>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: linux-kernel@vger.kernel.org
Subject: Re: garbage returned from do_gettimeofday
Date: Thu, 19 Sep 2002 11:53:19 -0400
X-Mailer: KMail [version 1.3.1]
References: <200209182310.TAA18081@nealtech.net>
In-Reply-To: <200209182310.TAA18081@nealtech.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 September 2002 07:00 pm, anton wilson wrote:
> I'm using do_gettimeofday in the scheduler, once per schedule.
> Ocassioanlly, i'll get what seems to be a random garbage number.
> For example:
>
> tv_sec     tv_usec
> 1032378775 627501
> 1032378775 627521
> 3433001412 1
> 1032378775 627573
> 1032378775 627617
> 1032378775 627638
>
> or
>
> 1032379233 253008
> 1032379233 253028
> 3387638236 1
> 1032379233 253068
> 1032379233 253125
>
>
> The garbage number tv_sec always seems to begin with a 3 and is followed by
> 9 digits. The tv_usec garbage number is always 1.
>

Even more stangely, I'll get a sequence of the same garbage time from 
do_gettimeofday, interleaved with good values:

tv_sec     tv_usec  jiffies 

1032450154 41056 -- 108690]
1032450154 42045 -- 108690]
1032450154 42056 -- 108690]
1032450154 43045 -- 108690]
1032450154 43056 -- 108690]

/*garbage starts here*/
3390722356 1 -- 108690]
1032450154 43090 -- 108690]
3390722356 1 -- 108690]
1032450154 43177 -- 108690]
3390722356 1 -- 108690]
1032450154 43204 -- 108690]
3390722356 1 -- 108690]
1032450154 43257 -- 108690]
3390722356 1 -- 108690]
1032450154 43287 -- 108690]
3390722356 1 -- 108690]
/*garbage values stop for now*/
1032450154 44064 -- 108690]


1032450154 44084 -- 108690]
1032450154 44212 -- 108690]
1032450154 45047 -- 108690]
1032450154 45059 -- 108690]
1032450154 46045 -- 108690]


I'm using 2.4.19 with rc2, low-latency, premptive, O(1), and kdb patches.

Anton
