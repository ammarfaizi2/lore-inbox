Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277942AbRKMSZk>; Tue, 13 Nov 2001 13:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278042AbRKMSZb>; Tue, 13 Nov 2001 13:25:31 -0500
Received: from modem-3983.lemur.dialup.pol.co.uk ([217.135.143.143]:42253 "EHLO
	Mail.MemAlpha.cx") by vger.kernel.org with ESMTP id <S277942AbRKMSZT>;
	Tue, 13 Nov 2001 13:25:19 -0500
Posted-Date: Tue, 13 Nov 2001 14:41:43 GMT
Date: Tue, 13 Nov 2001 14:41:42 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
cc: Kai Henningsen <kaih@khms.westfalen.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <20011111204305.A16792@unthought.net>
Message-ID: <Pine.LNX.4.21.0111130027030.12260-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob.

>>> Sure, implement arbitrary precision arithmetic in every single app
>>> out there using /proc....

>> Bullshit. Implement whatever arithmetic is right *for your problem*.
>> And notice when the value you get doesn't fit so you can tell the
>> user he needs a newer version. That's all.
>> 
>> There's no reason whatsoever to care what data type the kernel used.

> So my program runs for two months and then aborts with an error
> because some counter just happened to no longer fit into whatever
> type I assumed it was ?
>
> Come on - you just can't code like that...

There are certain assumptions you can make about any given variable
without even seeing a specific value for it. For example:

 1. Does it make sense for the value to be negative? If not, use an
    unsigned variable.

    As an example, no systems can validly have a negative uptime, as
    that implies that it hasn't yet started running. It is for this
    very reason that a supposedly Roman coin inscribed with the date
    "37 BC" was known to be counterfeit - who measures time from an
    event that hasn't yet happenned?

 2. Does it make sense for the variable to report fractional values?
    If not, use integral variables.

    As an example, it makes no sense to have a fractional number of
    CPU's in a particular system - or, for that matter, for a given
    family to have the fabled 2.4 children !!!

 3. If fractional values do make sense, what accuracy is needed, and
    would it make sense to use scaled integers rather than reals?

    As an example, fractional values make sense for the current time
    but the need for accuracy indicates that scaled integers rather
    than reals are to be preferred, with the integers recording time
    in units of whatever fraction of a second is deemed sufficiently
    accurate for the intended purpose whilst still giving a practical
    range that can be stored.

    To take this one step further, and push the next version of the
    Y2K problem as far into the future as possible whilst providing
    a sufficient accuracy for most tasks nowadays, one could use a
    64-bit unsigned variable for the current time, but, rather than
    storing the number of seconds since epoch in it, store the
    number of xths of a second instead.

    As an example of this, a 64-bit unsigned value that measures the
    number of 40 ns intervals from Jan 1 00:00:00 UTC 1970 onwards
    will roll over at Jan 29 15:31:14 UTC 13661. This is a over 45%
    further in the future than the Y10K rollover seen elsewhere...

		( 13661 - 2000 )
		---------------- * 100 % = 145.762 %
		( 10000 - 2000 )

    With an interval of 40 ns one can accurately convert to seconds
    for backwards compatibility by simply dividing by 25,000,000.

 4. Is there any inherent limit on the range it can take? If not, use
    the largest available variables of the relevant type.

I've been doing this for 25 years now, and I've never regretted it.

Best wishes from Riley.

