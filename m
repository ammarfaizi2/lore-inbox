Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275211AbTHGHuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 03:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275213AbTHGHuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 03:50:35 -0400
Received: from tudela.mad.ttd.net ([194.179.1.233]:35050 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP id S275211AbTHGHue
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 03:50:34 -0400
Date: Thu, 7 Aug 2003 09:49:43 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] airo driver: fix races, oops, etc..
In-Reply-To: <1060076891.615.57.camel@gaston>
Message-ID: <Pine.SOL.4.30.0308070946380.22832-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 5 Aug 2003, Benjamin Herrenschmidt wrote:

> On Tue, 2003-08-05 at 10:53, Javier Achirica wrote:
> > I've integrated this patch in my code. I've done a major change: Instead
> > of using schedule_delayed_work(), I create a new workqueue and use
> > queue_work() on that queue. As all tasks sleep in the same lock, I can
> > queue them there and make them sleep instead of requeueing them.
> >
> > I haven't sent them to Jeff yet, as I want to do more testing. If you want
> > to help testing them, please tell me.
>
> Well... creating a work queue means you create one thread per CPU, that
> sucks a bit don't think ? Maybe using a single thread for the driver
> with your own queuing primitives...

I've been studying the problem for a while and I've implemented a solution
using a single kernel thread and a wait queue for synchronization. I've
tested it and looks like it works fine. It can be used both in 2.4
and 2.6 kernels. Before submitting a patch with it I'd like someone with
experience in this kind of code to take a look at it just in case I'm
doing something dumb. Jeff? :-)

Javier Achirica

