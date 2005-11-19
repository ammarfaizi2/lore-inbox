Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVKSMeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVKSMeo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 07:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVKSMeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 07:34:44 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:59524 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751097AbVKSMen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 07:34:43 -0500
Message-ID: <437F1BD7.8070504@colorfullife.com>
Date: Sat, 19 Nov 2005 13:34:31 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, colpatch@us.ibm.com
Subject: Re: [PATCH 1/5] slab: rename obj_reallen to obj_size
References: <iq5uu1.87bo1s.3tcvszwr6pjjr4ngr04pw358p.beaver@cs.helsinki.fi>	 <437F1333.5010308@colorfullife.com> <1132401896.17963.5.camel@localhost>
In-Reply-To: <1132401896.17963.5.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>user_offset is more readable.
>
>  
>
Ok.

>>+	int			user_size;
>>    
>>
>
>  
>
>> #endif
>> };
>>-static int obj_dbghead(kmem_cache_t *cachep)
>>+static int obj_user_off(kmem_cache_t *cachep)
>>    
>>
>
>So why not call the above obj_offset() ?
>
>  
>
It would just cause confusion: The name of the function and the name of 
the member must be identical.
The purpose of obj_user_off() is to hide an optimization: 
cachep->user_off is always 0 when debugging is disabled. Therefore the 
member doesn't even exist with CONFIG_DEBUG_SLAB=n, and all accesses are 
hardcoded to 0.
This is achieved by using obj_user_off(cachep) instead of 
cachep->user_off. If the name of the helper and the name of the struct 
member differ, then noone would understand the code.
I'll do a new patch with user_offset instead of user_off, ok?

--
    Manfred
