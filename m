Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270097AbTGUNcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 09:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270098AbTGUNcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 09:32:18 -0400
Received: from tudela.mad.ttd.net ([194.179.1.233]:35237 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP id S270097AbTGUNcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 09:32:14 -0400
Date: Mon, 21 Jul 2003 15:46:36 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Christoph Hellwig <hch@infradead.org>
cc: Daniel Ritz <daniel.ritz@gmx.ch>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Mike Kershaw <dragorn@melchior.nerv-un.net>
Subject: Re: [PATCH 2.5] fixes for airo.c
In-Reply-To: <20030721133757.A24319@infradead.org>
Message-ID: <Pine.SOL.4.30.0307211543010.25549-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Jul 2003, Christoph Hellwig wrote:

> On Mon, Jul 21, 2003 at 01:00:54PM +0200, Javier Achirica wrote:
> >
> > Daniel,
> >
> > Thank you for your patch. Some comments about it:
> >
> > - I'd rather fix whatever is broken in the current code than going back to
> > spinlocks, as they increase latency and reduce concurrency. In any case,
> > please check your code.
>
> In general we prefer spinlocks in linux for drivers unless there's a
> very good reason against it.  If you have latency or concurrency problems
> it seems you have problems with your algorithms or the length of your
> critical sections.

I don't think it is a problem with the algorithms. It is, of course, with
the length of the critical sections, due to the fact that the Aironet
firmware needs serialized commands and some of them take a long time to
execute. To ensure serialization, a spinlock was used, but in that case it
could be hold for hundreds of milliseconds in some cases (waiting for the
command to finish).

If you have any suggestion about how to better deal with that issue, I'd
be happy to hear it.

Javier Achirica

