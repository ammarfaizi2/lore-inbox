Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264176AbUFBVXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264176AbUFBVXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 17:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbUFBVXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 17:23:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33549 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264176AbUFBVXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 17:23:02 -0400
Date: Wed, 2 Jun 2004 22:22:57 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] 2.6.6 synclinkmp.c
Message-ID: <20040602222257.A9322@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Dave Jones <davej@redhat.com>
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com> <20040528160612.306c22ab.akpm@osdl.org> <1086123061.2171.10.camel@deimos.microgate.com> <20040601215710.F31301@flint.arm.linux.org.uk> <1086125129.2047.21.camel@deimos.microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1086125129.2047.21.camel@deimos.microgate.com>; from paulkf@microgate.com on Tue, Jun 01, 2004 at 04:25:30PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 04:25:30PM -0500, Paul Fulghum wrote:
> On Tue, 2004-06-01 at 15:57, Russell King wrote:
> > If pci_register_driver fails, the driver is not, repeat not left
> > registered.  Therefore it must not be unregistered after failure
> > to register.
> 
> You are right. The specific problem I was trying to
> fix is when no hardware is detected. I looked at other
> PCI drivers (char/epca.c and net/eepro100.c) and which call
> pci_unregister_driver if pci_register_driver returns <= 0
> and indicates that pci_register_device returns the number
> of pci devices detected. I now see that the two drivers I
> looked at are broken. (bad luck that)
> 
> After looking at the source for pci_register_device(),
> if no devices are detected, then it still returns 1.
> 
> I will rework the patches against synclink.c/synclinkmp.c
> to only call pci_unregister_device() if init fails
> (such as when no devices are detected)
> *and* the call to pci_register_device() succeeds.

Don't arrange for the driver to unload if it doesn't detect anything.
2.6 has dynid support so that the user can load your driver and assign
it extra PCI vendor/device IDs at run time - which won't work if you've
forced failure when nothing is found.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
