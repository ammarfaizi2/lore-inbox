Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUA1Ryr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 12:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266011AbUA1Ryr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 12:54:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:18086 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266006AbUA1Ryp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 12:54:45 -0500
Date: Wed, 28 Jan 2004 09:40:52 -0800
From: Greg KH <greg@kroah.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       francis.wiran@hp.com
Subject: Re: [PATCH] cpqarray update
Message-ID: <20040128174052.GA6657@kroah.com>
References: <200401262002.i0QK2iAH031857@hera.kernel.org> <40157552.3040405@pobox.com> <15D09760-51A9-11D8-AF96-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15D09760-51A9-11D8-AF96-000A95A0560C@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 09:46:06AM -0600, Hollis Blanchard wrote:
> On Jan 26, 2004, at 2:15 PM, Jeff Garzik wrote:
> 
> >Linux Kernel Mailing List wrote:
> >>ChangeSet 1.1288, 2004/01/26 16:58:21-02:00, francis.wiran@hp.com
> >>@@ -616,7 +623,7 @@
> >>  	/* detect controllers */
> >> 	printk(DRIVER_NAME "\n");
> >>-	pci_register_driver(&cpqarray_pci_driver);
> >>+	pci_module_init(&cpqarray_pci_driver);
> >> 	cpqarray_eisa_detect();
> >>  	for(i=0; i< MAX_CTLR; i++) {
> >
> >You need to check the return value of pci_module_init() for errors.
> 
> I'm defining a new bus and had copied pci_module_init() to 
> vio_module_init(). Here's what Greg KH had to say about that:
> >Eeek!  I want to fix that code in pci_module_init() so it doesn't do
> >this at all.  Please don't copy that horrible function.  Just register
> >the driver with a call to vio_register_driver() and drop the whole
> >vio_module_init() completly.  I'll be doing that for pci soon, and
> >there's no reason you want to duplicate this broken logic (you always
> >want your module probe to succeed, for lots of reasons...)
> 
> So there's no need for the quoted patch hunk at all.

Well, changing it back to pci_register_driver() and actually checking
the return value would be a good idea :)

thanks,

greg k-h
