Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVKHSyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVKHSyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030318AbVKHSyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:54:38 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:60618 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030315AbVKHSyh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:54:37 -0500
Message-ID: <4370F46A.3090501@us.ibm.com>
Date: Tue, 08 Nov 2005 10:54:34 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Cleanup kmem_cache_create()
References: <436FF51D.8080509@us.ibm.com> <436FF70D.6040604@us.ibm.com> <Pine.LNX.4.58.0511080951230.10193@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0511080951230.10193@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Mon, 7 Nov 2005, Matthew Dobson wrote:
> 
>>@@ -1652,9 +1649,9 @@ kmem_cache_t *kmem_cache_create(const ch
>> 		 * gfp() funcs are more friendly towards high-order requests,
>> 		 * this should be changed.
>> 		 */
>>-		do {
>>-			unsigned int break_flag = 0;
>>-cal_wastage:
>>+		unsigned int break_flag = 0;
>>+
>>+		for ( ; ; cachep->gfporder++) {
>> 			cache_estimate(cachep->gfporder, size, align, flags,
>> 						&left_over, &cachep->num);
>> 			if (break_flag)
>>@@ -1662,13 +1659,13 @@ cal_wastage:
>> 			if (cachep->gfporder >= MAX_GFP_ORDER)
>> 				break;
>> 			if (!cachep->num)
>>-				goto next;
>>-			if (flags & CFLGS_OFF_SLAB &&
>>-					cachep->num > offslab_limit) {
>>+				continue;
>>+			if ((flags & CFLGS_OFF_SLAB) &&
>>+			    (cachep->num > offslab_limit)) {
>> 				/* This num of objs will cause problems. */
>>-				cachep->gfporder--;
>>+				cachep->gfporder -= 2;
> 
> 
> This is not an improvement IMHO. The use of for construct is non-intuitive
> and neither is the above. A suggested cleanup is to keep the loop as is but
> extract it to a function of its own.
> 
> 				Pekka

To me the for loop is more readable and intuitive, but that is definitely a
matter of opinion.  Moving the code to it's own helper function is a better
idea than leaving it alone, or changing to a for loop, though.  Will resend
later today.

Thanks!

-Matt
