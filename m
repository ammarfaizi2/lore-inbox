Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTA1Vam>; Tue, 28 Jan 2003 16:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTA1Vam>; Tue, 28 Jan 2003 16:30:42 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:17122 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S261368AbTA1Val>;
	Tue, 28 Jan 2003 16:30:41 -0500
Date: Tue, 28 Jan 2003 21:39:54 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: Davide Libenzi <davidel@xmailserver.org>,
       "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Lennert Buytenhek <buytenh@math.leidenuniv.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bug in select() (was Re: {sys_,/dev/}epoll waiting timeout)
Message-ID: <20030128213954.GB29036@bjl1.asuk.net>
References: <Pine.LNX.4.50.0301230544320.820-100000@blue1.dev.mcafeelabs.com> <20030123154304.GA7665@bjl1.asuk.net> <20030123172734.GA2490@mark.mielke.cc> <20030123182831.GA8184@bjl1.asuk.net> <20030123204056.GC2490@mark.mielke.cc> <20030123221858.GA8581@bjl1.asuk.net> <20030127162717.A1283@ti19> <Pine.LNX.4.50.0301271427320.1930-100000@blue1.dev.mcafeelabs.com> <20030128094500.GA26202@bjl1.asuk.net> <20030128105201.GA1243@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030128105201.GA1243@mark.mielke.cc>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Mielke wrote:
> On Tue, Jan 28, 2003 at 09:45:00AM +0000, Jamie Lokier wrote:
> > Davide Libenzi wrote:
> > > ( if Tms > 0 )
> > Which is unfortunate, because that doesn't allow for a value of Tms ==
> > 0 which is needed when you want to sleep and wake up on every jiffie
> > on systems where HZ >= 1000.  Tms == 0 is taken already, to mean do
> > not wait at all.
> 
> To some degree, isn't this the equivalent of yield()?

No.  If you want a process to wake every HZ tick, do a little work and
then sleep again, yield() won't do that.

If HZ >= 1000, you simply can't use Linux poll() to do that; you have
to use select().  (Or epoll_wait()).

Even if select() is changed to do double-rounding-up like poll(), it
will still do this because select() times have microsecond
granularity.

-- Jamie

