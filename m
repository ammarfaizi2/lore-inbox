Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbULJCCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbULJCCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 21:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbULJCCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 21:02:42 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:24802 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261617AbULJCCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 21:02:39 -0500
Message-ID: <41B903BC.3020208@comcast.net>
Date: Thu, 09 Dec 2004 21:02:36 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Imanpreet Singh Arora <imanpreet@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question from Russells Spinlocks
References: <120920042115.25628.41B8C082000394E30000641C220076219400009A9B9CD3040A029D0A05@comcast.net> <Pine.LNX.4.60.0412092326260.2294@hermes-1.csi.cam.ac.uk>
In-Reply-To: <Pine.LNX.4.60.0412092326260.2294@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

>On Thu, 9 Dec 2004 kernel-stuff@comcast.net wrote:
>  
>
>>Spinlocks are used in situations where multiple threads contend for a 
>>lock and they can possibly run on more than one CPU. Example - Thread A 
>>is executing on CPU-A, Thread B in executing on CPU-B. They contend for 
>>a lock L1.  A acquires the lock first. B tries (on CPU-B) to acquire the 
>>lock L1 and finds it is not free - so it just spins (executes a no-op 
>>kind of loop ) until Thread A relinquishes the lock L1. Spinlocks are 
>>used in cases where the operation performed under a lock is short one - 
>>takes very less time. In these type of cases, spinning is less costlier 
>>than sleeping which involves scheduler overhead. So if we take out CPU-B 
>>from the above equation - there is no chance for Thread B to execute to 
>>contend for lock L1 without thread A going to sleep. That's why 
>>spinlocks are useless on 1 CPU machine.
>>    
>>
>
>Your last sentence is incorrect.  Spinlocks on 1 CPU machines still need 
>to disable preemption (assuming preemption is compiled in obviously, if 
>not then indeed you are right).  Otherwise preemption could take place in 
>the middle of a data manipulation and you would still have the same race 
>as you described with two cpus working concurrently.  Except that with 
>preemption it is only logical concurrence not actual physical concurrence.
>  
>
I didn't take pre-emption into account. Although I would not have 
readily thought about the need to disable Pre-emption even if I had 
considered it  :-) So thanks for the correction!

Parag
