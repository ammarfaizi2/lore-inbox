Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422626AbWJPP0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422626AbWJPP0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422630AbWJPP0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:26:00 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:2832 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1422626AbWJPPZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:25:59 -0400
Date: Mon, 16 Oct 2006 17:26:31 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
Message-ID: <20061016172631.47d3eb70@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <Pine.LNX.4.44L0.0610161040570.7103-100000@iolanthe.rowland.org>
References: <20061016125613.16c9f667@gondolin.boeblingen.de.ibm.com>
	<Pine.LNX.4.44L0.0610161040570.7103-100000@iolanthe.rowland.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 10:59:28 -0400 (EDT),
Alan Stern <stern@rowland.harvard.edu> wrote:

> That's not quite true.  You could acquire dev->parent->sem always, just to
> be certain.  

But dev->parent->sem wouldn't be taken in the non-multithreaded path,
so we would change the semantics.

> However USB shouldn't use this form of multithreaded probing
> in any case; it should instead use multiple threads for khubd.

OK, so usb shouldn't request multithreaded probe.

> >  but
> > that still results in bus->remove being called without a prior ->probe
> > (but not drv->probe since dev->driver is not set at that time).
> 
> How so?  We shouldn't call bus->remove if a driver isn't bound.

Eh, yes. I was confused :)

> Some other things were left out of the patch.  Since we can no longer know 
> whether any drivers will get bound at all, device_attach() should now 
> return void.

But device_bind_driver() may still return an error, if creating the
links failed.

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
