Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVFGUlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVFGUlo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 16:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVFGUlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 16:41:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53131 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261979AbVFGUlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 16:41:39 -0400
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
	for drivers
From: Arjan van de Ven <arjan@infradead.org>
To: Greg KH <gregkh@suse.de>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       roland@topspin.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <20050607161029.GB15345@suse.de>
References: <20050607002045.GA12849@suse.de>
	 <20050607010911.GA9869@plap.qlogic.org> <20050607051551.GA17734@suse.de>
	 <1118129500.5497.16.camel@laptopd505.fenrus.org>
	 <20050607161029.GB15345@suse.de>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 22:41:12 +0200
Message-Id: <1118176872.5497.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 09:10 -0700, Greg KH wrote:
> On Tue, Jun 07, 2005 at 09:31:39AM +0200, Arjan van de Ven wrote:
> > 
> > > > * What if the driver writer does not want MSI enabled for their
> > > >   hardware (even though there is an MSI capabilities entry)?  Reasons
> > > >   include: overhead involved in initiating the MSI; no support in some
> > > >   versions of firmware (QLogic hardware).
> > > 
> > > Yes, a very good point.  I guess I should keep the pci_enable_msi() and
> > > pci_disable_msi() functions exported for this reason.
> > > 
> > 
> > well... only pci_disable_msi() is needed for this ;)
> 
> I thought so too, until I looked at the IB driver :(
> 
> The issue is, if pci_enable_msix() fails, we want to fall back to MSI,
> so you need to call pci_enable_msi() for that (after calling
> pci_disable_msi() before calling pci_enable_msix(), what a mess...)

if the core enables msi.. shouldn't the core also do msix ?

