Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbTEFDpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 23:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTEFDpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 23:45:44 -0400
Received: from granite.he.net ([216.218.226.66]:55557 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S262300AbTEFDpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 23:45:43 -0400
Date: Mon, 5 May 2003 20:56:35 -0700
From: Greg KH <greg@kroah.com>
To: Matt_Domsch@Dell.com
Cc: mochel@osdl.org, alan@redhat.com, linux-kernel@vger.kernel.org,
       jgarzik@redhat.com
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <20030506035635.GA5403@kroah.com>
References: <1052186678.19726.9.camel@iguana.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052186678.19726.9.camel@iguana.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 09:04:35PM -0500, Matt_Domsch@Dell.com wrote:
> > Unfortunatly, looking at the driver core real quickly, I don't see a
> > simple way to kick the probe cycle off again for all pci devices, but
> > I'm probably just missing something somewhere...
> 
> I think drivers/base/bus.c: driver_attach() is what we want, which will
> walk the list of the bus's devices and run bus_match() which is
> pci_bus_match() which will scan for us.  Just need to un-static
> driver_attach() I expect.  Pat, does this sound right?

You can't just call driver_attach(), as the bus semaphore needs to be
locked before doing so.  In short, you almost need to duplicate
bus_add_driver(), but not quite :)

Good luck,

greg k-h
