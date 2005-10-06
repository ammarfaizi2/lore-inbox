Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbVJFUif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbVJFUif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbVJFUif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:38:35 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:8026 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751351AbVJFUie convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:38:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n40X09SlhT5WxEKzv4dkKqTZjvu2pB+zM+Y8vXwhBoOnao8wKVlzmtTSIueKdP805KgT43nMgxgZGKHCuXMRjepHrEwOdw8qp0jJScER0erzQKLujZtcAh4McIgNDRNomTfug4UETblO5OCWT6W7svfSCxmu5EENly1p4l+u0sU=
Message-ID: <5bdc1c8b0510061338r41e0b51ds2efd435a591d953e@mail.gmail.com>
Date: Thu, 6 Oct 2005 13:38:33 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt10 - xruns & config questions
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510061152o686c5774x2d0514a1f1b4e463@mail.gmail.com>
	 <20051006195242.GA15448@elte.hu>
	 <5bdc1c8b0510061307saf22655y26dd1e608b33a40c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 10/6/05, Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Mark Knecht <markknecht@gmail.com> wrote:
> >
> > >    I am still getting a few xruns even after raising Jack's priority
> > > level to 80. I am wondering whether it's fair to report these when I
> > > have CONFIG_DEBUG_PREEMPT set?
> >
> > >   4559  78     38 [IRQ 58]
> >
> > >   58:     257570   IO-APIC-level  hdsp
> >
> > IRQ 58 is your audio interrupt, right? You should raise that one to prio
> > 80 too. (via chrt)
> >
> > > Since my NIC is getting a higher priority than both my sound card and
> > > my 1394 audio drives (IRQ217 vs. IRQ58/IRQ66) I assume that network
> > > activity might possibly sometimes cause a problem? Or is this not
> > > true?
> >
> > yeah, that could be the case.
> >

>
>    Can you suggest how I might be able to do this at boot time?

Apologies for answering myself...

I found an old conversation that answered this, at least when I'm
logged in as root. Hopefully it will work at boot time also:

chrt -f -p 80  `pidof "IRQ 58"`

I noted that the default chrt command changed the IRQ process from
SCHED_FIFO to SCHED_RR so I assume I really should leave it at
SCHED_FIFO?

Thanks,
Mark
