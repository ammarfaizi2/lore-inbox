Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751555AbVJSGsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbVJSGsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 02:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbVJSGsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 02:48:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:10424 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751553AbVJSGsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 02:48:12 -0400
Date: Wed, 19 Oct 2005 02:48:02 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Stephen Hemminger <shemminger@osdl.org>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc4-rt6, skge vs. sk98lin
In-Reply-To: <20051018095028.4b78dbb2@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0510190247340.20634@localhost.localdomain>
References: <1129599910.5031.3.camel@cmn3.stanford.edu> <435456A1.6020208@pobox.com>
 <1129600953.5031.6.camel@cmn3.stanford.edu> <20051018095028.4b78dbb2@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Oct 2005, Stephen Hemminger wrote:

> On Mon, 17 Oct 2005 19:02:33 -0700
> Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
>
> > On Mon, 2005-10-17 at 21:57 -0400, Jeff Garzik wrote:
> > > Fernando Lopez-Lezcano wrote:
> > > > I'm running 2.6.14-rc4-rt6 and trying the skge driver instead of the
> > > > sk98lin and I'm getting these warnings in my logs (this is probably not
> > > > related to the rt patch):
> > > >
> > > >   network driver disabled interrupts: skge_xmit_frame+0x0/0x320 [skge]
> > > >
> > > > No other relevant messages around that I can see. Is this a bug? Any
> > > > information I could supply to help debug it?
> > >
> > > This is a bogus message added by the -rt patch.  It is not a bug.
> > >
> > > The trylock scheme in some newer net drivers (grep for NETDEV_TX_LOCKED)
> > > uses local_irq_save/restore because there is no
> > > spin_trylock_irqsave/spin_trylock_failed_irqrestore API.
> >
> > Would it have any undesirable effect to find this and comment it out?
> > There are quite a few messages in the logs. Knowing it is not a bug I
> > may try the driver a bit more (I rebooted into sk98lin just in case ;-)
> >
> > Thanks for the info.
> > -- Fernando
>
> Or get the -rt folks to come with a better way.
>

Like adding a spin_trylock_irqsave/spin_trylock_failed_irqrestore API?

-- Steve
