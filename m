Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWAZVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWAZVMt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbWAZVMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:12:49 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:52381 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964902AbWAZVMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:12:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Gc3oGlk5Bd9FN5Owr4WZ5IYDm08R3rVorihZMNLN1XjXkpNxrGaDANeada10IIR4yFbqCnMaTLsXQiWtUfGPrKgPgLimxcdIW9m4laTlpxlOdSEaBr0xKCAcD+gpq0wgkb9FGZ2tuz2U5O8PlH28CMBAKejsb3PdYwPtOcJ9QJc=  ;
Message-ID: <43D93B4D.20601@yahoo.com.au>
Date: Fri, 27 Jan 2006 08:12:45 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Howard Chu <hyc@symas.com>, Lee Revell <rlrevell@joe-job.com>,
       Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
References: <20060124225919.GC12566@suse.de>  <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>  <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>  <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com> <1138223212.3087.16.camel@mindpipe> <43D7F863.3080207@symas.com> <43D88E55.7010506@yahoo.com.au> <43D8DB90.7070601@symas.com> <43D8E298.3020402@yahoo.com.au> <43D8E96B.3070606@symas.com> <43D8EFF7.3070203@yahoo.com.au> <43D8FC76.2050906@symas.com> <Pine.LNX.4.61.0601261231460.9298@chaos.analogic.com> <43D91C33.7050401@yahoo.com.au> <Pine.LNX.4.61.0601261405320.9584@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0601261405320.9584@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Thu, 26 Jan 2006, Nick Piggin wrote:

>>What cases has sched_yield mucked up for you, and why do you
>>think the problem is sched_yield mucking up? Can you solve it
>>using mutexes?
>>
>>Thanks,
>>Nick
> 
> 
> Somebody wrote code that used Linux Threads. We didn't know
> why it was so slow so I was asked to investigate. It was
> a user-interface where high-speed image data gets put into
> a buffer (using DMA) and one thread manipulates it. Another
> thread copies and crunches the data, then displays it. The
> writer insisted that he was doing the correct thing, however
> the response sucked big time. I ran top and found that the
> threaded processes were always grabbing big chunks of
> CPU time. Searching for every instance of sched_yield(), I
> was going to replace it with a diagnostic. However, the code
> ran beautifully when the 'fprintf(stderr, "Message\n"' was
> in the code! The call to write() sleeps. That gave the
> CPU to somebody who was starving. The 'quick-fix" was
> to replace sched_yield() with usleep(0).
> 
> The permanent fix was to not use threads at all.
> 

This sounds like a trivial producer consumer problem that you
would find in any basic books on synchronisation, threading, or
operating systems.

If it was not a realtime system, then I can't believe it has any
usages of sched_yield in there at all. If it is a realtime system,
then replacing them with something else could easily have broken
it.

Also, I'm not sure that you can rely on write or usleep for 0
microseconds to sleep.

> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13.4 on an i686 machine (5589.66 BogoMips).
> Warning : 98.36% of all statistics are fiction.
> .
> 
> ****************************************************************
> The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
> 
> Thank you.
> 

Any chance you can get rid of that crazy disclaimer when posting
to lkml, please?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
