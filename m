Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVIHNlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVIHNlr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVIHNlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:41:47 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:4551 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751352AbVIHNlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:41:47 -0400
Message-ID: <43203F8E.5080108@nortel.com>
Date: Thu, 08 Sep 2005 09:41:34 -0400
From: "Stephane Couture" <stephanc@nortel.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.13-rt3
References: <1125591893.7842.7.camel@localhost.localdomain> <1125593160.5761.3.camel@localhost.localdomain> <1125603507.5810.6.camel@localhost.localdomain> <20050901202830.GB27229@elte.hu>
In-Reply-To: <20050901202830.GB27229@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2005 13:41:37.0317 (UTC) FILETIME=[08E59D50:01C5B47B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> 
>>Ingo,
>>
>>I just found a __MAJOR__ bug in my code.  Below is the patch that 
>>fixes this bug, zaps the WARN_ON in check_pi_list_present, and changes 
>>ALL_TASKS_PI to a booleon instead of just a define.
>>
>>The major bug was in __down_trylock.  See anything wrong with this 
>>code :-) I'm surprised that this worked as well as it did!
> 
> 
> ok, i've released -rt4 with this fix included. The 8-way box boots fine 
> now.
> 
> 	Ingo

On 2.6.13-rt4, I get this error when HIGH_RES_TIMERS is disabled :

arch/ppc/kernel/built-in.o(.text+0x1dbc): In function `timer_interrupt':
arch/ppc/kernel/time.c:241: undefined reference to `do_hr_timer_int'

There is some #ifdef CONFIG_HIGH_RES_TIMERS missing in 
arch/ppc/kernel/time.c
