Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUGMUAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUGMUAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUGMUAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 16:00:42 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:29676 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265772AbUGMUAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 16:00:37 -0400
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an
	afterthought?
From: Lee Revell <rlrevell@joe-job.com>
To: Bill Huey <bhuey@lnxw.com>
Cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       linux-kernel@vger.kernel.org, albert@users.sourceforge.net
In-Reply-To: <20040713191224.GA22237@nietzsche.lynx.com>
References: <20040712172458.2659db52.akpm@osdl.org>
	 <008501c468d2$405d8c70$161b14ac@boromir>
	 <20040713191224.GA22237@nietzsche.lynx.com>
Content-Type: text/plain
Message-Id: <1089748849.22026.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 13 Jul 2004 16:00:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-13 at 15:12, Bill Huey wrote:
> On Tue, Jul 13, 2004 at 01:09:28PM +0100, Martijn Sipkema wrote:
> > [...]
> > > Please double-check that there are no priority inversion problems and that
> > > the application is correctly setting the scheduling policy and that it is
> > > mlocking everything appropriately.
> > 
> > I don't think it is currently possible to have cooperating threads with
> > different priorities without priority inversion when using a mutex to
> > serialize access to shared data; and using a mutex is in fact the only portable
> > way to do that...
> > 
> > Thus, the fact that Linux does not support protocols to prevent priority
> > inversion (please correct me if I am wrong) kind of suggests that supporting
> > realtime applications is not considered very important.
> 
> Any use of an explicit or implied blocking mutex across threads with differing
> priorities can results in priority inversion problems. The real problem, however,
> is contention. If you get rid of the contention in a certain critical section,
> you then also get rid of latency in the system. They are one and the same problem.
> 
> > It is often heard in the Linux audio community that mutexes are not realtime
> > safe and a lock-free ringbuffer should be used instead. Using such a lock-free
> > ringbuffer requires non-standard atomic integer operations and does not
> > guarantee memory synchronization (and should probably not perform
> > significantly better than a decent mutex implementation) and is thus not
> > portable.
> 
> It's to decouple the system from various time related problems with jitter.
> It's critical to use this since the nature of Linus is so temporally coarse
> that these techniques must be used to "smooth" over latency problems in the
> Linux kernel.
> 
> I personally would love to see these audio applications run on a first-class
> basis under Linux. Unfortunately, that won't happen until it gets near real
> time support prevasively through the kernel just like in SGI's IRIX. Multimedia
> applications really need to be under a hard real time system with special
> scheduler support so that CPU resources, IO channels can be throttled.
> 

I don't think invoking IRIX is going to get us a lot of sympathy on
LKML.  It is widely reviled.  BEOS is probably a better example.

Just my $0.02.

Lee

