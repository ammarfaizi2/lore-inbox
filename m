Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131347AbRBNLSU>; Wed, 14 Feb 2001 06:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130988AbRBNLSA>; Wed, 14 Feb 2001 06:18:00 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:29464 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S129197AbRBNLR0>; Wed, 14 Feb 2001 06:17:26 -0500
Date: Wed, 14 Feb 2001 05:17:19 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Tim Waugh <twaugh@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <3A8A6A42.66F727FA@uow.edu.au>
Message-ID: <Pine.LNX.3.96.1010214051637.12910G-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001, Andrew Morton wrote:

> Jeff Garzik wrote:
> > 
> > Bad patch.  It should be
> > 
> >         if (r >= 0) {
> >                 registered_parport = 1;
> >                 if (r > 0)
> >                         count += r;
> >         }
> > 
> > If pci_register_driver returns < 0, the driver is not registered with
> > the system.
> 
> eh?
> 
> pci_register_driver(struct pci_driver *drv)
> {
>         struct pci_dev *dev;
>         int count = 0;
> 
>         list_add_tail(&drv->node, &pci_drivers);
>         pci_for_each_dev(dev) {
>                 if (!pci_dev_driver(dev))
>                         count += pci_announce_device(drv, dev);
>         }
>         return count;
> }
> 
> Maybe you're thinking of pci_module_init?

Apparently :)  Oops, sorry Tim.

Oh well, the new patch is a better one anyway ;)  Guards against me
changing pci_register_driver as such.  :)

	Jeff




