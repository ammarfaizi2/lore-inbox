Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWHLOyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWHLOyK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWHLOyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:54:10 -0400
Received: from sccrmhc15.comcast.net ([63.240.77.85]:34219 "EHLO
	sccrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S932541AbWHLOyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:54:07 -0400
Message-ID: <44DDEB7D.7040300@comcast.net>
Date: Sat, 12 Aug 2006 10:53:49 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: How does Linux do RTTM?
References: <44DACA22.6090701@comcast.net> <20060809.231244.35509467.davem@davemloft.net> <44DAF559.8010705@comcast.net> <20060810.020205.10245646.davem@davemloft.net> <44DDD83E.9010307@comcast.net> <20060812135332.GA27390@2ka.mipt.ru>
In-Reply-To: <20060812135332.GA27390@2ka.mipt.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Evgeniy Polyakov wrote:
> On Sat, Aug 12, 2006 at 09:31:42AM -0400, John Richard Moser (nigelenki@comcast.net) wrote:
>> I'm told now that it uses Jiffies for TCP timestamps.  I've had thoughts
>> on this:
>>
>>  - I figured a random timestamp with random microsecond skew would be
>> nice but this might expose internals of the RNG; amusingly I'm trying
>> not to expose internals of the RNG by exposing system time.
>>
>>  - Someone recommended starting at zero.  This would work, really,
>> there's no attacks based on guessing the TCP timestamp value.  This is
>> nice since if I want to hax0rz then I might make a connection and see
>> how many jiffies there are to get a feel for the system's uptime; this
>> tells me how long since you upgraded your kernel, so I have an arsenal
>> of vulns I KNOW you haven't fixed ready ;)  Starting at 0 doesn't give
>> that information.
>>
>> Comments?
> 
> Starting TCP timestamp from zero or any other arbitrary value for each 
> new connection will not give you any security benefits. There is no 

The TCP timestamp is the vessel; the target is the system uptime.

So, "preventing attackers from discovering the uptime of the remote
system will not give you any security benefits" is your statement.

> simple way aleph1 or e-eye will get a remote shell or steal your credit 
> card number if there is a buffer overflow in kernel and they will know 
> it's release.

Well, they could throw a netfilter buffer overflow at it; but there's
only ever been one I think.  ;)  Aside from that, it's a matter of doing
reconaissance BEFORE you get a local non-root or getting a local
non-root and THEN picking out your root elevation exploits, which is
only a few minutes difference.

(then again, storming the Bastille wouldn't have worked if they got to
the front door and sat on their asses for 2 minutes)

> So your proposals just are not needed for majority of people, but if you
> strongly feel it will help to find a cure for cancer, implement it and
> prove it's usefullness to netdev community.
> 

It's not so much that as the cost of doing an arbitrary value is storing
the number of jiffies that make zero with each connection; this doesn't
seem significant.  On the other hand, it removes one method for getting
a piece of information about the system that nobody said you could have;
some "hardened" configurations disable timestamps altogether for this
(amusingly they don't block ICMP Timestamp Reply outgoing).  For the
sake of argument, I can at least say this would improve performance of
the RTTM for the paranoid.

In case you're wondering, myself I find this to be of minimal concern as
long as jiffies/uptime/etc have nothing to do with the PRNGs on the system.
- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond

    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIUAwUBRN3rews1xW0HCTEFAQLppA/4nWBgXTgeDQyqAmERS+Ao/XeS1Ts6S///
Vdh5Hkvn3tAo6mfNfpvKtc4Cw1rz8X9YFew4l9gk8nT8rhiWc9Bp/30nRmqbTra7
BDrgIZr11662mjukCWb+G9aSBuG2frs5xNqtO7eSgOhNX5IroYgsbhtVtZlmvsbM
uQjUyO5VBo8J9XmIGGZ7fi1+WwY8a32I8oVE8OKgMeGTuxFOt7ZjcMiwRu3FoISu
qMO1Cvqp6yieyMxswiJNXZcUUv/yBtV233A5g06a4Y9EbCPSLZ+d6LUvhDYdEUYi
XNNzRmCyQwvbyNyiZBVvx/tZNCSRvqwQLB/FTkECCzJpzcLtPooEwiXY1DLI8zew
6boP3C1uxTQZvZfMBhSDvJZ+j0Fs3xNyxe7rF9iigzOH9Zle2EgjUaP90W1Drgxh
Czx1p67UeQBj7+zLS8TW/cjVpNZPkBWOFd7aJjzmjUf+4u7eRtQlVTfS9iDisvT6
NofjN8BkvmtEz34ooORNLSawW9kTcmNva+/Xjx+qHLjvvOGELm/xwXlGdUKBz7MV
TJydVOie8A10WFmFViSyqMUUv/wWqHabmgQPtJ00O+YntvccT5xcyMCVON8x56q7
IEqT+HsdML3AKSXdg7yf3nUp0Ln8LtFAWkYqIbIE/oxOeNiWnOzYp1+FnQHr/Ady
3VS30lcTgA==
=/G41
-----END PGP SIGNATURE-----
