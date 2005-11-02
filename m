Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVKBD1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVKBD1A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 22:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKBD1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 22:27:00 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:13135 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750932AbVKBD07 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 22:26:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jxphB3MdXiyb5hsSf0gUQyQCjxYZxwNS3P1ZjjwTM+FYTMKTyf1sXiav1oFCtHoglLY25F8PlqwEjXPkyUvdFmQxRVFiqPcch3BKgb7tuvli2qEjDslQDoyeMFwTZIkSNEZtOkSYciiMkl+o9I0Ryb/lSqvrRsREx5mMNHQ6zDk=
Message-ID: <cb2ad8b50511011926w11116fdasd22227ca249f18fc@mail.gmail.com>
Date: Tue, 1 Nov 2005 22:26:58 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.14-rt1
Cc: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130900716.29788.22.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
	 <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
	 <1130900716.29788.22.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 2005-11-01 at 21:55 -0500, Carlos Antunes wrote:
>
> >
> > Fernando,
> >
> > I'm also having some when using SCHED_FIFO and SCHED_RR. When running
> > several hundred threads, each sleeping on a loop for 20ms, SCHED_OTHER
> > performs ok with latencies of less than 10ms while with SCHED_FIFO or
> > SCHED_RR, I see latencies exceeding 1 full second!
>
> Are you saying that you have several hundred threads in SCHED_FIFO or
> SCHED_RR? Or is just Jack as that.
>

It's a simple program I put together to test wakeup latency. Each
thread basically sleeps for 20ms, wakes up and executes a couple of
instructions and goes back to sleep for another 20ms. Multiply this by
a thousand. What I found out is that, inthis situation, and using
realtime-preempt, SCHED_OTHER offers 3 orders of magnitude less
latency than SCHED_FIFO or SCHED_RR. Which suggests to me there is
something fishy going on.

Carlos


--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
