Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVAMSHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVAMSHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVAMSEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:04:46 -0500
Received: from colin2.muc.de ([193.149.48.15]:33540 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261381AbVAMSDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:03:51 -0500
Date: 13 Jan 2005 19:03:47 +0100
Date: Thu, 13 Jan 2005 19:03:47 +0100
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brking@us.ibm.com, paulus@samba.org, benh@kernel.crashing.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
Message-ID: <20050113180347.GB17600@muc.de>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com> <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com> <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com> <1105454259.15794.7.camel@localhost.localdomain> <20050111173332.GA17077@muc.de> <1105626399.4664.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105626399.4664.7.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 03:35:59PM +0000, Alan Cox wrote:
> On Maw, 2005-01-11 at 17:33, Andi Kleen wrote:
> > > User space does not expect to get dumped with -EBUSY randomly on PCI
> > 
> > I think it's a reasonable thing to do.  If you prefer you could fake a
> > 0xffffffff read, that would look like busy or non existing hardware.
> > But the errno would seem to be cleaner to me.
> 
> Either will break X.

You are saying that X during its own private broken PCI scan
stops scanning when it sees an errno? 

That sounds incredibly broken if true. I'm not sure how much
effort the kernel should really take to work around such
user breakage. I suppose an ffffffff return would work. 

> 
> > > static int pci_user_wait_access(struct pci_dev *pdev) {
> > > 	wait_event(&pci_ucfg_wait, dev->block_ucfg_access == 0);
> > > }
> > 
> > I don't like this very much. What happens when the device 
> > doesn't get out of BIST for some reason? 
> 
> Then you need to switch to wait_event_timeout(). Its not terribly hard
> 8)

Just complicating something that should be very simple.

-Andi
