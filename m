Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUK1PY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUK1PY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 10:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUK1PY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 10:24:57 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:31692 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261492AbUK1PYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 10:24:55 -0500
Message-ID: <41A9EDB7.8020304@colorfullife.com>
Date: Sun, 28 Nov 2004 16:24:39 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Oleg Nesterov <oleg@tv-sign.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] rcu: cosmetic, delete wrong comment, use HARDIRQ_OFFSET
References: <41A9E98C.2C1D07EF@tv-sign.ru> <20041128151925.GA20894@in.ibm.com>
In-Reply-To: <20041128151925.GA20894@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>On Sun, Nov 28, 2004 at 06:06:52PM +0300, Oleg Nesterov wrote:
>  
>
>>Afaics, this comment is misleading. rcu_check_quiescent_state()
>>is executed in softirq context, while rcu_check_callbacks() checks
>>in_softirq() before ++qsctr.
>>
>>Also, replace (1 << HARDIRQ_SHIFT) by HARDIRQ_OFFSET.
>>
>>    
>>
>
>Looks good to me. IIRC, that comment has been around since very
>early prototypes, so it is probably leftover trash.
>
>  
>
I agree. I think I only moved it around.
But I don't like the HARDIRQ_OFFSET change. If I understand the code 
correctly it checks that there is no hardirq reentrancy, i.e. the count 
is 0 or 1. Shifted to the appropriate position for the actual test.
I'd either leave it as it is or use "1*HARDIRQ_OFFSET" - otherwise the 
information that the count should be less of equal one is lost.

--
    Manfred
