Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTFYGD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 02:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTFYGD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 02:03:57 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:16133 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261994AbTFYGD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 02:03:56 -0400
Date: Wed, 25 Jun 2003 08:18:31 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Jean Tourrilhes <jt@hpl.hp.com>
cc: Neil Brown <neilb@cse.unsw.edu.au>, <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Provide refrigerator support for irda
In-Reply-To: <20030625021042.GA15753@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0306250754150.1634-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003, Jean Tourrilhes wrote:

> On Wed, Jun 25, 2003 at 11:56:53AM +1000, Neil Brown wrote:
> > 
> > Without this patch, kIrDAd prevents my notebook from entering suspend
> > mode.

Are you talking about normal apm or acpi suspend or this swsusp thing?

> 	Wow ! I knew about microwave for 802.11b, but not about
> refrigerator for IrDA.

Inclined to say "me too".

> 	The man for sir_kthread is Martin Diehl. He is much more
> intimate with kernel tasks than me, and he has other sir_dev updates
> in the pipeline.

Admittedly I didn't care about swsusp so far. Given the big fat warning on 
top of Documentation/swsusp.txt I would not even try and i personally 
don't see what I would miss without swsusp.

But of course, if we can make all parties happy, why not.

> > +		if (current->flags & PF_FREEZE)
> > +			refrigerator(PF_IOTHREAD);
> > +

I've tried to find some documentation about this - without success. So I 
have no idea why this might be needed and what it will do. Grepping for 
other kernel threads it looks like most of them use the same two lines.
OTOH the irda thread is very similar to keventd's workqueue which do not
use this. Not sure about the reason.

Well, I'm thinking about making the irda thread using workqueue anyway, in 
which case the issue would either disappear or get shifted to 
kernel/workqueue.c.

For the meantime, I think we should apply this if somebody would explain 
what's going on here.

Martin

