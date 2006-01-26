Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964925AbWAZWYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964925AbWAZWYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 17:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWAZWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 17:24:48 -0500
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:53896 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932365AbWAZWYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 17:24:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=24MKeOf1QQugxpieqci+UmjvEmg8xnj6+4++cBHa6/3kysCh5vQoqiEfC+AkJoJBfdLZ37qEFvQlRb3lnUMzSX4IS0M/zIqUQV+NV3xOOzDJ462umWuZa4V2je5JRsgtRH6MX3yi3RQwo7yjfiCOck0fzuRkspGqvXUfd4mXXYg=  ;
Message-ID: <43D94C2D.6080401@yahoo.com.au>
Date: Fri, 27 Jan 2006 09:24:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Howard Chu <hyc@symas.com>
CC: davids@webmaster.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <MDEHLPKNGKAHNMBLJOLKGENPJKAB.davids@webmaster.com> <43D930C6.40201@symas.com> <43D93542.9000809@yahoo.com.au> <43D93FEA.3070305@symas.com> <43D941FD.9050705@yahoo.com.au> <43D94595.4030002@symas.com>
In-Reply-To: <43D94595.4030002@symas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu wrote:
> Nick Piggin wrote:

>> Regardless of why, that is just the simplest scenario I could think
>> of that would give us a test case. However...
>>
>> Why not hold onto it? We sometimes do this in the kernel if we need
>> to take a lock that is incompatible with the lock already being held,
>> or if we discover we need to take a mutex which nests outside our
>> currently held lock in other paths. Ie to prevent deadlock.
> 
> 
> In those cases, A cannot retake the mutex anyway. I.e., you just said 
> that you released the first mutex because you want to acquire a 
> different one. So those cases don't fit this example very well.
> 

Umm yes, then *after* aquiring the different one, A would like to
retake the original mutex.

>> Another reason might be because we will be running for a very long
>> time without requiring the lock.
> 
> 
> And again in this case, A should not be immediately reacquiring the lock 
> if it doesn't actually need it.
> 

No, not immediately, I said "for a very long time". As in: A does not
need the exclusion provided by the lock for a very long time so it
drops it to avoid needless contention, then reaquires it when it finally
does need the lock.

>> Or we might like to release it because
>> we expect a higher priority process to take it.
> 
> 
> And in this case, the expected behavior is the same as I've been pursuing.
> 

No, we're talking about what happens when A tries to aquire it again.

Just accept that my described scenario is legitimate then consider it in
isolation rather than getting caught up in the superfluous details of how
such a situation might come about.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
