Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbTFIKbr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 06:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262528AbTFIKbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 06:31:46 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:30217 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261845AbTFIK3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 06:29:39 -0400
Date: Mon, 9 Jun 2003 14:42:42 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: "David S. Miller" <davem@redhat.com>
Cc: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030609144242.A15283@jurassic.park.msu.ru>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk> <20030609140749.A15138@jurassic.park.msu.ru> <1055154054.9884.2.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1055154054.9884.2.camel@rth.ninka.net>; from davem@redhat.com on Mon, Jun 09, 2003 at 03:20:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 03:20:56AM -0700, David S. Miller wrote:
> On Mon, 2003-06-09 at 03:07, Ivan Kokshaysky wrote:
> > Looks good, but shouldn't we pass 'struct pci_bus *' instead
> > of pci_dev to pci_domain_nr()?
> 
> I don't think it matters, but someone may find a useful
> use of having the exact device available, who knows...

Hmm. Actually the patch *does* use pci_bus. What got me confused is
definition in include/linux/pci.h:

+#ifndef CONFIG_PCI_DOMAINS
+#define pci_domain_nr(pdev)    0
		       ~~~~
+#endif

I think it should be changed to 'pbus' to avoid confusion.

> We could just pass the bus self device in this case.

Root buses often do not have the self device, e.g. on alpha.

Ivan.
