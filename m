Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVCNIns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVCNIns (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 03:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVCNIns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 03:43:48 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:54187 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261339AbVCNInq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 03:43:46 -0500
Message-ID: <42354EBA.3070504@yahoo.com.au>
Date: Mon, 14 Mar 2005 19:43:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] break_lock forever broken
References: <Pine.LNX.4.61.0503111847450.9320@goblin.wat.veritas.com>	 <20050311203427.052f2b1b.akpm@osdl.org>	 <Pine.LNX.4.61.0503122311160.13909@goblin.wat.veritas.com>	 <20050314070230.GA24860@elte.hu> <42354562.1080900@yahoo.com.au>	 <20050314081402.GA26589@elte.hu>  <42354A3F.4030904@yahoo.com.au> <1110789270.6288.53.camel@laptopd505.fenrus.org>
In-Reply-To: <1110789270.6288.53.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>>Yes that's the tradeoff. I just feel that the former may be better,
>>especially because the latter can be timing dependant (so you may get
>>things randomly "happening"), and the former is apparently very low
>>overhead compared with the cost of taking the lock. Any numbers,
>>anyone?
> 
> 
> as I said, since the cacheline just got dirtied, the write is just half
> a cycle which is so much in the noise that it really doesn't matter.
> 

Yes, you were the "apparently" that I cited :)

I just wondered if Ingo has or has seen numbers that make
him dislike this way of doing it.

I would have thought that the spinlock structure and code bloat,
and the lock break checks in fast paths would be the far greater
cost of lockbreak than what Hugh's patch adds. But real numbers
are pretty important when it comes to this kind of thing.

