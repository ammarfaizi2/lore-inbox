Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTDPXBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 19:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTDPXBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 19:01:31 -0400
Received: from dialup-105.157.221.203.acc50-nort-cbr.comindico.com.au ([203.221.157.105]:6662
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261871AbTDPXB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 19:01:29 -0400
Message-ID: <3E9DE1FA.4090609@cyberone.com.au>
Date: Thu, 17 Apr 2003 09:06:34 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-raid <linux-raid@vger.kernel.org>
Subject: Re: Benefits from computing physical IDE disk geometry?
References: <200304160932_MC3-1-34A9-3A79@compuserve.com>
In-Reply-To: <200304160932_MC3-1-34A9-3A79@compuserve.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chuck Ebbert wrote:

>>The way you would do a good "goodness" function, I guess,
>>would be to search through all requests on the device, and return
>>the minimum distance from the request you are running the query
>>on. Do this for both queues, and insert the request into the
>>queue with the smallest delta. I don't see much else doing any
>>good.
>>
>
>
>  That would be perfect.  And like you say in a later message, they're
>in a tree so it might actually work.  Then the read balance code
>wouldn't need to do that calculation at all.
>
>  How hard would this be to add?
>
It would be easy to add. Though of course it would have to
be shown to give an improvement somewhere to be included.

>
>
>
>
>>On the other hand, if you simply have a fifo after the RAID
>>scheduler, the RAID scheduler itself knows where each disk's
>>head will end up simply by tracking the value of the last
>>sector it has submitted to the device. It also has the advantage
>>that it doesn't have "high level" scheduling stuff below it
>>ie. request deadline handling, elevator scheme, etc.
>>
>>This gives the RAID scheduler more information, without
>>taking any away from the high level scheduler AFAIKS.
>>
>
>
> But then wouldn't you have to put all that into the RAID
>scheduler?
>
No - as far as I can see, the RAID scheduler already does
this. Having FIFOs between it and the disks would simply
make its assumptions valid.

