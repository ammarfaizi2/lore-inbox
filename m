Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbUEGBO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbUEGBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 21:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUEGBO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 21:14:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:49854 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262190AbUEGBOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 21:14:54 -0400
Subject: Re: Force IDE cache flush on shutdown
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200405061436.58692.bzolnier@elka.pw.edu.pl>
References: <20040506070449.GA12862@devserv.devel.redhat.com>
	 <20040506115220.A14669@infradead.org>
	 <20040506113309.GB16548@devserv.devel.redhat.com>
	 <200405061436.58692.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1083892097.19156.111.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 11:08:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	printk("Flushing cache: %s \n", drive->name);
> > +	ide_cacheflush_p(drive);
> > +	/* give the hardware time to finish; it may return prematurely to cheat
> > */ +	mdelay(300);
> 
> I really don't like it.
> 
> Is this delay arbitrary or you know about such devices?

Agreed... Why not standby the disk instead ? We could re-use the exact
same code path as the Power Management... At least we know that once
standby complete, we are ok (though I noticed that some proprietary
OSes still impose a half a second delay after standby and before
removing power ... broken IDE disks ...)

In fact, I'd like to kill the shutdown() callback in drivers in general
as I think it's just a special case of a PM suspend in fact. The problem
is we need once for all to fix the meaning of the "state" passed to those
callbacks. Once that's done, we can have states for restart, shutdown and
kexec (which wants devices to be put idle -> stop DMA etc...)

Ben.


