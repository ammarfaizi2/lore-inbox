Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUCFM5N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 07:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUCFM5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 07:57:13 -0500
Received: from spectre.fbab.net ([212.214.165.139]:4744 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S261475AbUCFM5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 07:57:11 -0500
Message-ID: <4049CA99.4020002@fbab.net>
Date: Sat, 06 Mar 2004 13:56:57 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
References: <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu> <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu> <20040305145947.GA4922@dualathlon.random> <20040305150225.GA13237@elte.hu> <20040305201139.GA7254@mail.shareable.org> <20040306051256.GA9909@mail.shareable.org>
In-Reply-To: <20040306051256.GA9909@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
[snip]
> 
> Any code which is structured like this will break:
> 
> 	time_t timeout = time(0) + TIMEOUT_IN_SECONDS;
> 
> 	do {
> 		/* Do some stuff which takes a little while. */
> 	} while (time(0) <= timeout);
> 
> It goes wrong when time() returns a value that is in the past, and
> then jumps forward to the correct time suddenly.  The timeout of the
> above code is reduced by the size of that jump.  If the jump is larger
> than TIMEOUT_IN_SECONDS, the timeout mechanism is defeated completely.
> 
> That sort of code is a prime candidate for the method of using a
> worker thread updating a global variable, so it's really important to
> to take care when using it.
> 

But isn't this kind of code a known buggy way of implementing timeouts?
Shouldn't it be like:

time_t x = time(0);
do {
   ...
} while (time(0) - x >= TIMEOUT_IN_SECONDS);

Ofcourse it can't handle times in the past, but it won't get easily hung 
  with regards to leaps or wraparounds (if used with other functions).

Regards

Magnus


