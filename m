Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129500AbRBLXin>; Mon, 12 Feb 2001 18:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbRBLXie>; Mon, 12 Feb 2001 18:38:34 -0500
Received: from irz301.inf.tu-dresden.de ([141.76.2.1]:38522 "EHLO
	irz301.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S129500AbRBLXiU>; Mon, 12 Feb 2001 18:38:20 -0500
Date: Tue, 13 Feb 2001 00:38:15 +0100
From: Adam Lackorzynski <al10@inf.tu-dresden.de>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bridge handling 2.4.0-test10 -> 2.4.2-pre3
Message-ID: <20010213003815.A17962@inf.tu-dresden.de>
In-Reply-To: <20010212140419.A11619@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010212140419.A11619@lug-owl.de>; from jbglaw@lug-owl.de on Mon, Feb 12, 2001 at 02:04:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Feb 12, 2001 at 14:04:20 +0100, Jan-Benedict Glaw wrote:
> I've got a "Bull Express5800/Series" (dual P3) with a DAC1164 RAID
> controller. The mainboard is ServerWorks based and however, 2.4.2-pre3
> fails to find the RAID controller. I think there's a problem at
> scanning PCI busses behind PCI bridges. Here's the PCI bus layout as
> 2.4.0-test10 recognizes it:

There's was a change in the PCI bus scan code in pre3.


Could you please apply the following patch to arch/i386/kernel/pci-pc.c (against
2.4.1-pre3) and tell us your results? The fixup functions do not seem to
work right now so we'll trust the BIOS...

--- pci-pc.c.orig       Tue Feb 13 00:02:50 2001
+++ pci-pc.c    Tue Feb 13 00:19:29 2001
@@ -953,9 +953,6 @@
 struct pci_fixup pcibios_fixups[] = {
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82451NX,    pci_fixup_i450nx },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82454GX,    pci_fixup_i450gx },
-       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SERVERWORKS,      PCI_DEVICE_ID_SERVERWORKS_HE,           pci_fixup_serverworks },
-       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SERVERWORKS,      PCI_DEVICE_ID_SERVERWORKS_LE,           pci_fixup_serverworks },
-       { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SERVERWORKS,      PCI_DEVICE_ID_SERVERWORKS_CMIC_HE,      pci_fixup_serverworks },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_COMPAQ,   PCI_DEVICE_ID_COMPAQ_6010,      pci_fixup_compaq },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_UMC,      PCI_DEVICE_ID_UMC_UM8886BF,     pci_fixup_umc_ide },
        { PCI_FIXUP_HEADER,     PCI_VENDOR_ID_SI,       PCI_DEVICE_ID_SI_5513, pci_fixup_ide_trash },



Adam
-- 
Adam                 al10@inf.tu-dresden.de
  Lackorzynski         http://a.home.dhs.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
