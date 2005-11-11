Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbVKKTi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVKKTi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVKKTi5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:38:57 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:37136 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751107AbVKKTi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:38:56 -0500
Message-ID: <4374F2D5.7010106@vmware.com>
Date: Fri, 11 Nov 2005 11:36:53 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz>
In-Reply-To: <20051111103605.GC27805@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Nov 2005 19:36:55.0042 (UTC) FILETIME=[45B04E20:01C5E6F7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>So some 486 processors do have CR4 register.  Allow them to present it in
>>register dumps by using the old fault technique rather than testing processor
>>family.
>>    
>>
>
>I thought Andi commented this as "way too risky", for little
>good. Nested exceptions are evil.
>  
>

I didn't see Andi's comment to that effect.  I may have originally 
argued that when I made CR4 reads depend on CPU family.  But I think it 
is useful to know if PSE is enabled, especially on 486s that do support it.

Agree nested exceptions are evil.  But where is this called from 
execption context? 

1) softlockup_tick appears to be perfectly safe call site to handle 
exceptions
2) sysrq-p is also a fine site.

I tested this by assembling a hacked safe_read_cr1() macro, and dumped 
the contents of my non-existant CR1 regsiter in show_regs to prove the 
fault handling correct (although the code already _looks_ correct, I 
thought someone might ask the question you just did. :)

Zach
