Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264948AbSJ3W4r>; Wed, 30 Oct 2002 17:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264951AbSJ3W4q>; Wed, 30 Oct 2002 17:56:46 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:29614 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S264948AbSJ3W4q>;
	Wed, 30 Oct 2002 17:56:46 -0500
Date: Wed, 30 Oct 2002 23:01:59 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: John Gardiner Myers <jgmyers@netscape.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net
Subject: Re: and nicer too - Re: [PATCH] epoll more scalable than poll
Message-ID: <20021030230159.GB25231@bjl1.asuk.net>
References: <Pine.LNX.4.44.0210291237240.1457-100000@blue1.dev.mcafeelabs.com> <3DBF426B.6050208@netscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DBF426B.6050208@netscape.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
> I am uncomfortable with the way the epoll code adds its own set of 
> notification hooks into the socket and pipe code.  Much better would be 
> to extend the existing set of notification hooks, like the aio poll code 
> does.

Fwiw, I agree with the above (I'm having a think about it).

I also agree with criticisms that epoll should test and send an event
on registration, but only _if_ the test is cheap.  Nothing to do with
correctness (I like the edge semantics as they are), but because
delivering one event is so infinitesimally low impact with epoll that
it's preferable to doing a single speculative read/write/whatever.

Regarding the effectiveness of the optimisation, I'd guess that quite
a lot of incoming connections do not come with initial data in the
short scheduling time after a SYN (unless it's on a LAN).  I don't
know this for sure though.

-- Jamie
 
