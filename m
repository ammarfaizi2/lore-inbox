Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUEVIoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUEVIoA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbUEVIn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:43:59 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:7374 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264919AbUEVIn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:43:57 -0400
Message-ID: <40AF12C3.80902@colorfullife.com>
Date: Sat, 22 May 2004 10:43:47 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: slab redzoning
References: <20040522034902.GB2161@holomorphy.com> <40AF0911.6020000@colorfullife.com> <20040522082602.GJ2161@holomorphy.com>
In-Reply-To: <20040522082602.GJ2161@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>On Sat, May 22, 2004 at 10:02:25AM +0200, Manfred Spraul wrote:
>  
>
>>Why this change? I've tested my fls(size-1)==fls(size-1-3*4) approach 
>>and it always returned the right result: No redzoning between 8181 and 
>>8192 bytes, between 16373 and 16384, etc.
>>    
>>
>
>It returns a false positive when size + 3*BYTES_PER_WORD == 2**n, e.g.
>size == 16373. Here, fls(size - 1) == 13, but fls(size - 1 + 12) == 13
>while size - 1 + 12 == 16384, where we'd want the check to fail.
>
No, 16373 must fail: After adding 12 bytes the object size would be 
16385, which would mean an order==3 allocation.
And 16372 must succeed: 16384 is still an order==2 allocation.

The idea is that there shouldn't be an allocation order increase due to 
redzoning, and afaics that doesn't happen, except between 4082 and 4095 
bytes.

--
    Manfred

