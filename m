Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbTFRNLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 09:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbTFRNLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 09:11:30 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:30727 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265161AbTFRNLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 09:11:03 -0400
Date: Wed, 18 Jun 2003 17:24:09 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030618172408.A11158@jurassic.park.msu.ru>
References: <1055341842.754.3.camel@gaston> <20030611144801.GZ28581@parcelfarce.linux.theplanet.co.uk> <20030617044948.GA1172@krispykreme> <20030617134156.A2473@jurassic.park.msu.ru> <20030617124950.GF8639@krispykreme> <20030617171100.B730@jurassic.park.msu.ru> <20030617194227.GG24357@parcelfarce.linux.theplanet.co.uk> <20030618013058.A686@pls.park.msu.ru> <20030618130234.GN24357@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030618130234.GN24357@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Wed, Jun 18, 2003 at 02:02:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 02:02:34PM +0100, Matthew Wilcox wrote:
> > "Never" is not quite correct - "in general we don't have"
> > would be better. Full-sized Marvel can have up to 512 root buses.
> 
> So what do you want to do about that case?

Probably something like this:

static inline int pci_name_bus(char *name, struct pci_bus *bus)
{
	if (pci_domain_nr(bus) < 256) {
		sprintf(name, "%02x", bus->number);
	} else {
		sprintf(name, "%04x:%02x", pci_domain_nr(bus), bus->number);
	}
	return 0;
}

Ivan.
