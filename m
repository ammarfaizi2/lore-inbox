Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261666AbRFBVrN>; Sat, 2 Jun 2001 17:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbRFBVrE>; Sat, 2 Jun 2001 17:47:04 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:37641 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261666AbRFBVqu>;
	Sat, 2 Jun 2001 17:46:50 -0400
Date: Sat, 2 Jun 2001 23:46:40 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: lost@l-w.net
Cc: Andries.Brouwer@cwi.nl, dean-list-linux-kernel@arctic.org,
        jcwren@jcwren.com, linux-kernel@vger.kernel.org
Subject: Re: select() - Linux vs. BSD
Message-ID: <20010602234640.A1290@pcep-jamie.cern.ch>
In-Reply-To: <UTC200106010816.KAA162273.aeb@vlet.cwi.nl> <Pine.LNX.4.21.0106011030330.10964-100000@skaro.l-w.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106011030330.10964-100000@skaro.l-w.net>; from lost@l-w.net on Fri, Jun 01, 2001 at 10:38:15AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lost@l-w.net wrote:
> Of course, not looking at the sets upon a zero return is a fairly obvious
> optimization as there is little point in doing so.

No; a fairly obvious optimisation is to avoid calling FD_ZERO if you
can clear the bits individually when you test them.

When you examine the sets, you can clear each bit that you examine and
then you know you have a zero set.  Then you can set only the relevant
bits for the next call to select().

If you can't rely on the sets being cleared on a timeout, then you
will have to call FD_ZERO in that case, or you will have to go through
the list of descriptors and clear them individually.  (This can be
avoided but it means keeping track of state between successive calls
to select()).  This is contrary to the non-timeout case, where you
stop checking bits when you have counted N of them set.

So you see, there is a handy optimisation if you can assume the sets
are zeroed on timeout.

-- Jamie
