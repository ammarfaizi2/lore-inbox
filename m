Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUBVHUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 02:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbUBVHUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 02:20:24 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:59567 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261185AbUBVHUT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 02:20:19 -0500
Message-ID: <40385830.8070900@cyberone.com.au>
Date: Sun, 22 Feb 2004 18:20:16 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: mfedyk@matchmail.com, cw@f00f.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com>	<20040222023638.GA13840@dingdong.cryptoapps.com>	<Pine.LNX.4.58.0402211901520.3301@ppc970.osdl.org>	<20040222031113.GB13840@dingdong.cryptoapps.com>	<Pine.LNX.4.58.0402211919360.3301@ppc970.osdl.org>	<20040222033111.GA14197@dingdong.cryptoapps.com>	<4038299E.9030907@cyberone.com.au>	<40382BAA.1000802@cyberone.com.au>	<4038307B.2090405@cyberone.com.au>	<40383300.5010203@matchmail.com>	<4038402A.4030708@cyberone.com.au>	<40384325.1010802@matchmail.com>	<403845CB.8040805@cyberone.com.au>	<20040221221721.42e734d6.akpm@osdl.org>	<40384D9D.6040604@cyberone.com.au> <20040221225746.31907f86.akpm@osdl.org>
In-Reply-To: <20040221225746.31907f86.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>>
>>Can you maybe use this patch then, please?
>>
>
>OK.
>
>
>>+static unsigned int nr_lowmem_lru_pages(void)
>>
>
>heh, that's what I called it.
>
>
>>+ * Total number of items in each slab should be used, not just freeable ones.
>>+ * Unfreeable slab items should not count toward the scanning total.
>>
>
>That's up to the individual shrinkers.  What we have for dcache and icache
>is close enough.  Most entries on inode_unused and dentry_unused should be
>reclaimable, but checking that with some instrumentation wouldn't hurt.
>
>

Yeah it is an issue with the shrinkers, but I put it here so I
only had to write it once.

All items under TODO list are pretty pedantic, but they might
have larger impacts with very small memory systems. They would
definitely improve consistency of shrink_slab's behaviour.

Granted they probably wouldn't do much in the large scheme of
things.

