Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288124AbSAQCpX>; Wed, 16 Jan 2002 21:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288127AbSAQCpM>; Wed, 16 Jan 2002 21:45:12 -0500
Received: from apogee.whack.org ([167.216.255.203]:48639 "EHLO mx1.whack.org")
	by vger.kernel.org with ESMTP id <S288124AbSAQCpG>;
	Wed, 16 Jan 2002 21:45:06 -0500
Date: Wed, 16 Jan 2002 18:45:02 -0800 (PST)
From: Wilson Yeung <wilson@whack.org>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: hires timestamps for netif_rx()
In-Reply-To: <20020116.170852.91311984.davem@redhat.com>
Message-ID: <Pine.GSO.4.40.0201161827510.28457-100000@apogee.whack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Taking linux-net out of the distribution.

On Wed, 16 Jan 2002, David S. Miller wrote:

>    From: Wilson Yeung <wilson@whack.org>
>    Date: Wed, 16 Jan 2002 17:03:58 -0800 (PST)
>
>    The discreprency is that get_fast_time() returns the current value of
>    xtime, while do_gettimeofday() may actually calculate the time and
>    consider both xtime and the jiffies.
>
> Look at the x86 implementation of do_fast_time, it equals
> do_gettimeofday() when TSC is present which is the only time
> that do_gettimeofday is going to be more accurate than xtime.

That's interesting, because when I call do_gettimeofday() instead of
get_fast_time(), I get different kinds of results that imply that these
are not equivalent.  I'm running the kernel on a PIII.

I'm looking at arch/i386/kernel/time.c, and I see the definition
you're talking about.  I'm also looking at kernel/time.c, and I'm not sure
how these things are interacting yet.

Anyway...

I did a ping flood from a host on the LAN, and ran tcpdump.

Here is a sequence of timestamps when netif_rx() uses do_gettimeofday()
directly:

18:26:01.658704
18:26:01.658844
18:26:01.658851
18:26:01.658992
18:26:01.658998

Here is a sequence of timestamps when netif_rx() uses get_fast_time():

18:40:17.614165
18:40:17.614165
18:40:17.614165
18:40:17.614165
18:40:17.614165

Notice that all the timestamps are the same, which led me to believe that
xtime was being gotten directly.

But if they're defined to be the same, then my call to do_gettimeofday()
should have gotten similar results.

Wilson

