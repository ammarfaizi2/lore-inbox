Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbUBUQSO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 11:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUBUQSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 11:18:14 -0500
Received: from mail.shareable.org ([81.29.64.88]:36225 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261167AbUBUQSM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 11:18:12 -0500
Date: Sat, 21 Feb 2004 16:18:06 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][4/4] poll()/select() timeout behavior
Message-ID: <20040221161806.GA15991@mail.shareable.org>
References: <20040220210452.GE1912@ti19.telemetry-investments.com> <20040220201328.609fe4e2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220201328.609fe4e2.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > Unfortunately, fixing the fencepost error places a hard lower limit of
> > 1/HZ on the time slept, and increases the average minimum sleep time
> > threefold, from 1/(2*HZ) jiffy to 3/(2*HZ).
> 
> I'm inclined to live with the current behaviour rather than
> risk breaking existing apps.

select's behaviour is fun when trying to do smooth game animation on
X...  Humans are pretty good at noticing jitter in the animation of a
moving object.  Years ago, I ended up writing an estimator which
deduced the granularity and rounding of select(), so that I could then
_reduce_ the timeout given to select() followed by a busy wait up to
the desired time.  That was needed for SunOS.  Nowadays with 1kHz
jiffies it's not a problem, but not all systems have that.

So, I agree, the change might break current apps.

If the current behaviour is retained, shouldn't select(), poll() and
epoll() at least agree on the same rounding direction?  poll/epoll
should be suitable as replacements for select, but I don't think they
are timing-wise.

(Btw, Bill, did you take a look at epoll too?)

-- Jamie
