Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbWFAFhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWFAFhJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWFAFhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:37:08 -0400
Received: from dvhart.com ([64.146.134.43]:29074 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965238AbWFAFhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:37:07 -0400
Message-ID: <447E7CF5.8020401@mbligh.org>
Date: Wed, 31 May 2006 22:36:53 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm1
References: <6iEI8-6Tx-37@gated-at.bofh.it> <6iG79-11u-23@gated-at.bofh.it> <6iGqr-1sJ-3@gated-at.bofh.it> <6iGJN-1SM-17@gated-at.bofh.it> <6iIsf-4Eq-11@gated-at.bofh.it> <447E3846.1060302@shaw.ca>
In-Reply-To: <447E3846.1060302@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Martin Bligh wrote:
> 
>>> We have to get to the bottom of this - there's a shadow over about 500
>>> patches and we don't know which.
>>>
>>> iirc I tried to reproduce this a couple of weeks back and failed.
>>>
>>> Are you able to narrow it down to a particular LTP test?  It was 
>>> mtest01 or
>>> something like that?  Perhaps we can identify a particular command line
>>> which triggers the fault in a standalone fashion?
>>
>>
>> The LTP output is here:
>>
>> http://test.kernel.org/abat/33803/debug/test.log.1
>>
>> The last test run was memset01
>>
>>  From a good test run 
>> (http://test.kernel.org/abat/33964/debug/test.log.1)
>> the one after memset01 is a second instance of the same.
>>
>> Which is bad I suppose, in that it's likely an intermittent failure.
>> Perhaps you can try running memset01 in a loop? I don't have such a
>> box set up here right now, I'm afraid ... will see what I can do.
>>
>> OTOH, it looks like this might be a different failure than the double
>> fault we saw in previous -mm's, which was consistently in mtest01, IIRC.
> 
> 
> As a shot in the dark, I've seen problems on my Athlon 64 box with a 
> program that does memset on a huge chunk of memory repeatedly which 
> causes the machine to panic in various ways, lock up or reboot. Is this 
> what that test is doing? I suspect my problem is caused by a AMD Athlon 
> 64/Opteron CPU erratum 97 "128-Bit Streaming Stores May Cause Coherency 
> Failure". The Newcastle CPU I have has this bug which can cause loss of 
> coherency on non-temporal stores, which the glibc memset function uses. 
> The BIOS is supposed to apply a workaround but I've no way of knowing if 
> mine (Asus A8N-SLI Deluxe) is..
> 
> And no it's not a memory problem, the system passes memtest86 overnight 
> without error. The problem usually shows up within a minute of starting 
> the continuous-memset program..

All sounds very sensible ... but not sure why -mm would hit it all the 
time, and never mainline ...

M.

