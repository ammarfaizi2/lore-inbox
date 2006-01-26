Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWAZWAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWAZWAB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWAZWAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:00:00 -0500
Received: from zcars04e.nortel.com ([47.129.242.56]:41214 "EHLO
	zcars04e.nortel.com") by vger.kernel.org with ESMTP
	id S1751403AbWAZV76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:59:58 -0500
Message-ID: <43D94611.2090203@nortel.com>
Date: Thu, 26 Jan 2006 15:58:41 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au> <43D93FEA.3070305@symas.com>
In-Reply-To: <43D93FEA.3070305@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2006 21:58:42.0942 (UTC) FILETIME=[AC2FD1E0:01C622C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:

> But why does A take the mutex in the first place? Presumably because it 
> is about to execute a critical section. And also presumably, A will not 
> release the mutex until it no longer has anything critical to do; 
> certainly it could hold it longer if it needed to.

Suppose A is pulling job requests off a queue.

A takes the mutex because it is going to modify data protected by the 
mutex.  It then gives up the mutex when it's done modifying the data.

> If A still needed the mutex, why release it and reacquire it, why not 
> just hold onto it? The fact that it is being released is significant.

Suppose A then pulls another job request off the queue.  It just so 
happens that this job requires touching some data protected by the same 
mutex.  It would need to take the mutex again.

A doesn't necessarily know what data the various jobs will require it to 
access, so it doesn't know a priori what mutexes will be required.

Chris
