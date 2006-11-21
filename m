Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031417AbWKUUfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031417AbWKUUfz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031416AbWKUUfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:35:55 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:8351 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1031418AbWKUUfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:35:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Received:X-YMail-OSG:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=1qb5jkZ03lHtocH7cLs64i1gmQhmuu5VrhTKSoNwNzjmTwt3EIjWYVJoLpjIkl3B9QWFIkqkvhjgfyHaSER8oDKvcbzFErbxxlTRxHqxwzfjvGL6GOjE2EW+Hg8TYEVczEN1AuCSlcybKPJNggCqTPsYPjOiIdI5CvmWpAeNirg=  ;
X-YMail-OSG: mv5ZKicVM1likoUxMjeCGGEwxlk9j8bmSB_snSGokT5g.3fuGHH3Pdnz_39OTQVAXbp9eZrx5Bf8q1TaEeJWDA2iO66T6oVj.WoFjnsV5MAeuPpsujfTIA--
Message-ID: <456362DD.8070902@sbcglobal.net>
Date: Tue, 21 Nov 2006 14:34:37 -0600
From: Matthew Frost <artusemrys@sbcglobal.net>
Reply-To: artusemrys@sbcglobal.net
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Paul Sokolovsky <pmiscml@gmail.com>
CC: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Greg KH <gregkh@suse.de>
Subject: Re: Where did find_bus() go in 2.6.18?
References: <1154868495.20061120003437@gmail.com> <4560ECAF.1030901@gmail.com> <664994303.20061120021314@gmail.com> <1164011675.31358.566.camel@laptopd505.fenrus.org> <4563457B.2070806@sbcglobal.net> <20061121190150.GA25754@2ka.mipt.ru> <1928395959.20061121214106@gmail.com>
In-Reply-To: <1928395959.20061121214106@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Sokolovsky wrote:
> Hello Evgeniy,
> 
> Tuesday, November 21, 2006, 9:01:50 PM, you wrote:
> 
>> On Tue, Nov 21, 2006 at 12:29:15PM -0600, Matthew Frost (artusemrys@sbcglobal.net) wrote:
>>> So you have nested drivers.
> 
>    Matthew, thanks for your help, but it wasn't really my intention to
> waste other people's time with fixing our drivers. We are kernel
> hackers themselves, and eat our dogfood - with each kernel
> release, we have bunch of drivers breaking, and we patiently fix them
> (and yes, with recent releases, number of such drivers reduces, and
> that makes us really happy with recent 2.6 releases).

Alright, you're kernel hackers.  But I'd like to take issue with the mindset
that these drivers are your burden, to bear by yourselves.  It seems to me that
anyone with an iPaq relies upon this code path, or one like it, so you are
supporting a bunch of users by yourselves, and holding up the burden of
compatibility with the mainline kernel at the same time.  Doing twice as much
work, on two moving targets.  That's the waste of time.

>    But, this particular case made me wonder - was it some issue with
> change made in mainline, or there's something wrong with our manner to
> write drivers? And we'd like to be updated in the latter case.

And here's where the recommendation to get your code into mainline comes in.  If
the kernel developers don't know that you're using something, they can't tell
you what it was replaced by, or even that they need to replace it with anything.
 "No mainline users of the code" is a reliable baseline for value, because we
can't go looking for out-of-tree users in any convenient way.  Therefore nobody
tells you it's going to break until you learn the hard way that it broke, and
holler at the list.  Nobody *can* update you.  It isn't malice, it's finity.  If
your code is in mainline, whoever makes a change to mainline has to care,
because there is a legitimate burden of compatibility assurance, and it isn't
yours alone any longer.

> 
> []
> 
>>> (cc: E. Polyakov for the w1 expertise)
> 
>> Hello.
> 
>> If find_bus() will not be resurrected, I can export w1_bus_type or
>> create special helpers to directly access w1 bus master devices.
>> But in that case there is no need to have all driver model in w1
>> subsystem at all...
> 
>   Thanks for your response, Evgeniy!
> 
> 
>   Ok, so now it's not just me, it's the maintainer of a bus subsystem
> in mainline. There's no wonders, and one uncareful change in core API
> will cascade to many other places. Commented out find_bus()? Now need to
> make sure all bus types structures are exported. At least. But maybe
> maintainers will also wonder what happens here, and shouldn't they
> provide adhoc API to query a specific bus? And then indeed, what is
> the use of LDM? Where did go idea of having common, bus- and driver-
> independent API to do consistently all the stuff one *may* need (not
> all feature of which everyone necessarily uses all the time).
> 

I could be wrong, but it doesn't sound like Evgeniy is complaining that this
problem hits him.  The other drivers in w1/slaves don't use find_bus().  He's
offering to give you an export to hook into.  Though I might also look at
Dmitry's suggestion and rework around driver classes.  Which may fit in with
what Evgeniy says about moving the driver model out of w1.

Matt
