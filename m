Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263640AbUEVBBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUEVBBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 21:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUEVA7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:59:15 -0400
Received: from smtp103.mail.sc5.yahoo.com ([66.163.169.222]:30046 "HELO
	smtp103.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265125AbUEVA4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:56:37 -0400
Message-ID: <40ADC079.6000701@yahoo.com.au>
Date: Fri, 21 May 2004 18:40:25 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, alexeyk@mysql.com, linuxram@us.ibm.com,
       peter@mysql.com, linux-kernel@vger.kernel.org
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
References: <200405022357.59415.alexeyk@mysql.com> <1084480888.22208.26.camel@dyn319386.beaverton.ibm.com> <1084815010.13559.3.camel@localhost.localdomain> <200405200506.03006.alexeyk@mysql.com> <20040520145902.27647dee.akpm@osdl.org> <20040520152305.3dbfa00b.akpm@osdl.org> <40ADB062.8050005@yahoo.com.au> <20040521075027.GN1952@suse.de>
In-Reply-To: <20040521075027.GN1952@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, May 21 2004, Nick Piggin wrote:
> 
>>Andrew Morton wrote:
>>
>>
>>>Open questions are:
>>>
>>>a) Why is 2.6 write coalescing so superior to 2.4?
>>>
>>>b) Why is 2.6 issuing more read requests, for less data?
>>>
>>>c) Why is Alexey seeing dissimilar results?
>>>
>>
>>
>>Interesting. I am not too familiar with 2.4's IO scheduler,
>>but 2.6's have pretty comprehensive merging systems. Could
>>that be helping, Jens? Or is 2.4 pretty equivalent?
> 
> 
> 2.4 will give up merging faster than 2.6, elevator_linus will stop
> looking for a merge point if the sequence drops to zero. 2.6 will always
> merge. So that could explain the fewer writes.
> 

Yep OK, that could be one thing.

> 
>>What about things like maximum request size for 2.4 vs 2.6
>>for example? This is another thing that can have an impact,
>>especially for writes.
> 
> 
> I think that's pretty similar. Andrew didn't say what device he was
> testing on, but 2.4 ide defaults to max 64k where 2.6 defaults to 128k.
> 

This could be another. If Andrew's using IDE, this alone could
make up the entire difference *if* writes are nicely sequential.
I guess they probably aren't, but it could still help.
