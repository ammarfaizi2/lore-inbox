Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbULGRt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbULGRt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbULGRt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 12:49:29 -0500
Received: from blanca.radiantdata.com ([64.207.39.196]:55271 "EHLO
	blanca.peakdata.loc") by vger.kernel.org with ESMTP id S261856AbULGRtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 12:49:22 -0500
Message-ID: <41B5EF16.30107@radiantdata.com>
Date: Tue, 07 Dec 2004 10:57:42 -0700
From: "Peter W. Morreale" <morreale@radiantdata.com>
Reply-To: morreale@radiantdata.com
Organization: Radiant Data Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: Bug in kmem_cache_create with duplicate names
References: <1102434056.25841.260.camel@localhost.localdomain>	 <41B5CD41.9050102@osdl.org>  <1102436157.2882.8.camel@laptop.fenrus.org>	 <1102436777.25841.271.camel@localhost.localdomain> <1102437079.25841.275.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Dec 2004 17:52:13.0218 (UTC) FILETIME=[7B64C820:01C4DC85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Steven Rostedt wrote:

>On Tue, 2004-12-07 at 11:15 -0500, Arjan van de Ven wrote:
>
>  
>
>>>However, I agree with you.  I don't see a good reason for it.
>>>      
>>>
>>I do...
>>because if the registration gives success..... then you unregister it
>>later during module unload and the INITIAL user goes bang.
>>It's a bad bug. Don't do it. Fix your code ;)
>>
>>    
>>
>
>Your module should fail to load if you can't register a cache. If you
>are a good boy and check your return codes from the kmem_cache_create,
>you would know that the cache failed and not load the module.
>Otherwise, if it failed for other reasons, then you can be causing bugs
>later when you go to use it. 
>

This would preclude the use of a dynamic cache, not all initializations 
are performed during module
insertion.    It also breaks since there is no relationship between the 
size of the objects in the cache
and the cache name (which is causing the BUG).  

This BUG specifically means that you (or somebody else) allocated 
something and did not free it.  

That is broken.  FYC (Fix Yer Code ;-) is the answer.

>
>Now this raises the issue of name space, this will bug if two modules
>use the same cache name. If this happens with two different vendors,
>than the poor user will have to figure out who to blame.
>

No different than any other global namespace issue.

-PWM

-- 
Peter W. Morreale                            email: morreale@radiantdata.com
Director of Engineering                      Niwot, Colorado, USA
Radiant Data Corporation                     voice: (303) 652-0870 x108 
-----------------------------------------------------------------------------
This transmission may contain information that is privileged, confidential
and/or exempt from disclosure under applicable law. If you are not the
intended recipient, you are hereby notified that any disclosure, copying,
distribution, or use of the information contained herein (including any
reliance thereon) is STRICTLY PROHIBITED. If you received this transmission
in error, please immediately contact the sender and destroy the material in
its entirety, whether in electronic or hard copy format. Thank you.



