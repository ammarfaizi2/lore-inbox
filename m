Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVLaBam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVLaBam (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 20:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVLaBam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 20:30:42 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59328 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932079AbVLaBal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 20:30:41 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@redhat.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <5bdc1c8b0512301659m5d4431bu6915dbe10d9aaa79@mail.gmail.com>
References: <1135726300.22744.25.camel@mindpipe>
	 <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com>
	 <20051229101736.GA2560@elte.hu> <1135887072.6804.9.camel@mindpipe>
	 <1135887966.6804.11.camel@mindpipe> <20051229202848.GC29546@elte.hu>
	 <1135908980.4568.10.camel@mindpipe> <20051230080032.GA26152@elte.hu>
	 <1135990270.31111.46.camel@mindpipe>
	 <5bdc1c8b0512301659m5d4431bu6915dbe10d9aaa79@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 20:30:38 -0500
Message-Id: <1135992638.31111.64.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 16:59 -0800, Mark Knecht wrote:
> I've noted for awhile that on my AMD64 machine that has xrun issues
> that at least annecdotally it has always seemed that the network
> interface was somehow involved. I wonder if this may turn out to be
> true? 

Yes, it probably is.  Since at least 2.6.14 almost all of the 1ms+
latencies left in the kernel are due to long running network softirqs -
thanks to lots of work by Ingo and others there are almost no long-held
spinlocks left.  So I would certainly expect audio underruns to
correspond to heavy network activity.

I believe that softirqs usually run on the processor that they were
raised on so if you have an SMP system you could test this by locking
all interrupt handling to one processor and running JACK on the other
and see if your xruns decrease.

Lee

