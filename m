Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSJ2R5D>; Tue, 29 Oct 2002 12:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261973AbSJ2R5D>; Tue, 29 Oct 2002 12:57:03 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:34030 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S261836AbSJ2R5C>; Tue, 29 Oct 2002 12:57:02 -0500
Message-ID: <3DBECD3F.2080204@nortelnetworks.com>
Date: Tue, 29 Oct 2002 13:02:39 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Alexander Viro <viro@math.psu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Entropy from disks
References: <20021029171011.GD28665@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:

I'm not an expert in this field, so bear with me if I make any blunders 
obvious to one trained in information theory.

> The current Linux PRNG is playing fast and loose here, adding entropy
> based on the resolution of the TSC, while the physical turbulence
> processes that actually produce entropy are happening at a scale of
> seconds. On a GHz processor, if it takes 4 microseconds to return a
> disk result from on-disk cache, /dev/random will get a 12-bit credit.

In the paper the accuracy of measurement is 1ms.  Current hardware has 
tsc precision of nanoseconds, or about 6 orders of magnitude more 
accuracy.  Doesn't this mean that we can pump in many more bits into the 
  algorithm and get out many more than the 100bits/min that the setup in 
the paper acheives?


> My entropy patches had each entropy source (not just disks) allocate
> its own state object, and declare its timing "granularity".

Is it that straightforward? In the paper they go through a number of 
stages designed to remove correlated data.  From what I remember of the 
linux prng disk-related stuff it is not that sophisticated.


> There's a further problem with disk timing samples that make them less
> than useful in typical headless server use (ie where it matters): the
> server does its best to reveal disk latency to clients, easily
> measurable within the auto-correlating domain of disk turbulence.

If this is truly a concern, what about having a separate disk used for 
nothing but generating randomness?

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

