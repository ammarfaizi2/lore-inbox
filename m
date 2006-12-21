Return-Path: <linux-kernel-owner+w=401wt.eu-S1422720AbWLUFCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbWLUFCZ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbWLUFCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:02:25 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38302 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422720AbWLUFCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:02:25 -0500
Date: Wed, 20 Dec 2006 21:02:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Brownell <david-b@pacbell.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: Changes to sysfs PM layer break userspace
Message-Id: <20061220210214.f9b94889.akpm@osdl.org>
In-Reply-To: <200612202056.28177.david-b@pacbell.net>
References: <20061219185223.GA13256@srcf.ucam.org>
	<200612191929.14524.david-b@pacbell.net>
	<20061220195117.4d12dee7.akpm@osdl.org>
	<200612202056.28177.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 20:56:27 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Wednesday 20 December 2006 7:51 pm, Andrew Morton wrote:
> 
> > > +	if (!warned) {
> > > +		printk(KERN_WARNING
> > > +			"*** WARNING *** sysfs devices/.../power/state files "
> > > +			"are only for testing, and will be removed\n");
> > > +		warned = error;
> > > +	}
> > > +
> > >  	/* disallow incomplete suspend sequences */
> > >  	if (dev->bus && (dev->bus->suspend_late || dev->bus->resume_early))
> > >  		return error;
> > 
> > Well that's not much use.  It tells people "hey, we broke it".  They
> > already knew that.
> 
> No, it only does what you asked for:  warning people that they're using
> something that's going away.  It says nothing about "broke".
> 

But it's still broken, is it not?

> 
> > What we should do is to revert 047bda36150d11422b2c7bacca1df324c909c0b3 and
> 
> Bad answer

Is better than breaking stuff.

> ... see my original reply in this thread.  If "the answer" is
> to involve making PCI devices work again, better solutions include reverting
> the patch I mentioned (adding the suspend_late/resume_early support to PCI)
> or a version of what Matthew has produced (poking through bus layers so
> that test can be made to fail when the bus supports those methods but the
> specific device's driver doesn't use them).
> 

We appear to have a choice of three options.  But I see no fix in Greg's
tree.  Please let's not just accidentally forget to do this.

