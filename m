Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbUKTCYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbUKTCYi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbUKTCW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:22:28 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:53915 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262846AbUKTCS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:18:27 -0500
Message-ID: <419EA96E.9030206@yahoo.com.au>
Date: Sat, 20 Nov 2004 13:18:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Christoph Lameter <clameter@sgi.com>, torvalds@osdl.org, akpm@osdl.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Hugh Dickins <hugh@veritas.com>, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: page fault scalability patch V11 [0/7]: overview
References: <Pine.LNX.4.44.0411061527440.3567-100000@localhost.localdomain> <Pine.LNX.4.58.0411181126440.30385@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0411181715280.834@schroedinger.engr.sgi.com> <419D581F.2080302@yahoo.com.au> <Pine.LNX.4.58.0411181835540.1421@schroedinger.engr.sgi.com> <419D5E09.20805@yahoo.com.au> <Pine.LNX.4.58.0411181921001.1674@schroedinger.engr.sgi.com> <1100848068.25520.49.camel@gaston> <Pine.LNX.4.58.0411190704330.5145@schroedinger.engr.sgi.com> <20041120020401.GC2714@holomorphy.com>
In-Reply-To: <20041120020401.GC2714@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Fri, Nov 19, 2004 at 11:42:39AM -0800, Christoph Lameter wrote:
> 
>>A. make_rss_atomic. The earlier releases contained that patch but
>>then another variable (such as anon_rss) was introduced that would
>>   have required additional atomic operations. Atomic rss operations
>>   are also causing slowdowns on machines with a high number of cpus
>>   due to memory contention.
>>B. remove_rss. Replace rss with a periodic scan over the vm to
>>   determine rss and additional numbers. This was also discussed on
>>   linux-mm and linux-ia64. The scans while displaying /proc data
>>   were undesirable.
> 
> 
> Split counters easily resolve the issues with both these approaches
> (and apparently your co-workers are suggesting it too, and have
> performance results backing it).
> 

Split counters still require atomic operations though. This is what
Christoph's latest effort is directed at removing. And they'll still
bounce cachelines around. (I assume we've reached the conclusion
that per-cpu split counters per-mm won't fly?).
