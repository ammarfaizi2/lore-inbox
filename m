Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbSJIKt5>; Wed, 9 Oct 2002 06:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSJIKt4>; Wed, 9 Oct 2002 06:49:56 -0400
Received: from denise.shiny.it ([194.20.232.1]:13262 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261520AbSJIKt4>;
	Wed, 9 Oct 2002 06:49:56 -0400
Message-ID: <XFMail.20021009125532.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3DA3EC37.3F6FC3E8@digeo.com>
Date: Wed, 09 Oct 2002 12:55:32 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Cc: Andrew Morton <akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09-Oct-2002 Andrew Morton wrote:
> Giuliano Pochini wrote:
>> 
>> > The point of O_STREAMING is one change: drop pages in the pagecache
>> > behind our current position, that are free-able, because we know we will
>> > never want them.
>>
>> Does it drop pages unconditionally ?
>
> Yup.
>
>> What happens if I do a
>> streaming_cat largedatabase > /dev/null while other processes
>> are working on it ?
>
> You'll make your database run really slowly.
>
>> It's not a good thing to remove the whole
>> cached data other apps are working on.
>
> Don't do that then ;)

I was thinking about hot backups of databases. But even if it
did not drop caches "shared" by other processes it would drop
them anyway because write-behind is still on. Probably only
O_DIRECT can help in this case.

> Seriously, there are tons of ways of creating local performance
> DoS'es of this form.  fsync is an excellent tool for that.

Yes, I'm aware of that.


Bye.

