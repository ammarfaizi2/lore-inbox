Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317367AbSFGXwN>; Fri, 7 Jun 2002 19:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317368AbSFGXwM>; Fri, 7 Jun 2002 19:52:12 -0400
Received: from wotug.org ([194.106.52.201]:10852 "EHLO gatemaster.ivimey.org")
	by vger.kernel.org with ESMTP id <S317367AbSFGXwL>;
	Fri, 7 Jun 2002 19:52:11 -0400
Date: Sat, 8 Jun 2002 00:51:59 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@sharra.ivimey.org
To: george anzinger <george@mvista.com>
cc: ashieh@OCF.Berkeley.EDU, <linux-kernel@vger.kernel.org>
Subject: Re: gettimeofday clock jump bug
In-Reply-To: <3D012188.7B6ADC9F@mvista.com>
Message-ID: <Pine.LNX.4.44.0206080046420.19463-100000@sharra.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ashieh@OCF.Berkeley.EDU wrote:
> time() occasionally returns a
>bogus value (>1 hour jump forward, and a few microseconds later jumps back to
>the right time) on my box (Thunderbird 750, Asus K7V (KX133) kernel 2.4.17).
>This behavior sets in after the box is up for some period of time. I don't
>think this is related to the 686a configuration reset bug.
>
On Fri, 7 Jun 2002, george anzinger wrote:
>I suspect that do_gettimeoffset() may be, on occasion,
>returning a negative number.  The normalizing code then
>works with this (unsigned) value until it is < 1,000,000. 
>If it came back as -1, this would generate an error of about
>1.19 hours.  I suspect the best fix would be to test the
>result from do_gettimeoffset() for something greater than
>say 20ms and if so set it to 0.

I've just looked at the i386 time.c source and can see no obvious way for -1
to be returned by do_gettimeoffset(). I note that this error is fixed in the
next time() call, so I would instead expect the error to be one involving the 
conversion of tv_secs/tv_usecs into the seconds return from time().

One possible way to check this out would be to change the test program from
using the time() call to using gettimeofday(), and to ignore tv_usecs.

Hope this helps,

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.

