Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276899AbRJHOFR>; Mon, 8 Oct 2001 10:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276901AbRJHOFH>; Mon, 8 Oct 2001 10:05:07 -0400
Received: from [216.191.240.114] ([216.191.240.114]:27525 "EHLO
	shell.cyberus.ca") by vger.kernel.org with ESMTP id <S276899AbRJHOEu>;
	Mon, 8 Oct 2001 10:04:50 -0400
Date: Mon, 8 Oct 2001 09:58:22 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: <kuznet@ms2.inr.ac.ru>
cc: Andreas Dilger <adilger@turbolabs.com>, <Robert.Olsson@data.slu.se>,
        <mingo@elte.hu>, <linux-kernel@vger.kernel.org>, <bcrl@redhat.com>,
        <netdev@oss.sgi.com>, <torvalds@transmeta.com>,
        <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <200110051917.XAA23007@ms2.inr.ac.ru>
Message-ID: <Pine.GSO.4.30.0110080948330.5473-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Oct 2001 kuznet@ms2.inr.ac.ru wrote:

> Hello!
>
> > One question which I have is why would you ever want to continue polling
> > if there is no work to be done?  Is it a tradeoff between the amount of
> > time to handle an IRQ vs. the time to do a poll?
>
> Yes. IRQ even taken alone eat non-trivial amount of resources.
>
> Actually, I remember Jamal worked with machine, which had
> no io-apic and only irq ack/mask/unmask eated >15% of cpu there. :-)
>

This was Robert actually; conclusion was Interupts are very expensive. If
we can get rid of as many of them as possible, we are getting a side
benefit. I cant find the old data, but Robert has some data over here:
http://robur.slu.se/Linux/net-development/experiments/010301



> "some hysteresis" is right word. This loop is an experiment with still
> unknown result yet. Originally, Jamal proposed to spin several times.
> I killed this.

It was a good idea you killed it, now that i think in retrospect,
The solution is much cleaner without it.

> Robert proposed to check inifinite loop yet. (Note,
> jiffies check is just a way to get rid of completely idle devices,
> one jiffie is enough lonf time to be considered infinite).
>

In my opinion we really dont need this. I did some quick testing, with and
without it and i dont see any differences.

cheers,
jamal

