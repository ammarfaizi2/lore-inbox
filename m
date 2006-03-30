Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWC3HSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWC3HSu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWC3HSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:18:50 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:33960 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751203AbWC3HSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:18:49 -0500
In-Reply-To: <20060330071322.GA3137@elte.hu>
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com> <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com> <44288FB3.5030208@yahoo.com.au> <20060329150815.GA24741@elte.hu> <442B4890.6000905@yahoo.com.au> <20060330071322.GA3137@elte.hu>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F86880BD-2EE9-4078-AB28-F769EF507C3B@kernel.crashing.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, emin ak <eminak71@gmail.com>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.16-rt10 crash on ppc
Date: Thu, 30 Mar 2006 01:18:58 -0600
To: Ingo Molnar <mingo@elte.hu>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 30, 2006, at 1:13 AM, Ingo Molnar wrote:

>
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
>> Yes, that patch is basically what I had in mind.
>>
>> Is -rt ever allocating memory from really-hard-don't-preempt-me
>> context? I guess not, unless the zone->lock is one of those locks  
>> too,
>> right?
>
> no. zone->lock (and all the slab locks, and all the other MM locks)  
> are
> fully preemptible too.
>
>> Should you add a
>>
>>  #else
>>     BUG_ON(_really_dont_preempt_me());
>>  #endif
>>
>> just for safety, or will such misusage get caught elsewhere (eg. when
>> attempting to take zone->lock).
>
> it should be caught immediately, by the cond_resched().

The issue me actually be a driver interrupt locking bug.  The driver  
supports three distinct interrupts for TX, RX, Error.  I asked Emin  
to try changing the driver to use SA_INTERRUPT in the request_irq()  
to see what happens.  I believe that when he did that it worked but  
hurts performance.

- kumar
