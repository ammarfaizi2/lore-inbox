Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbTFJXmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbTFJXmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:42:25 -0400
Received: from mail.ithnet.com ([217.64.64.8]:3345 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261989AbTFJXmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:42:21 -0400
Date: Wed, 11 Jun 2003 01:55:34 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030611015534.42a5e177.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.50.0306101412350.19137-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
	<20030608134901.363ebe42.skraw@ithnet.com>
	<20030609171011.7f940545.skraw@ithnet.com>
	<Pine.LNX.4.50.0306092135000.19137-100000@montezuma.mastecende.com>
	<20030610123015.4242716e.skraw@ithnet.com>
	<Pine.LNX.4.50.0306100847580.19137-100000@montezuma.mastecende.com>
	<20030610153815.57f7a563.skraw@ithnet.com>
	<Pine.LNX.4.50.0306100949040.19137-100000@montezuma.mastecende.com>
	<20030610194429.615c0e93.skraw@ithnet.com>
	<Pine.LNX.4.50.0306101412350.19137-100000@montezuma.mastecende.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jun 2003 14:15:58 -0400 (EDT)
Zwane Mwaikambo <zwane@linuxpower.ca> wrote:

> On Tue, 10 Jun 2003, Stephan von Krawczynski wrote:
> 
> > The controller used is the second aic7xxx. The 31 interrupts on CPU0 have
> > occured before the test. This setup fails during verify (data corruption).
> > 
> > I would say that the interrupt code of the aic in itself is therefore ok
> > with SMP. If it were a SMP race condition inside the interrupt routine this
> > test should have been ok (as only one CPU is used).
> 
> Thanks for verifying this, at least i know the problem isn't with 
> interrupt routing in your specific case.
> 
> 	Zwane

I guess your comment is a bit ahead of my tests. I just completed the test with
rc7+aic20030603 SMP, apic and maxcpus=1. It fails.
This means that although there is only one CPU used through the whole kernel
the data corruption occurs.
I would therefore conclude that the corruption is only possible if in fact the
standard code path is flaky in terms of data completeness per request.
Something like a broken synchronous action, a read request coming back
completed although it is in fact still running or the like.
May also be a misinterpretation of a kind of an "action completed" interrupt.
Or something like one interrupt for multiple running actions with a mixup of
the various causes.
To make sure it is not a problem in the SMP code path through the driver I have
to check a UP kernel with apic support enabled. I will do this tommorrow.
If this is ok then things are simple, because its nailed down to the SMP code
path without a concurrency cause.
Lets see ...

Regards,
Stephan


