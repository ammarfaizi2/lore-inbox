Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUA0ROV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 12:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUA0ROV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 12:14:21 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:7625 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S265390AbUA0RNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 12:13:11 -0500
Subject: Re: 2.6.1 dual xeon
From: Alexander Nyberg <alexn@telia.com>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040127073801.GB9708@favonius>
References: <20040124203646.A8709@animx.eu.org>
	 <1074995006.5246.1.camel@localhost> <20040125083712.A9318@animx.eu.org>
	 <20040127073801.GB9708@favonius>
Content-Type: text/plain
Message-Id: <1075223587.1173.5.camel@llhosts>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 27 Jan 2004 18:13:07 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-01-27 at 08:38, Sander wrote:
> Wakko Warner wrote (ao):
> > > > I recently aquired a dual xeon system. HT is enabled which shows
> > > > up as 4 cpus. I noticed that all interrupts are on CPU0. Can
> > > > anyone tell me why this is?
> > > 
> > > The APIC needs to be programmed to deliver interrupts to certain
> > > processors.
> > > 
> > > In 2.6, this is done in user-space via a program called irqbalance:
> > 
> > Thanks, working great. (Debian by the way)
> 
> Ehm, IIRC the "all interrupts are on CPU0" is how it is supposed to work
> with a 2.6 kernel? The interrupts should spread if you have _a_lot_ of
> them. This gives better performance than spreading the interrupts. Did I
> read this on the list, or am I completely wrong here?

Apparently it was way especially better performance wise to have
interrupts that hit often (ethernet cards ie.) on the same cpu.

But I can't see a reason for not dividing the different interrupt on
different cpu's and letting them stay put. Maybe if you keep all
interrupts on the same cpu the cache on the other ones will not have to
be flushed often, which would be a good thing.

How would it be to maybe remove all interrupts from a cpu (except
between cpu's) and have a few cpu's merely working with data and one "in
control". Bad idea I guess as I haven't seen any such work.

Alex

