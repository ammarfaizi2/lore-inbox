Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSHAQZr>; Thu, 1 Aug 2002 12:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315628AbSHAQZr>; Thu, 1 Aug 2002 12:25:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19465 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315358AbSHAQZr>; Thu, 1 Aug 2002 12:25:47 -0400
Date: Thu, 1 Aug 2002 09:30:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for
 2.5.29)
In-Reply-To: <1028223041.14865.80.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208010924050.14765-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 Aug 2002, Alan Cox wrote:
>
> For a lot of applications like multimedia you actually want a counting
> of time not any relation to real time except that you can tell how many
> ticks elapse a second.

Absolutely. I think "jiffies64" is fine (as long as is it converted to
some "standard" time-measure like microseconds or nanoseconds so that
people don't have to care about internal kernel state) per se.

The only thing that I think makes it less than wonderful is really the
fact that we cannot give an accurate measure for it. We can _say_ that
what we count in microseconds, but it might turn out that instead of the
perfect 1000000 ticks a second ther would really be 983671 ticks.

A 2% error may not be a big problem for most people, of course. But it
might be a huge problem for others. Those people would have to do their
own re-calibration..

		Linus

