Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVJQN3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVJQN3A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 09:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVJQN3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 09:29:00 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:10723 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751299AbVJQN27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 09:28:59 -0400
Message-ID: <4353A6F6.9050205@cosmosbay.com>
Date: Mon, 17 Oct 2005 15:28:22 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RCU problem] was VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <435394A1.7000109@cosmosbay.com> <20051017123655.GD6257@in.ibm.com>
In-Reply-To: <20051017123655.GD6257@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 17 Oct 2005 15:28:23 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma a écrit :
> On Mon, Oct 17, 2005 at 02:10:09PM +0200, Eric Dumazet wrote:
> 
>>Dipankar Sarma a écrit :
>>
>>>On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
>>>
>>>Agreed. It is not designed to work that way, so there must be
>>>a bug somewhere and I am trying to track it down. It could very well
>>>be that at maxbatch=10 we are just queueing at a rate far too high
>>>compared to processing.
>>>
>>
>>I can freeze my test machine with a program that 'only' use dentries, no 
>>files.
>>
>>No message, no panic, but machine becomes totally unresponsive after few 
>>seconds.
>>
>>Just greping for call_rcu in kernel sources gave me another call_rcu() use 
>>from syscalls. And yes 2.6.13 has the same problem.
> 
> 
> Can you try it with rcupdate.maxbatch set to 10000 in boot
> command line ?
> 

Changing maxbatch from 10 to 10000 cures the problem.
Maybe we could initialize maxbatch to (10000000/HZ), considering no current 
cpu is able to queue more than 10.000.000 items per second in a list.


> FWIW, the open/close test problem goes away if I set maxbatch to
> 10000. I had introduced this limit some time ago to curtail
> the effect long running softirq handlers have on scheduling
> latencies, which now conflicts with OOM avoidance requirements.

Yes, and probably OOM avoidance has a higher priority than latencies in DOS 
situations...

Eric
