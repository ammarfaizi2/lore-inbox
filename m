Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267940AbUHKFC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267940AbUHKFC7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 01:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267942AbUHKFC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 01:02:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57295 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267940AbUHKFC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 01:02:57 -0400
Date: Tue, 10 Aug 2004 22:02:49 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Brownell <david-b@pacbell.net>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, spam99@2thebatcave.com, <km@westend.com>,
       zaitcev@redhat.com
Subject: Re: uhci-hcd oops with 2.4.27/ intel D845GLVA
Message-Id: <20040810220249.5c4913ec@lembas.zaitcev.lan>
In-Reply-To: <200408102137.26004.david-b@pacbell.net>
References: <1092142777.1042.30.camel@bart.intern>
	<mailman.1092163681.21436.linux-kernel2news@redhat.com>
	<20040810135409.44d31d1e@lembas.zaitcev.lan>
	<200408102137.26004.david-b@pacbell.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 21:37:26 -0700
David Brownell <david-b@pacbell.net> wrote:

> > First, it fixes the oops in the scan_async.
> 
> That's a NOP, ehci->async must never be null.

This is news. I received this patch FROM YOU. And I shipped it with
RHEL3 U3. And now it's a nop? What gives?! By the way, it's verified
to fix the oops when handoff fails.

> > +++ linux-2.4.21-17.EL-usb1/drivers/usb/host/ehci-hcd.c	2004-07-30 16:21:12.000000000 -0700
> > @@ -547,7 +547,8 @@
> >  
> >  	/* root hub is shut down separately (first, when possible) */
> >  	spin_lock_irq (&ehci->lock);
> > -	ehci_work (ehci, NULL);
> > +	if (ehci->async)
> > +		ehci_work (ehci, NULL);
> >  	spin_unlock_irq (&ehci->lock);

Please look at this:
 http://www.ussg.iu.edu/hypermail/linux/kernel/0404.2/0156.html

-- Pete

P.S. Sorry to get your name wrong, David.
