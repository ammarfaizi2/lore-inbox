Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292150AbSCDITJ>; Mon, 4 Mar 2002 03:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292223AbSCDITA>; Mon, 4 Mar 2002 03:19:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57867 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292150AbSCDISq>;
	Mon, 4 Mar 2002 03:18:46 -0500
Message-ID: <3C832D66.6DC279E@zip.com.au>
Date: Mon, 04 Mar 2002 00:16:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Gigabit Performance 2.4.19-preX - Excessive locks, calls, waits
In-Reply-To: <20020304001223.A29448@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> ...
>  34880 total                                      0.0202
>  28581 default_idle                             595.4375
>   1125 __rdtsc_delay                             35.1562
>   1094 eth_type_trans                             5.2596
>    657 skb_release_data                           4.5625
>    378 __make_request                             0.2596
>    335 alloc_skb_frame                            1.1020

Note how eth_type_trans is now the most expensive function.  This
is because it's the first place where the CPU touches the
just-arrived ethernet header.

It would be interesting to add a prefetch() to the driver at the
earliest possible time to get the header read underway.  Maybe
the IP header too?

-
