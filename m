Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSHAQFX>; Thu, 1 Aug 2002 12:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSHAQFW>; Thu, 1 Aug 2002 12:05:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10504 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315540AbSHAQFW>; Thu, 1 Aug 2002 12:05:22 -0400
Date: Thu, 1 Aug 2002 09:09:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Pavel Machek <pavel@elf.ucw.cz>,
       Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for
 2.5.29)
In-Reply-To: <3D494CFF.245675E@nortelnetworks.com>
Message-ID: <Pine.LNX.4.44.0208010903460.14537-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Aug 2002, Chris Friesen wrote:
>
> Now if we had a constant monotonic source of time--say 64-bit nanoseconds since
> boot--this wouldn't be a problem.

Well, we do have such a monotonic time sequence already, and that's the
one that the kernel always uses internally.

It's called "jiffies64".

However, "jiffies" are not really real time, they are only a "reasonable
abstraction thereof", and while they imply ordering ("time_after()" works
fine inside the kernel), they do _not_ imply real time.

In other words, there is no way to move from time -> jiffies and back.

But we could certainly export jiffies64 as a "nanosecond-like" thing. All
it takes is one 32x64-bit multiply. It won't be "true nanoseconds", but it
will be a "reasonable approximation" (ie the rate may be off by several
percentage points, since nothing is correcting for it. But the "no
correction" is part of the _advantage_ too).

		Linus

