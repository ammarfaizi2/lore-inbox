Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVF1OMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVF1OMO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVF1OMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:12:13 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:8646 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261600AbVF1OJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:09:56 -0400
Subject: Re: 2.6.12 breaks 8139cp
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <42C1434F.2010003@drzeus.cx>
References: <42B9D21F.7040908@drzeus.cx>
	 <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>
	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>
	 <42C0EE1A.9050809@drzeus.cx>  <42C1434F.2010003@drzeus.cx>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 09:09:48 -0500
Message-Id: <1119967788.6382.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that the reason that unloading the module does not help is
because the module_exit is calling pci_disable in the tpm_remove
function.  I'll generate a patch to remove this.

Additionally this version of the driver  was doing a bunch of stuff to
the LPC bus that I have since found not to be necessary and removed in
patches that have been applied to the mm tree and were pushed to
mainline this week.  Can anyone verify if this is still happening with
the -mm patch?

Regards,
Kylie

On Tue, 2005-06-28 at 14:32 +0200, Pierre Ossman wrote:
> Pierre Ossman wrote:
> > Hmm... it seems that TPM has something to do with the bug. Not sure why
> > though, can't see anything TPM related in dmesg. If I disable the TPM
> > parts in kconfig then the network works just fine.
> > 
> > I'm going to do a test of 2.6.12-rc1 through rc6 today to see where the
> > problem appears.
> > 
> 
> Confirmed this behaviour. The problem appears in rc1 (where the TPM is
> added). Unloading the module doesn't help, once it has been present the
> system needs a reboot for the network card to function properly.
> 
> I don't really see how the TPM can screw things up for the network card
> but I'm guessing it breaks something in the chipset (the TPM module gets
> loaded for the LPC bridge).
> 
> (added TPM maintainer and list as cc)
> 
> Rgds
> Pierre
> 

