Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbVBAW7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVBAW7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVBAW7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:59:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:7862 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262158AbVBAW7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:59:16 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Brian King <brking@us.ibm.com>, Greg KH <greg@kroah.com>,
       Andi Kleen <ak@muc.de>, Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
References: <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de> <41ED27CD.7010207@us.ibm.com>
	 <1106161249.3341.9.camel@localhost.localdomain>
	 <41F7C6A1.9070102@us.ibm.com> <1106777405.5235.78.camel@gaston>
	 <1106841228.14787.23.camel@localhost.localdomain>
	 <41FA4DC2.4010305@us.ibm.com> <20050201072746.GA21236@kroah.com>
	 <41FF9C78.2040100@us.ibm.com>
	 <20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 09:58:40 +1100
Message-Id: <1107298720.5624.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 15:44 +0000, Matthew Wilcox wrote:

> 
> > +void pci_unblock_user_cfg_access(struct pci_dev *dev)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&pci_lock, flags);
> > +	dev->block_ucfg_access = 0;
> > +	spin_unlock_irqrestore(&pci_lock, flags);
> > +}
> 
> If we've done a write to config space while the adapter was blocked,
> shouldn't we replay those accesses at this point?

I think no. In fact, I would be ok returning errors on writes from
userland. Need to do config space writes from userland is rare, must
more than reads, and if whatever does it can't properly arbitrate with
what's going on in the kernel, then it's broken.

Ben.


