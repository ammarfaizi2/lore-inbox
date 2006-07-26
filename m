Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWGZQYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWGZQYx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbWGZQYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:24:53 -0400
Received: from mx1.suse.de ([195.135.220.2]:63461 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751699AbWGZQYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:24:53 -0400
Date: Wed, 26 Jul 2006 09:20:07 -0700
From: Greg KH <gregkh@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: restore missing PCI registers after reset
Message-ID: <20060726162007.GA9871@suse.de>
References: <20060717162531.GC4829@kroah.com> <20060726102944.GA9411@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726102944.GA9411@mellanox.co.il>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:29:44PM +0300, Michael S. Tsirkin wrote:
> Quoting r. Greg KH <gregkh@suse.de>:
> > Subject: [patch 02/45] IB/mthca: restore missing PCI registers after reset
> > ------------------
> > mthca does not restore the following PCI-X/PCI Express registers after reset:
> >   PCI-X device: PCI-X command register
> >   PCI-X bridge: upstream and downstream split transaction registers
> >   PCI Express : PCI Express device control and link control registers
> > 
> > This causes instability and/or bad performance on systems where one of
> > these registers is set to a non-default value by BIOS.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> > Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> By the way, Greg, this code is completely generic, and the same seems to apply
> to all PCI-X/PCI-Express devices - should not pci_restore_state and
> friends really know about these registers, as well?
> 
> What do you think?

I think pci_restore_state() already restores the msi and msix state,
take a look at the latest kernel version :)

thanks,

greg k-h
