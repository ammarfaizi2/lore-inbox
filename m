Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbUKBSB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbUKBSB5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbUKBSB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:01:57 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:41156 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261253AbUKBSBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:01:42 -0500
Message-ID: <4187CB93.6080405@drzeus.cx>
Date: Tue, 02 Nov 2004 19:01:55 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040919)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: __GFP flags and kmalloc failures
References: <4187AC80.6050409@drzeus.cx> <20041102144429.GG32054@logos.cnet>
In-Reply-To: <20041102144429.GG32054@logos.cnet>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>On Tue, Nov 02, 2004 at 04:49:20PM +0100, Pierre Ossman wrote:
>  
>
>>
>>The problem is now that this allocation doesn't always succeed. When it 
>>fails I get:
>>
>>insmod: page allocation failure. order:4, mode:0x11
>>    
>>
>
>This is a big allocation and the kernel is having problem finding such a 
>big page, due to memory fragmentation (as you mention below).
>
>What kernel version are you using?
>  
>
I'm currently running 2.6.9. No external patches (except for my own 
stuff related to this driver).

>-mm contains a series of patches from Nick which should make the situation 
>better, have you tried it? Currently kswapd doenst honour high order 
>page shortage.
>
>  
>
No I haven't. Only saw it today and I usually don't use the -mm tree. 
I've gotten the impression it's a bit too bleeding edge for me ;)
What do these patches add to the mix?
I'm also not familiar what the order means. I guess it's some kind of 
priority system? Is there a way I can raise my priority to get access to 
the memory that kswapd actually keeps available?

>>As for solutions I've tried using __GFP_REPEAT which seems to do the 
>>trick. But the double underscore indicates (at least to me) that these 
>>are internal defines that shouldn't be used except for very special 
>>cases. What is the policy about these?
>>    
>>
>
>Its OK to use these flags externally. They might change in future major kernel
>versions though, or even future v2.6 release.  ie its not a stable API.
>  
>
Is there any other way of increasing the chances of actually getting the 
pages I need? Since it is DMA it needs to be one big block.

Rgds
Pierre
