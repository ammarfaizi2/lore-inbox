Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVKBCzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVKBCzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 21:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbVKBCzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 21:55:32 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:61337 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932240AbVKBCzc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 21:55:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cuWImGq5rLlqSpAdeMCi7TwORCBFkES50W5TG4zkCkTHM3rLCIuyCiTxf5ea+z4j2rCFysgDBj7lacdQ4OBxvIX+kCN90WexodWJfUIi2Wm8qwMto3V75pamsJYkS6X0YXzZwkhdeAur9Tr8+DWSHRj5XEe85zjzWMk/q1DnXfg=
Message-ID: <cb2ad8b50511011855w41bf4a30l3127cc36dcacb094@mail.gmail.com>
Date: Tue, 1 Nov 2005 21:55:31 -0500
From: Carlos Antunes <cmantunes@gmail.com>
To: Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.14-rt1
Cc: Ingo Molnar <mingo@elte.hu>, Rui Nuno Capela <rncbc@rncbc.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       john stultz <johnstul@us.ibm.com>, Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130899662.12101.2.camel@cmn3.stanford.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
	 <20051030133316.GA11225@elte.hu>
	 <1130876293.6178.6.camel@cmn3.stanford.edu>
	 <1130899662.12101.2.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/05, Fernando Lopez-Lezcano <nando@ccrma.stanford.edu> wrote:
> On Tue, 2005-11-01 at 12:18 -0800, Fernando Lopez-Lezcano wrote:
> > On Sun, 2005-10-30 at 14:33 +0100, Ingo Molnar wrote:
> > > i have released the 2.6.14-rt1 tree, which can be downloaded from the
> > > usual place:
> > >
> > >    http://redhat.com/~mingo/realtime-preempt/
> > >
> > > this release is mainly about ktimer fixes: it updates to the latest
> > > ktimer tree from Thomas Gleixner (which includes John Stultz's latest
> > > GTOD tree), it fixes TSC synchronization problems on HT systems, and
> > > updates the ktimers debugging code.
> > >
> > > These together could fix most of the timer warnings and annoyances
> > > reported for 2.6.14-rc5-rt kernels. In particular the new
> > > TSC-synchronization code could fix SMP systems: the upstream TSC
> > > synchronization method is fine for 1 usec resolution, but it was not
> > > good enough for 1 nsec resolution and likely caused the SMP bugs
> > > reported by Fernando Lopez-Lezcano and Rui Nuno Capela.
> > >
> > > Please re-report any bugs that remain.
> >
> > 2.6.14-rt2 seems to be running fine on my athlon x2 smp system. Apart
> > from some time warp messages when starting up it looks fine so far (this
> > is on fc4).
>
> Actually, after enough time logged in (or maybe just with the kernel
> running without a reboot) I still get the usual Jack warnings:
>
> delay of 5469.000 usecs exceeds estimated spare time of 2641.000;
> restart ...
>

Fernando,

I'm also having some when using SCHED_FIFO and SCHED_RR. When running
several hundred threads, each sleeping on a loop for 20ms, SCHED_OTHER
performs ok with latencies of less than 10ms while with SCHED_FIFO or
SCHED_RR, I see latencies exceeding 1 full second!

Carlos


--
"We hold [...] that all men are created equal; that they are
endowed [...] with certain inalienable rights; that among
these are life, liberty, and the pursuit of happiness"
        -- Thomas Jefferson
