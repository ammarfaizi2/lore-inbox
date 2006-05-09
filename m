Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751776AbWEIPDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWEIPDv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWEIPDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:03:51 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:60064 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S1751776AbWEIPDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:03:51 -0400
Date: Tue, 9 May 2006 16:03:38 +0100
From: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       Ian Pratt <ian.pratt@xensource.com>, xen-devel@lists.xensource.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
Message-ID: <20060509150338.GF7834@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085159.285105000@sous-sol.org> <200605091526.10936.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605091526.10936.ak@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 03:26:10PM +0200, Andi Kleen wrote:
> 
> > --- linus-2.6.orig/drivers/char/tty_io.c
> > +++ linus-2.6/drivers/char/tty_io.c
> > @@ -132,6 +132,8 @@ LIST_HEAD(tty_drivers);			/* linked list
> >     vt.c for deeply disgusting hack reasons */
> >  DEFINE_MUTEX(tty_mutex);
> >  
> > +int console_use_vt = 1;
> > +
> 
> Can you explain why this variable is needed? It shouldn't. If you only
> register your console as the primary console nothing else should
> be printed.

It is needed for having a kernel which can run both as a dom0 and domU
kernel.  For dom0, you want to build with CONFIG_VT enabled while for
domU, the CONFIG_VT code doesn't let the xen console be the primary
console unless you specify it on the command line.

I've removed this from the patchqueue since a kernel built from the
patchqueue won't run as a dom0 kernel anyway.

> > +/*** Useful function for console debugging -- goes straight to Xen. ***/
> > +asmlinkage int xprintk(const char *fmt, ...)
> 
> This is called early_printk in the rest of i386. Please use that name too.

We have proper early_printk support but it's not part of the patchqueue.
This is more of a debug function where you would rename the kernel/printk
to something else and rename this to printk.  I've removed it.

     christian

