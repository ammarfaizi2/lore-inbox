Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVAKAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVAKAcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVAKAcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:32:09 -0500
Received: from mail.teja.com ([209.10.202.115]:43155 "EHLO mail.teja.com")
	by vger.kernel.org with ESMTP id S262540AbVAKA2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:28:51 -0500
Message-ID: <41E31F42.2000008@teja.com>
Date: Mon, 10 Jan 2005 16:35:14 -0800
From: Slade Maurer <smaurer@teja.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dsaxena@plexity.net
CC: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, linux@arm.linux.org.uk, drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
References: <8746466a050110153479954fd2@mail.gmail.com> <41E3176F.6000809@teja.com> <20050111000050.GA7958@plexity.net>
In-Reply-To: <20050111000050.GA7958@plexity.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deepak Saxena wrote:

>On Jan 10 2005, at 16:01, Slade Maurer was caught saying:
>  
>
>>Also, it would be nice to have PTEs to represent the upper 4GB such that 
>>it can be mmapped to user space. PAE handled this in and it would be 
>>great to have it in ARM MMU36 as well.
>>    
>>
>
>Not doable. I believe PAE allows for normal 4K pages to be used when
>mapping > 32-bits. XSC3 and ARMv6 only allow for > 32 bit addresses 
>when using 16MB pages (supersections), so we need to instead use
>the hugetlb approach.
>
>~Deepak
>
>  
>
You are right of course. The MMUs first level descriptors force you to 
have 16MB pages.

I don't see anything wrong with using hugeTLB. Then it is up to the user 
to get hugetlbfs setup so that they can mmap(...) properly. This is 
forced on us by the designers of the MMU ;)

I think that is better than setting permissions during ioremap(...) so 
that a user space process can use a kernel virtual address for user 
space access.

 -Slade

