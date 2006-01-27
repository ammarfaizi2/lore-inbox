Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWA0V7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWA0V7E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 16:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbWA0V7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 16:59:03 -0500
Received: from [85.8.13.51] ([85.8.13.51]:41689 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030344AbWA0V7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 16:59:02 -0500
Message-ID: <43DA97A3.4080408@drzeus.cx>
Date: Fri, 27 Jan 2006 22:58:59 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060112)
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx> <20060127201458.GA2767@flint.arm.linux.org.uk> <20060127202206.GH9068@suse.de> <20060127202646.GC2767@flint.arm.linux.org.uk> <43DA84B2.8010501@drzeus.cx>
In-Reply-To: <43DA84B2.8010501@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Russell King wrote:
>   
>> On Fri, Jan 27, 2006 at 09:22:06PM +0100, Jens Axboe wrote:
>>   
>>     
>>> That is definitely valid, same goes for the bio_vec structure. They map
>>> _a_ page, after all :-)
>>>     
>>>       
>> Okay.  Pierre - are you saying that you have an sg entry where
>> sg->offset + sg->length > PAGE_SIZE, and hence is causing you to
>> cross a page boundary?
>>
>>   
>>     
>
> That, and sg->length > PAGE_SIZE. On highmem systems this causes all
> kinds of funky behaviour. Usually just bogus data in the buffers though.
>
>   

Test done here, few minutes ago. Added this to the wbsd driver in its
kmap routine:

    if ((host->cur_sg->offset + host->cur_sg->length) > PAGE_SIZE)
        printk(KERN_DEBUG "wbsd: Big sg: %d, %d\n",
            host->cur_sg->offset, host->cur_sg->length);

got:

[17385.425389] wbsd: Big sg: 0, 8192
[17385.436849] wbsd: Big sg: 0, 7168
[17385.436859] wbsd: Big sg: 0, 7168
[17385.454029] wbsd: Big sg: 2560, 5632
[17385.454216] wbsd: Big sg: 2560, 5632

And so on.

Rgds
Pierre

