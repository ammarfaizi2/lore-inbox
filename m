Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135601AbREIAh3>; Tue, 8 May 2001 20:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135608AbREIAhS>; Tue, 8 May 2001 20:37:18 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:27372 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135601AbREIAhK>; Tue, 8 May 2001 20:37:10 -0400
Date: Tue, 8 May 2001 20:37:05 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Patch to make ymfpci legacy address 16 bits
Message-ID: <20010508203705.A6496@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

I found that every time I run a 2.4 on my laptop, APM locks up
the machine. Apparently, legacy YMF code enabled decoding of
10 bits of I/O address. A call to APM BIOS touched that and
somehow the system locked up.

If Pavel Roskin, Daisuke Nagano or someone else do not mind,
I want this in stock kernel.

-- Pete

--- linux-2.4.4/drivers/sound/ymfpci.c	Thu Apr 26 22:17:27 2001
+++ linux-2.4.4-niph/drivers/sound/ymfpci.c	Tue May  8 16:46:58 2001
@@ -2059,9 +2059,10 @@
 	}
 
 	if (mpuio >= 0 || oplio >= 0) {
-		v = 0x003e;
+		/* 0x0020: 1 - 10 bits of I/O address decoded, 0 - 16 bits. */
+		v = 0x001e;
 		pci_write_config_word(pcidev, PCIR_LEGCTRL, v);
-	
+
 		switch (pcidev->device) {
 		case PCI_DEVICE_ID_YAMAHA_724:
 		case PCI_DEVICE_ID_YAMAHA_740:
