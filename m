Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVFHE6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVFHE6x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 00:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVFHE6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 00:58:42 -0400
Received: from colo.lackof.org ([198.49.126.79]:50127 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S262101AbVFHE6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 00:58:34 -0400
Date: Tue, 7 Jun 2005 23:02:12 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <gregkh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       tom.l.nguyen@intel.com, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi() for drivers - take 2
Message-ID: <20050608050212.GD21060@colo.lackof.org>
References: <20050607002045.GA12849@suse.de> <20050607202129.GB18039@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607202129.GB18039@kroah.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 01:21:29PM -0700, Greg KH wrote:
> So, anyone else think this is a good idea? Votes for me to just drop it
> and go back to hacking on the driver core instead?

I'd rather you dropped it or treated MSI/MSI-X more alike.

> Oh, and in looking at the drivers/pci/msi.c file, it could use some
> cleanups to make it smaller and a bit less complex.

Just do it. :^)

> I've also seen some
> complaints that it is very arch specific (x86 based).  But as no other
> arches seem to want to support MSI, I don't really see any need to split
> it up.  Any comments about this?

IA64 supports MSI/MSI-X. Roland, didn't PPC as well?

I don't think it's *that* x86 specific.  The base address of the
Processor interrupt Block (IIRC 0xfee0000) is implemented
the same on several arches AFAIK. Even on some parisc chipsets.
I been constantly chasing other basic issues on parisc and just
haven't had time to implement it in the past 3 years.


I also see one minor weakness in the assumption that CPU Vectors
are global. Both IA64/PARISC can support per-CPU Vector tables.
I thought some other arches could too but can't remember the details.
Ie the same vector can be directed at different CPUs depending on
which address the transaction targets. This vastly increases
the number of unique vectors available on 2 or 4-way boxes.
This is interesting if drivers start consuming multiple MSI-X
vectors per card instance.

grant
