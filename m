Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318036AbSHCXbh>; Sat, 3 Aug 2002 19:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318038AbSHCXbh>; Sat, 3 Aug 2002 19:31:37 -0400
Received: from dsl-213-023-022-101.arcor-ip.net ([213.23.22.101]:32446 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318036AbSHCXbg>;
	Sat, 3 Aug 2002 19:31:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] Rmap speedup
Date: Sun, 4 Aug 2002 01:36:31 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17aiJv-0007cr-00@starship> <E17b3sE-0001T4-00@starship> <3D4C4DD9.779C057B@zip.com.au>
In-Reply-To: <3D4C4DD9.779C057B@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17b8Rk-0003iQ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 August 2002 23:40, Andrew Morton wrote:
> Running the same test on 2.4:
> 
> 2.4.19-pre7:
> 	./daniel.sh  35.12s user 65.96s system 363% cpu 27.814 total
> 	./daniel.sh  35.95s user 64.77s system 362% cpu 27.763 total
> 	./daniel.sh  34.99s user 66.46s system 364% cpu 27.861 total
> 
> 2.4.19-pre7+rmap:
> 	./daniel.sh  36.20s user 106.80s system 363% cpu 39.316 total
> 	./daniel.sh  38.76s user 118.69s system 399% cpu 39.405 total
> 	./daniel.sh  35.47s user 106.90s system 364% cpu 39.062 total
> 
> 2.4.19-pre7+rmap-13b+your patch:
> 	./daniel.sh  33.72s user 97.20s system 364% cpu 35.904 total
> 	./daniel.sh  35.18s user 94.48s system 363% cpu 35.690 total
> 	./daniel.sh  34.83s user 95.66s system 363% cpu 35.921 total
> 
> The system time is pretty gross, isn't it?
> 
> And it's disproportional to the increased number of lockings.

These numbers show a 30% reduction in rmap overhead with my patch,
close to what I originally reported:

  ((35.904 + 35.690 + 35.921) - (27.814 + 27.763 + 27.861)) / 
  ((39.316 + 39.405 + 39.062) - (27.814 + 27.763 + 27.861)) ~= .70

But they also show that rmap overhead is around 29% on your box,
even with my patch:

  (35.904 + 35.690 + 35.921) / (27.814 + 27.763 + 27.861) ~= 1.29

Granted, it's still way too high, and we are still in search of the
'dark cycles'.

Did we do an apples-to-apples comparison of 2.4 to 2.5?  Because if
we did, then going by your numbers, 2.5.26 is already considerably
worse than 2.4.19-pre7:

  ((30.260 + 29.642)/2) / ((27.814 + 27.763 + 27.861)/3) ~= 1.08

Is it fair to compare your 2.4 vs 2.5 numbers?

--
Daniel
