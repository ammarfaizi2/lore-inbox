Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVCWXZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVCWXZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVCWXZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:25:50 -0500
Received: from mail.signalz.com ([66.37.214.166]:63912 "EHLO mail.signalz.com")
	by vger.kernel.org with ESMTP id S262095AbVCWXZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:25:25 -0500
Message-ID: <4241FAF9.1080702@signalz.com>
Date: Wed, 23 Mar 2005 18:25:45 -0500
From: Matthew Collins <matt@signalz.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bernard Blackham <bernard@blackham.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Promise SX8 performance issues and CARM_MAX_Q
References: <20050323175707.GA10481@blackham.com.au> <4241F8BA.6070108@pobox.com>
In-Reply-To: <4241F8BA.6070108@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Bernard Blackham wrote:
>
>> Hi,
>>
>> Playing with a recently acquired Promise SX8 card, we've found
>> similar performance results to Matt's post to lkml a few months back
>> at http://marc.theaimsgroup.com/?l=linux-kernel&m=110175890323356&w=2
>>
>> It appears that the driver is only submitting one command at a time
>> per port, which is at least one cause of the slowdowns. By raising
>> CARM_MAX_Q from 1 to 3 in drivers/block/sx8.c (it was 3 in an
>> earlier pre-merge incarnation of carmel.c), we're getting very
>> notable speed improvements, with no side effects just yet.
>>
>> Knowing very little about what this change has actually done, I've a
>> few questions:
>>  - Should this be considered dangerous?
>>  - Why was it taken from 3 to 1?
>>  - Is CARM_MAX_Q a number defined (or limited) by the hardware?
>
>
> In multi-port stress tests, we couldn't get SX8 to function reliably 
> without locking up or corrupting data, with more than one outstanding 
> command.
>
> Maybe a new firmware has solved this by now.
>
>     Jeff
>
>
>
Indeed there does seem to be new firmware out as of 2/23/05. I ran my 
tests with the 9/10/04 firmware but I did not adjust the CARM_MAX_Q 
value. Do either of you happen to know what firmware revisions you 
tested under?

I've put the machine with the SX8 controller into production despite the 
performance issues so I'm not going to be of any use for testing 
revisions to the driver :(

Matt
