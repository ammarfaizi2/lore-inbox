Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272322AbTHEKTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272374AbTHEKTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:19:21 -0400
Received: from tudela.mad.ttd.net ([194.179.1.233]:50169 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP id S272322AbTHEKTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:19:19 -0400
Date: Tue, 5 Aug 2003 12:18:41 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] airo driver: fix races, oops, etc..
In-Reply-To: <1060076891.615.57.camel@gaston>
Message-ID: <Pine.SOL.4.30.0308051202580.2746-100000@tudela.mad.ttd.net>
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

You're right. In my PC, with just one CPU, it doesn't make a difference
:-)

Anyway, I took a look at the workqueue code and looks like I only need a
"create_workqueue()" that only creates one thread. This is what
create_workqueue_thread() does, but it's static. Oh, well. I can also
destroy all threads but one or, as you say, write my own code. I have to
think about it....

Javier Achirica



