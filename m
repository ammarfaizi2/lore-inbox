Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUCDUWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbUCDUWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:22:36 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:37258 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262122AbUCDUWe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:22:34 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Peter Zaitsev <peter@mysql.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de, riel@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <132310000.1078421713@flay>
References: <20040228072926.GR8834@dualathlon.random>
	 <Pine.LNX.4.44.0402280950500.1747-1 00000@chimarrao.boston.redhat.com>
	 <20040229014357.GW8834@dualathlon.random>
	 < 1078370073.3403.759.camel@abyss.local>
	 <20040303193343.52226603.akpm@osdl.org >
	 <1078371876.3403.810.camel@abyss.local>
	 <20040303200704.17d81bda.akpm@osdl.org>  <132310000.1078421713@flay>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1078431695.2770.498.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 04 Mar 2004 12:21:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-04 at 09:35, Martin J. Bligh wrote:

> 
> 2. If it's gettimeofday hammering it (which it probably is, from previous
> comments by others, and my own experience), then vsyscall gettimeofday
> (John's patch) may well fix it up.

Well, as I wrote MySQL does not use a lot of gettimeofday.   It rather
has 2-3 calls to time() per query, but it is very small number compared
to othet syscalls.

> 
> 3. Are you using the extra user address space? Otherwise yes, it'll be 
> all downside. And 4/4 vs 3/1 isn't really a fair comparison ... 4/4 is
> designed for bigboxen, so 4/4 vs 2/2 would be better, IMHO. People have
> said before that DB performance can increase linearly with shared area
> sizes (for some workloads), so that'd bring you a 100% or so increase
> in performance for 4/4 to counter the loss.

I do not really understand this :)

I know 4/4 was designed for BigBoxes, however we're more interested in
side effect we have - having 4G per user process instead of 3G in 3G/1G
split. As MySQL is designed as single process this is what rather
important for us. 

I was not using extra address space in this test, as the idea was to see
how much slowdown 4G/4G split gives you with all other being the same. 

Based on other benchmarks I know extra performance extra 1Gb  used as
buffers can give. 

Bringing this numbers together I shall conclude what 4G/4G does not make
sense for most MySQL loads, as  1Gb used for internal buffers (vs 1Gb
used for file cache) will not give high enough performance to cover such
major speed loss. 

There are exceptions of course, for example the case where your full
workload will fit in 3G cache while will not fit in 2G (very edge one),
or in case you need 4G just to manage  10000+ connections with
reasonable buffers etc, which is also far from most typical scenario.

For "Big Boxes" I just would not advice having 32bit configuration at
all - happily nowadays you can get 64bit pretty cheap.





-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

