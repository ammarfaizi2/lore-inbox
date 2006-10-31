Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423863AbWJaXpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423863AbWJaXpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 18:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423865AbWJaXpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 18:45:22 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:13670 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1423863AbWJaXpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 18:45:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D2PR4tgNm69L4g6fvVta29OWRMmxQTZRFuuyAx2IV1ePGk0gpxAGxh1iihFfMg3adD++3/8ZB8xoZmOriMCbfgdyGpOwUB/2bsVWGJ3BQpiymrldhyd5zVTwUE44NH/gLVT51Vua6G0zIdz9AGd7CS/cfcuuaFWhQRpBHA74z4w=  ;
Message-ID: <4547E009.6070008@yahoo.com.au>
Date: Wed, 01 Nov 2006 10:45:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060216 Debian/1.7.12-1.1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
References: <1162199005.24143.169.camel@taijtu> <4546FA81.1020804@cosmosbay.com> <45471A05.20205@yahoo.com.au> <200610311151.33104.dada1@cosmosbay.com> <4547CB25.3080603@yahoo.com.au> <4547D760.9000200@cosmosbay.com>
In-Reply-To: <4547D760.9000200@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:

> Nick Piggin a écrit :
>
>>
>> Again, lock / unlock operations require acquire / release 
>> consistency. This is a
>> memory ordering operation. It is not equivalent to smp_mb, though.
>
>
> This thread just show how difficult it is to have consistent use of 
> all this stuff in all kernel. Maybe it is just me ? Should I work on 
> IA64 to have a chance to learn ?


No need, just don't go thinking that mutex_unlock implies smp_mb.

spin_unlock has never implied an smp_rmb on i386.

> For example, Documentation/atomic_ops.txt comments about 
> atomic_inc_return() and atomic_dec_return() seems in contradiction 
> with itself.
>
> --------------------------
>
> Unlike the above routines, it is required that explicit memory
> barriers are performed before and after the operation.  It must be
> done such that all memory operations before and after the atomic
> operation calls are strongly ordered with respect to the atomic
> operation itself.
>
> -------------------------
>
> When I read this, I understand we (the user of such functions) need to 
> add smp_mb(). (That is, those functions wont do it themselves)


This is written from the point of view of the _implementor_. I agree it 
is a bit
confusing, but does the example below clear it up?

>
> Then following text is :
>
> ----------------------------
> For example, it should behave as if a smp_mb() call existed both
> before and after the atomic operation.
>
> --------------------------
>
> Now I understand the reverse.


Now you understand correctly ;)

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
