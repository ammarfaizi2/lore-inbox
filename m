Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUBWAQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 19:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbUBWAQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 19:16:40 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:24199 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261285AbUBWAQi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 19:16:38 -0500
Message-ID: <40394662.5060104@cyberone.com.au>
Date: Mon, 23 Feb 2004 11:16:34 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Chris Wedgwood <cw@f00f.org>, mfedyk@matchmail.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <20040222033111.GA14197@dingdong.cryptoapps.com>	<4038299E.9030907@cyberone.com.au>	<40382BAA.1000802@cyberone.com.au>	<4038307B.2090405@cyberone.com.au>	<40383300.5010203@matchmail.com>	<4038402A.4030708@cyberone.com.au>	<40384325.1010802@matchmail.com>	<403845CB.8040805@cyberone.com.au>	<20040221221721.42e734d6.akpm@osdl.org>	<40384D9D.6040604@cyberone.com.au>	<20040222083637.GA15589@dingdong.cryptoapps.com> <20040222011350.58f756e8.akpm@osdl.org>
In-Reply-To: <20040222011350.58f756e8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Chris Wedgwood <cw@f00f.org> wrote:
>
>>On Sun, Feb 22, 2004 at 05:35:09PM +1100, Nick Piggin wrote:
>>
>>
>>>Can you maybe use this patch then, please?
>>>
>>I probably need to do more testing, but the quick patch I was using
>>against mainline (bk head) works better than this against 2.5.3-mm2.
>>
>
>The patch which went in six months or so back which said "only reclaim slab
>if we're scanning lowmem pagecache" was wrong.  I must have been asleep at
>the time.
>
>We do need to scan slab in response to highmem page reclaim as well. 
>Because all the math is based around the total amount of memory in the
>machine, and we know that if we're performing highmem page reclaim then the
>lower zones have no free memory.
>
>

I don't understand this. Presumably if the lower zones have no free
memory then we'll be doing lowmem page reclaim too, and that will
be shrinking the slab.

The patch I sent you should (modulo the ->seeks stuff) make it
behave as if the slab pages are on lowmem LRUs and get scanned
accordingly.


