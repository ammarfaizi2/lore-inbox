Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267855AbUHKH2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267855AbUHKH2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 03:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267973AbUHKH2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 03:28:18 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:12972 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S267855AbUHKH2Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 03:28:16 -0400
From: David Brownell <david-b@pacbell.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: uhci-hcd oops with 2.4.27/ intel D845GLVA
Date: Wed, 11 Aug 2004 00:16:43 -0700
User-Agent: KMail/1.6.2
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, spam99@2thebatcave.com, <km@westend.com>
References: <1092142777.1042.30.camel@bart.intern> <200408102137.26004.david-b@pacbell.net> <20040810220249.5c4913ec@lembas.zaitcev.lan>
In-Reply-To: <20040810220249.5c4913ec@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408110016.43095.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 10:02 pm, Pete Zaitcev wrote:
> On Tue, 10 Aug 2004 21:37:26 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > > First, it fixes the oops in the scan_async.
> > 
> > That's a NOP, ehci->async must never be null.
> 
> This is news. I received this patch FROM YOU. And I shipped it with
> RHEL3 U3. And now it's a nop? What gives?! By the way, it's verified
> to fix the oops when handoff fails.

I see what was going on -- that patch somehow got lost.  It
normally never IS null, except on an exotic fault path during
initialization.  Which of course nobody ever sees ... right :)

- Dave


> > > +++ linux-2.4.21-17.EL-usb1/drivers/usb/host/ehci-hcd.c	2004-07-30 
16:21:12.000000000 -0700
> > > @@ -547,7 +547,8 @@
> > >  
> > >  	/* root hub is shut down separately (first, when possible) */
> > >  	spin_lock_irq (&ehci->lock);
> > > -	ehci_work (ehci, NULL);
> > > +	if (ehci->async)
> > > +		ehci_work (ehci, NULL);
> > >  	spin_unlock_irq (&ehci->lock);
> 
> Please look at this:
>  http://www.ussg.iu.edu/hypermail/linux/kernel/0404.2/0156.html
> 
> -- Pete
> 
> P.S. Sorry to get your name wrong, David.
> 
