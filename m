Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265166AbSKEXt2>; Tue, 5 Nov 2002 18:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265164AbSKEXt1>; Tue, 5 Nov 2002 18:49:27 -0500
Received: from mail.webmaster.com ([216.152.64.131]:43719 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S265161AbSKEXt0> convert rfc822-to-8bit; Tue, 5 Nov 2002 18:49:26 -0500
From: David Schwartz <davids@webmaster.com>
To: <cfriesen@nortelnetworks.com>, Oliver Xymoron <oxymoron@waste.org>
CC: Alexander Viro <viro@math.psu.edu>,
       linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Tue, 5 Nov 2002 15:55:57 -0800
In-Reply-To: <3DBECD3F.2080204@nortelnetworks.com>
Subject: Re: Entropy from disks
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20021105235601.AAA26869@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Oct 2002 13:02:39 -0500, Chris Friesen wrote:
>Oliver Xymoron wrote:

>I'm not an expert in this field, so bear with me if I make any blunders
>obvious to one trained in information theory.

>>The current Linux PRNG is playing fast and loose here, adding entropy
>>based on the resolution of the TSC, while the physical turbulence
>>processes that actually produce entropy are happening at a scale of
>>seconds. On a GHz processor, if it takes 4 microseconds to return a
>>disk result from on-disk cache, /dev/random will get a 12-bit credit.

>In the paper the accuracy of measurement is 1ms.  Current hardware has
>tsc precision of nanoseconds, or about 6 orders of magnitude more
>accuracy.  Doesn't this mean that we can pump in many more bits into the
>algorithm and get out many more than the 100bits/min that the setup in
>the paper acheives?

	In theory, if there's any real physical randomness in a timing source, the 
more accuracy you measure the timing to, the more bits you get.

>>My entropy patches had each entropy source (not just disks) allocate
>>its own state object, and declare its timing "granularity".
>
>Is it that straightforward? In the paper they go through a number of
>stages designed to remove correlated data.  From what I remember of the
>linux prng disk-related stuff it is not that sophisticated.

	It does't matter. Any processing you do on data that may contain randomness 
can only remove the randomness from it. There is no deterministic processing 
method that can increase the randomness of a sample, only concentrate it in 
fewer bits.

>>There's a further problem with disk timing samples that make them less
>>than useful in typical headless server use (ie where it matters): the
>>server does its best to reveal disk latency to clients, easily
>>measurable within the auto-correlating domain of disk turbulence.

>If this is truly a concern, what about having a separate disk used for
>nothing but generating randomness?

	Or just delay by one extra clock cycle if the TSC is odd. This will make the 
LSB of the TSC totally opaque at a negligible cost. One perfect bit per disk 
access is enough for most reasonable applications that really only needed 
cryptographically-secure randomness to begin with.

	DS


