Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLKUDP>; Mon, 11 Dec 2000 15:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbQLKUDF>; Mon, 11 Dec 2000 15:03:05 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:28214
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129387AbQLKUCv>; Mon, 11 Dec 2000 15:02:51 -0500
Date: Mon, 11 Dec 2000 21:32:08 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Pavel Machek <pavel@suse.cz>, perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove warning from drivers/net/hp100.c (240-test12-pre7)
Message-ID: <20001211213208.B600@jaquet.dk>
In-Reply-To: <20001208211908.D599@jaquet.dk> <20001209101924.A126@bug.ucw.cz> <20001209163740.U6567@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001209163740.U6567@cadcamlab.org>; from peter@cadcamlab.org on Sat, Dec 09, 2000 at 04:37:40PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2000 at 04:37:40PM -0600, Peter Samuelson wrote:
> 
> [Pavel Machek]
> > I'd say that warning is more acceptable than #ifdef... In cases where
> > warnings can be eliminating without ifdefs, that's okay, but this...
> 
> In this case it is dead weight in the object file -- and for machines
> that can least afford it (CONFIG_PCI=n is mostly for the low end,
> right?).

How about this patch? It moves the offending struct to the __init function
where it is used and inside an existing #ifdef CONFIG_PCI. This would be
up to the maintainer but since this is the only place the struct is used
I think it is acceptable to move it from the top of the file.

Comments?


--- linux-240-t12-pre8-clean/drivers/net/hp100.c	Sat Nov  4 23:27:07 2000
+++ linux/drivers/net/hp100.c	Mon Dec 11 21:23:12 2000
@@ -265,13 +265,6 @@
 
 #define HP100_EISA_IDS_SIZE	(sizeof(hp100_eisa_ids)/sizeof(struct hp100_eisa_id))
 
-static struct hp100_pci_id hp100_pci_ids[] = {
-  { PCI_VENDOR_ID_HP, 		PCI_DEVICE_ID_HP_J2585A },
-  { PCI_VENDOR_ID_HP,		PCI_DEVICE_ID_HP_J2585B },
-  { PCI_VENDOR_ID_COMPEX,	PCI_DEVICE_ID_COMPEX_ENET100VG4 },
-  { PCI_VENDOR_ID_COMPEX2,	PCI_DEVICE_ID_COMPEX2_100VG }
-};
-
 #define HP100_PCI_IDS_SIZE	(sizeof(hp100_pci_ids)/sizeof(struct hp100_pci_id))
 
 static int hp100_rx_ratio = HP100_DEFAULT_RX_RATIO;
@@ -335,6 +328,13 @@
   int ioaddr = 0;
 #ifdef CONFIG_PCI
   int pci_start_index = 0;
+
+  static struct hp100_pci_id hp100_pci_ids[] = {
+	  { PCI_VENDOR_ID_HP, 		PCI_DEVICE_ID_HP_J2585A },
+	  { PCI_VENDOR_ID_HP,		PCI_DEVICE_ID_HP_J2585B },
+	  { PCI_VENDOR_ID_COMPEX,	PCI_DEVICE_ID_COMPEX_ENET100VG4 },
+	  { PCI_VENDOR_ID_COMPEX2,	PCI_DEVICE_ID_COMPEX2_100VG }
+  };
 #endif
 
 #ifdef HP100_DEBUG_B

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

It's a recession when your neighbour loses his job; it's a depression 
when you lose yours. -- Harry S. Truman 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
