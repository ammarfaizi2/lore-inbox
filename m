Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268452AbTBNP4Y>; Fri, 14 Feb 2003 10:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268453AbTBNP4Y>; Fri, 14 Feb 2003 10:56:24 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:42759 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S268452AbTBNP4W>; Fri, 14 Feb 2003 10:56:22 -0500
Date: Fri, 14 Feb 2003 19:05:38 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA/sysfs update
Message-ID: <20030214190538.A19355@jurassic.park.msu.ru>
References: <1044241767.3924.14.camel@mulgrave> <wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org> <20030214173217.A17730@jurassic.park.msu.ru> <wrpisvmri71.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <wrpisvmri71.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Fri, Feb 14, 2003 at 04:32:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 04:32:50PM +0100, Marc Zyngier wrote:
> Ivan> I believe this driver will work for any PCI/EISA bridge without
> Ivan> any changes, not only for i82375. Probably we need to look for a
> Ivan> class code rather than a device id.
> 
> Unfortunately, the i82375 appears to be unclassified :
> 
> 00:07.0 Non-VGA unclassified device: Intel Corp. 82375EB (rev 03)

We have this code in arch/alpha/kernel/pci.c for ages:

...
static void __init
quirk_eisa_bridge(struct pci_dev *dev)
{
	dev->class = PCI_CLASS_BRIDGE_EISA << 8;
}
...
struct pci_fixup pcibios_fixups[] __initdata = {
	{ PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82375,
	  quirk_eisa_bridge },
...

I think it belongs in drivers/pci/quirks.c.

> I'll had PCI_CLASS_BRIDGE_EISA anyway, just in case.

Actually I thought of replacing "i82375" with "pci_eisa" everywhere
in your driver and

static struct pci_device_id pci_eisa_pci_tbl[] = {
	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
	  PCI_CLASS_BRIDGE_EISA << 8, 0xffff00, 0 },
	{ 0, }
};

Ivan.
