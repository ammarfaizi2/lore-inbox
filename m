Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbTFZO63 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 10:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFZO63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 10:58:29 -0400
Received: from www.13thfloor.at ([212.16.59.250]:43726 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S261846AbTFZO61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 10:58:27 -0400
Date: Thu, 26 Jun 2003 17:12:45 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Edward Tandi <ed@efix.biz>
Cc: Timothy Miller <miller@techsource.com>, linux-kernel@vger.kernel.org
Subject: Re: AMD MP, SMP, Tyan 2466
Message-ID: <20030626151245.GA10006@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
References: <BB1F47F5.17533%kernel@mousebusiness.com> <200306251501.14207.jbriggs@briggsmedia.com> <1056567378.31260.9.camel@wires.home.biz> <3EFA2939.2060005@techsource.com> <1056583075.31265.22.camel@wires.home.biz> <3EFA2F97.5000705@techsource.com> <1056584440.10295.32.camel@wires.home.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1056584440.10295.32.camel@wires.home.biz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 26, 2003 at 12:40:41AM +0100, Edward Tandi wrote:
> On Thu, 2003-06-26 at 00:26, Timothy Miller wrote:
> > Edward Tandi wrote:
> > > On Wed, 2003-06-25 at 23:59, Timothy Miller wrote:
> > >>
> > >>DDR memory works very much like single data rate, except that data is 
> > >>transferred (in whichever direction it's going) on both edges of the 
> > >>clock, thus doubling the transfer rate.  The memory does not switch 
> > >>between reading and writing as you describe it.
> > >>
> > >>I believe registering is for reliability.  Data is transferred one clock 
> > >>cycle later but reduces signal loading.
> > > 
> > > 
> > > Thanks for the clarification. I do not profess to be an expert in the
> > > technology. Two writes or a read+write per clock cycle is close enough
> > > for the purpose of the discussion.
> > > 
> > > The point I was trying to make is that the registers are there to deal
> > > with an SMP race condition of some sort. Athlon MP motherboards fitted
> > > with two processors will not work properly without 'registered' RAM. I
> > > have hard experience of this and it this experience I am sharing with
> > > someone who is seeing the same symptoms.
> > 
> > 
> > It is my understanding that the registered memory requirement has 
> > nothing to do with SMP but instead with the amount of memory you have.
> 
> Except if you go to the beginning of this thread, you will see that the
> machine appears to be running fine in Uniprocessor mode. This concurs
> with my experience. The only difference is that Artur switched the
> kernel whereas I pulled a CPU (and kept the SMP kernel).
> 
> > The more memory chips you have, the greater the signal loading on the 
> > memory bus.  More input drivers means more capacitance which means you 
> > need your output drivers to put out data sooner (relative to the clock 
> > edge, so registered delays by one clock) and stronger (greater drive 
> > strength).

hmm, AFAIK, registered memory has an additional chip/device
called a 'register' (a latch), which buffers/synchronizes the 
data going in and out. this processes, as mentioned, requires 
an additional clock cycle, but in turn improves signal strength
and stability (by re-driving control/data signals) ...

> I only have 2 x 256MB in the box.
> 
> > In an SMP system (besides NUMA), multiple processors will talk to the 
> > same memory through a shared memory controller (like in a Northbridge), 
> > so although there are multiple processors, there is still only one 
> > memory bus.  Pulling off one CPU isn't going to change that situation.
> 
> It appears to do the trick in practise though. How strange.

SMP systems do much more MIO (non sequential memory access)
than UP systems ... so any issues regarding correctness of 
the signalling, will be amplified ...

HTH,
Herbert
 
> Ed-T.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
