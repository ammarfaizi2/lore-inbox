Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274931AbRIXUFX>; Mon, 24 Sep 2001 16:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274929AbRIXUFN>; Mon, 24 Sep 2001 16:05:13 -0400
Received: from [208.129.208.52] ([208.129.208.52]:43531 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S274927AbRIXUE6>;
	Mon, 24 Sep 2001 16:04:58 -0400
Message-ID: <XFMail.20010924130908.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010924203406.B9688@kushida.jlokier.co.uk>
Date: Mon, 24 Sep 2001 13:09:08 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Subject: Re: [PATCH] /dev/epoll update ...
Cc: Gordon Oliver <gordo@pincoya.com>
Cc: Gordon Oliver <gordo@pincoya.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dan Kegel <dank@kegel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24-Sep-2001 Jamie Lokier wrote:
> Eric W. Biederman wrote:
>> > As Davide points out in his reply, /dev/epoll is an exact clone of
>> > the O_SETSIG/O_SETOWN/O_ASYNC realtime signal way of getting readiness
>> > change events, but using a memory-mapped buffer instead of signal delivery
>> > (and obeying an interest mask).  Unlike /dev/poll, it only provides
>> > information about *changes* in readiness.
>> 
>> Right.  But it does one additional thing that the rtsig method doesn't
>> it collapses multiple readiness *changes* into a single readiness change.
>> This allows the kernel to keep a fixed size buffer so you never need
>> to fallback to poll as you need to with the rtsig approach.
> 
> That could be added to rtsigs, with the same result: no need to fallback
> to poll.

There's already a patch that implement this.


> You could even keep the memory for the queued signal / event inside the file structure.

By keeping the event structure inside the file* require you to collect
these events ( read memory moves ) at peek time.
With /dev/epoll the event is directly dropped inside the mmaped area.




- Davide

