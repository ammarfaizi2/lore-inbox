Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264175AbUDROCs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 10:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264172AbUDROCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 10:02:48 -0400
Received: from lists.us.dell.com ([143.166.224.162]:25519 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S264174AbUDROCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 10:02:41 -0400
Date: Sun, 18 Apr 2004 09:00:25 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Jeff Garzik'" <jgarzik@pobox.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'paul@kungfoocoder.org'" <paul@kungfoocoder.org>,
       "'James.Bottomley@SteelEye.com'" <James.Bottomley@SteelEye.com>,
       "'arjanv@redhat.com'" <arjanv@redhat.com>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RELEASE]: megaraid unified driver version 2.20.0.B1
Message-ID: <20040418140025.GA3585@lists.us.dell.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC544@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC544@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 02:40:36AM -0400, Mukker, Atul wrote:
> > >>14) the following check doesn't scale, please remove:
> > >>
> > >>+       if (subsysvid && (subsysvid != PCI_VENDOR_ID_AMI) &&
> > >>+                       (subsysvid != PCI_VENDOR_ID_DELL) &&
> > >>+                       (subsysvid != PCI_VENDOR_ID_HP) &&
> > >>+                       (subsysvid != PCI_VENDOR_ID_INTEL) &&
> > >>+                       (subsysvid != PCI_SUBSYS_ID_FSC) &&
> > >>+                       (subsysvid != PCI_VENDOR_ID_LSI_LOGIC)) {
>
> Combinig the subsystem id with pci vendor and device id in the device table
> would result in many permuations and combinations.

That's OK.  See the e100 driver, it's got like 35 entries on its list
already.

> You are right about future-proofing. But when we do this, we have something
> else in mind, which is totally opposite. I am sure, it seems abstruse to
> redundantly check for the subsystem ids, when the vendor and device ids are
> provided in the device table. This is done, so that we do not try to take
> ownership of controller, which actually belongs to some other vendor. I know
> of at least one example, where the qlogic driver loads for an AMI MegaRAID
> controller - because both share the same vendor and device ids. Now the
> driver assumes it to be a qlogic controller and tries to start it,
> eventually hanging the server.

But megaraid doesn't have this problem AFAIK.

And if necessary, a second pci_device_id list of IDs to test against
and exclude would be appropriate, and analogous to the pci_device_id
list that's used to accept devices.


> There definitely are other ways we driver simply wants to support a new
> controller, which should Just Work(tm), e.g., by accepting new PCI vendor
> id, device id and subsystem id as module parameters.

/sys/bus/pci/driver/megaraid/new_id  already does this

> It is unlikely we need this in near future because the frequency at
> which we update drivers makes it very easy to sneak in another set
> of PCI ids in the driver :-))

Wrong.  The issue isn't "how fast can LSI provide an updated driver to
kernel.org", but "how fast can users themselves add new IDs to a
driver for their given kernel/distribution at install time without
needing to wait for LSI to produce a new driver".  Hence the new_id
trick above was introduced for 2.6 for exactly this purpose.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
