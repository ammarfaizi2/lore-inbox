Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAWSS6>; Tue, 23 Jan 2001 13:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRAWSSs>; Tue, 23 Jan 2001 13:18:48 -0500
Received: from irz301.inf.tu-dresden.de ([141.76.2.1]:14818 "EHLO
	irz301.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S129406AbRAWSSh>; Tue, 23 Jan 2001 13:18:37 -0500
Date: Tue, 23 Jan 2001 19:18:34 +0100
From: Adam Lackorzynski <al10@inf.tu-dresden.de>
To: Martin Mares <mj@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI-Devices and ServerWorks chipset
Message-ID: <20010123191834.E15427@inf.tu-dresden.de>
In-Reply-To: <20010116181207.A1325@inf.tu-dresden.de> <20010117095221.A553@albireo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010117095221.A553@albireo.ucw.cz>; from mj@suse.cz on Wed, Jan 17, 2001 at 09:52:21AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 17, 2001 at 09:52:21 +0100, Martin Mares wrote:
> Hello!
> 
> > The patch below (against vanilla 2.4.0) makes Linux recognize
> > PCI-Devices sitting in another PCI bus than 0 (or 1).
> > 
> > This was tested on a Netfinity 7100-8666 using a ServerWorks chipset.
> 
> I don't have the ServerWorks chipset documentation at hand, but I think your
> patch is wrong -- it doesn't make any sense to scan a bus _range_. The registers

Another possible workaround for my problem is just not to call the
fixup routine for the chipset:

--- pci-pc.c~    Thu Jun 22 16:17:16 2000
+++ pci-pc.c    Tue Jan 23 18:46:55 2001
@@ -927,7 +927,6 @@
 struct pci_fixup pcibios_fixups[] = {
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82451NX,    pci_fixup_i450nx },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82454GX,    pci_fixup_i450gx },
-       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SERVERWORKS,      PCI_DEVICE_ID_SERVERWORKS_HE,           pci_fixup_serverworks },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SERVERWORKS,      PCI_DEVICE_ID_SERVERWORKS_LE,           pci_fixup_serverworks },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SERVERWORKS,      PCI_DEVICE_ID_SERVERWORKS_CMIC_HE,      pci_fixup_serverworks },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_COMPAQ,   PCI_DEVICE_ID_COMPAQ_6010,      pci_fixup_compaq },

This patch is against 2.4.0-ac10. Having the above line in the PCI devices do
not occur, leaving it out they appear.



Adam
-- 
Adam                 al10@inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
