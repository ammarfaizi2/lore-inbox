Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284697AbRLDAVE>; Mon, 3 Dec 2001 19:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284507AbRLDAPb>; Mon, 3 Dec 2001 19:15:31 -0500
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:40403 "EHLO
	tuminfo2.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S284843AbRLCR37>; Mon, 3 Dec 2001 12:29:59 -0500
Subject: pci: dev->driver "runtime" acquisition?
From: Daniel Stodden <stodden@in.tum.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 03 Dec 2001 18:29:57 +0100
Message-Id: <1007400598.6982.2.camel@atbode65>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi.

supposing i've got a "hotplug" style pci_driver,
but who's going to gain access to a device _not_ at initialization time,
i.e. not within pci_register_driver(), but rather somehere in a bottom
half. no pci_device_id* at pci_register_driver( ), since i don't
know the signature yet.

how do i request access here?
could anyone comment on the following please:

1. simple, but intrusive somehow:
	dev_probe_lock()
	if ( dev->driver == NULL )
		dev->driver = my_driver;
	dev_probe_unlock()
   is the locking correct?

2. rather use pci_announce_device()?
	my_driver->id_table =
       		somthing_i_just_built_on_the_fly_and_i_know_it_matches;
	pci_announce_device( my_driver, dev );
	/* probe() does the rest */

3. patch drivers/pci/pci.c?
	pci_acquire_device( struct pci *dev, struct pci_driver *drv )
	{
		/* fill in 1. */
	}

4. simply rely on the "compat", i.e. just taking over some resource?
   i think that's not why it's been called "compat"

any better ideas? something i'm missing?
besides: policy? -- do i _have_ to pci_register_driver() at during
initialization before considering to actually drive something?

any help appreciated.

regards,
dns
		

-- 
__________________________________________________________________
mailto: stodden@in.tum.de

