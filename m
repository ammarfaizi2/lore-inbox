Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUGHHMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUGHHMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265865AbUGHHJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:09:12 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:56211 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265847AbUGHHGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 03:06:36 -0400
Message-ID: <40ECF278.7070606@yahoo.com.au>
Date: Thu, 08 Jul 2004 17:06:32 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Andrew Morton <akpm@osdl.org>, nigelenki@comcast.net,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
Subject: Re: [PATCH] Autoregulate swappiness & inactivation
References: <40EC13C5.2000101@kolivas.org> <40EC1930.7010805@comcast.net> <40EC1B0A.8090802@kolivas.org> <20040707213822.2682790b.akpm@osdl.org> <cone.1089268800.781084.4554.502@pc.kolivas.org>
In-Reply-To: <cone.1089268800.781084.4554.502@pc.kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Andrew Morton writes:
> 
>> Con Kolivas <kernel@kolivas.org> wrote:
>>
>>>
>>> > How about autoregulated swappiness, which seems to be very 
>>> efficient at
>>>  > its job?
>>>
>>>  It's been around for quite a while, and akpm has not expressed any 
>>>  interest in it so I think this will only ever flounder in the -ck 
>>> domain.
>>
>>
>> Nobody sent me the patch.  And the
>> justification/explanation/sales-brochure.  And the benchmarks...
> 
> 
> Ah what the heck. They can only be knocked back to where they already are.
> 

A few comments. I think making swappiness depend on the amount of
swap you have used is not a good idea. I might be wrong though, but
generally you should only make something *more* complex if you have
a good rationale and good numbers (you have the later, Andrew might
consider this enough). I especially don't like this sort of temporal
dependancy either, because it makes things much harder to reproduce
and think through.

Secondly, can you please not mess with the exported sysctl. If you
think your "autoswappiness" calculation is better than the current
swappiness one, just completely replace it. Bonus points if you can
retain the swappiness knob in some capacity.

Numbers look good though. I'll get around to doing some tests soon.
