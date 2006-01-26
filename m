Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWAZCsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWAZCsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 21:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWAZCsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 21:48:50 -0500
Received: from rtr.ca ([64.26.128.89]:28302 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751285AbWAZCsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 21:48:50 -0500
Message-ID: <43D8386B.6000204@rtr.ca>
Date: Wed, 25 Jan 2006 21:48:11 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20051219 SeaMonkey/1.0b
MIME-Version: 1.0
To: davids@webmaster.com
Cc: Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGEJEJKAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEJEJKAB.davids@webmaster.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:
>> Kaz's post clearly interprets the POSIX spec differently from you. The
>> policy can decide *which of the waiting threads* gets the mutex, but the
>> releasing thread is totally out of the picture. For good or bad, the
>> current pthread_mutex_unlock() is not POSIX-compliant. Now then, if
>> we're forced to live with that, for efficiency's sake, that's OK,
>> assuming that valid workarounds exist, such as inserting a sched_yield()
>> after the unlock.
> 
> 	My thanks to David Hopwood for providing me with the definitive refutation
> of this position. The response is that the as-if rules allows the
> implementation to violate the specification internally provided no compliant
> application could tell the difference.
> 
> 	When you call 'pthread_mutex_lock', there is no guarantee regarding how
> long it will or might take until you are actually waiting for the mutex. So
> no conforming application can ever tell whether or not it is waiting for the
> mutex or about to wait for the mutex.
> 
> 	So you cannot write an application that can tell the difference.

Not true.  The code for the relinquishing thread could indeed tell the difference.

-ml
