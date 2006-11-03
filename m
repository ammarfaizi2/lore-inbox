Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752805AbWKCMsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbWKCMsR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 07:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbWKCMsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 07:48:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:36510 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752805AbWKCMsQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 07:48:16 -0500
Message-ID: <454B3890.8070607@redhat.com>
Date: Fri, 03 Nov 2006 07:39:44 -0500
From: Larry Woodman <lwoodman@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages() failures reported due to fragmentation
References: <454B3282.3010308@redhat.com> <1162556514.14530.163.camel@laptopd505.fenrus.org>
In-Reply-To: <1162556514.14530.163.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>--- linux-2.6.18.noarch/net/core/sock.c.orig
>>+++ linux-2.6.18.noarch/net/core/sock.c
>>@@ -1154,7 +1154,7 @@ static struct sk_buff *sock_alloc_send_p
>> 			goto failure;
>> 
>> 		if (atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf) {
>>-			skb = alloc_skb(header_len, sk->sk_allocation);
>>+			skb = alloc_skb(header_len, gfp_mask);
>> 			if (skb) {
>> 				int npages;
>> 				int i;
>>    
>>
>
>Hi,
>
>this is not actually right though... sk_allocation is very possible to
>have a restricting mask compared to the one passed in (say "no highmem"
>or even GFP_DMA) and you now discard this... probably better would be to
>calculate a set of "transient" flags that you then or into the
>sk_allocation mask at this time...
>
>Greetings,
>   Arjan van de Ven
>
>  
>
Hi Arjan.  Right but this just includes __GFP_REPEAT in the mask so we can
defrag in __alloc_pages and only if GFP_WAIT was passed in origionally.

Larry


