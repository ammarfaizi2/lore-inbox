Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTFFP5F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 11:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbTFFP5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 11:57:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:34514 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261944AbTFFP5E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 11:57:04 -0400
Date: Fri, 6 Jun 2003 18:09:48 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: __check_region in ide code?
In-Reply-To: <1054913005.17190.6.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0306061802500.13809-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 6 Jun 2003, Alan Cox wrote:

> On Gwe, 2003-06-06 at 09:56, Bartlomiej Zolnierkiewicz wrote:
> > > 	There's nothing inherently *wrong* with check_region, it's
> > > just deprecated to trap the old (now racy) idiom of "if
> > > (check_region(xx)) reserve_region(xx)".  There's no reason not to
> > > introduce a probe_region if IDE really wants it.
> >
> > And ide-probe.c does exactly this racy stuff.
> >
> > I did patch to convert it to request_region() some time ago,
> > I just need to double check it and submit.
>
> request_region at that point doesn't actually help you. For PIO devices
> its too late if you are handling PCMCIA, for PCI devices its too late
> because you want to own the PCI device properly, for MMIO its completely
> broken (all the mem region stuff in 2.5)

Yes, I am aware of that.
Patch is only to fix ide-probe.c (request_region() after check_region())
not whole ide resource allocation braindamage.

> The only way I can see to fix it properly is to provide ide helpers
> for resource allocation that are used by the drivers when needed.

Exactly, it is already on my todo.
--
Bartlomiej

