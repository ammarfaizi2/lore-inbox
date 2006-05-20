Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWETDk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWETDk7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 23:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWETDk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 23:40:59 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:13026 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932478AbWETDk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 23:40:59 -0400
Message-ID: <446E8EB1.60406@comcast.net>
Date: Fri, 19 May 2006 23:36:17 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060518)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.16.16 Parameter-controlled mmap/stack randomization
References: <446E6A3B.8060100@comcast.net>
In-Reply-To: <446E6A3B.8060100@comcast.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oh, some of my stuff is 4096 hard-coded instead of PAGE_SIZE.  I fixed
this in mmap() randomization here, but there's iffiness coming up for
the stack.

The stack is page aligned and randomized in the VMA; then randomized to
16 byte intervals.  This is fine, PAGE_SIZE is 4096, our intervals are
16, 256 positions, we randomize 2^(stack_random_bits - 8) VMA and 2^8
inside; unless we have less than 8 bits, then we randomize
2^stack_random_bits and align to PAGE_SIZE / (2^stack_random_bits).

Easy enough.  Now what if PAGE_SIZE isn't 4096?

That's an easy problem too.  This can easily be calculated straight
forward with the number ... 8.  In fact that's how I did it.  2^8 is
4096 / 16.  Thus, the solution is log_base_2(PAGE_SIZE/16) instead of 8!

Now.  How do I find the base 2 log of a number in the kernel?

John Richard Moser wrote:
> Any comments on this one?
> 
> I'm trying to control the stack and heap randomization via command-line
> parameters.  I wrote this in a 2.6.15 Ubuntu Dapper kernel and then
> patched it into a 2.6.16.16 tree and cleaned it up.  It does a few
> simple things:
> 

[SNIP]

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
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRG6OsAs1xW0HCTEFAQLV4A/7BduRbAsWgvCy8ZMMRVYze33nkjGaK+o7
jd7EN7r+pcwr5EDKG4NdryTj+MdoSQJuAjy8eclaRFxJtu9jugE6e/q/wNlxRe9y
7q2mx4imNcrhVJ0TXKi6HL139lqON2kp4T4MlARLmwqy0zmtSjRGYUOAkxsYoXbp
5XvYe550O12caqGJvpWjPsv7hDMBSVmuo0i98SHCY9piafZtLl0rqgiVfRKicukq
ErmQd8UEhwjCwwqA34+6g9cR8107T6qvWucBqK4z9MDl65VrlnBQvzgdWb+Y6hDw
wUdX54E+si/1dsvUu9+cA9zZuHUeNOEaTPZB0Kirtdmkv5XRiorZ8PMjCLgFrhEW
05Vn2CmrJL7a+1bkOYBYal1eZbg2xgEKIeqE4SeMkkRdnmmr7BJwGh5h9LcMAVra
QCiMf7T4yV6qPLlYiuad/SUshel0YauTC63EcG4qO37Gx93amKgGyzCef2bVWc4T
iPOSG3YVIorrZIy1ZWOSQSfcmSappLx52vagbHYQOHKHtlBazz0elI730LDRQxCr
H4CfByfmf4GsoCWg7+aZ5awruh0Q8qXjLXRRunhhCBiz5Y3h+6uzh786Vuv13+Be
TuvVJ/ZYQrVKbpGvRXHYN6GC4Wx2Tl5HiMDLCvU0lVYMv+uH3c0b2eOfi7VpE5SZ
rimyC8GoqyA=
=jOSA
-----END PGP SIGNATURE-----
