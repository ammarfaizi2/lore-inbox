Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129805AbRA2V5O>; Mon, 29 Jan 2001 16:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbRA2V5F>; Mon, 29 Jan 2001 16:57:05 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:16240
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129805AbRA2V4r>; Mon, 29 Jan 2001 16:56:47 -0500
Date: Mon, 29 Jan 2001 22:56:40 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi/dmx3191d.c: small cleanup patch (241p11)
Message-ID: <20010129225640.L603@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Forgot l-k. Please cc dafastidio@libero.it on replies to this mail.)

----- Forwarded message from Rasmus Andersen <rasmus@jaquet.dk> -----

Hi.

The following patch makes drivers/scsi/dmx3191d.c call
pci_enable_device before probing resources and replaces
a check_region+request_region with request_region.

It applies against ac12 and 241p11.

Comments?



--- linux-ac12-clean/drivers/scsi/dmx3191d.c	Sun Nov 12 04:01:11 2000
+++ linux-ac12/drivers/scsi/dmx3191d.c	Sat Jan 27 21:27:44 2001
@@ -68,18 +68,16 @@
 	while ((pdev = pci_find_device(PCI_VENDOR_ID_DOMEX,
 			PCI_DEVICE_ID_DOMEX_DMX3191D, pdev))) {
 
-		unsigned long port = pci_resource_start (pdev, 0);
-
 		if (pci_enable_device(pdev))
 			continue;
 
-		if (check_region(port, DMX3191D_REGION)) {
+		unsigned long port = pci_resource_start (pdev, 0);
+
+		if (!request_region(port, DMX3191D_REGION, DMX3191D_DRIVER_NAME)) {
 			dmx3191d_printk("region 0x%lx-0x%lx already reserved\n",
 				port, port + DMX3191D_REGION);
 			continue;
 		}
-
-		request_region(port, DMX3191D_REGION, DMX3191D_DRIVER_NAME);
 
 		instance = scsi_register(tmpl, sizeof(struct NCR5380_hostdata));
 		if(instance == NULL)

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"There are also enough rocks on Earth to kill the world's population several
times over."
	-- Lt. General Daniel Graham, DIA, explaining why it's necessary to
	   have more than enough nukes

----- End forwarded message -----

-- 
        Rasmus(rasmus@jaquet.dk)

Even if you're on the right track, you'll get run over if you just sit there. 
  -- Will Rogers
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
