Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266721AbSLWPgS>; Mon, 23 Dec 2002 10:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266728AbSLWPgS>; Mon, 23 Dec 2002 10:36:18 -0500
Received: from halon.barra.com ([144.203.11.1]:2713 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id <S266721AbSLWPgQ>;
	Mon, 23 Dec 2002 10:36:16 -0500
From: Fedor Karpelevitch <fedor@karpelevitch.net>
To: "Mark F." <daracerz@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ATI Radeon IGP 320M and Kern. 2.4.21-pre2 Warnings/Problems...
Date: Mon, 23 Dec 2002 06:52:45 -0800
User-Agent: KMail/1.5
References: <BAY2-F160dWMJ69ik6k0000047c@hotmail.com>
In-Reply-To: <BAY2-F160dWMJ69ik6k0000047c@hotmail.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Vicente Aguilar <bisente@bisente.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9MyB+SBXvOIXIHC"
Message-Id: <200212230652.45451.fedor@karpelevitch.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_9MyB+SBXvOIXIHC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Mark F. wrote:
> Hello
>
> In trying to help out the issue with the Radeon IGP Chipsets, I
> have posted out the problems that occured on my system.  This is a
> Readon IGP 320M chip, running on a Compaq 900Z.  BTW, these logs
> don't include loading sound driver.  Sound driver cause the my hda,
> hdc links to timeout, and the hard drives are completely
> inaccesable till i remake kernel without them.
>

attached is the patch which makes sound work.

Fedor.
--Boundary-00=_9MyB+SBXvOIXIHC
Content-Type: text/plain;
  charset="iso-8859-1";
  name="patch-tridfix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-tridfix.txt"

--- linux-2.4.21-pre1/drivers/sound/trident.c	2002-12-12 15:28:00.000000000 -0800
+++ linux-2.4.21-pre1-tridfix/drivers/sound/trident.c	2002-12-12 15:30:48.000000000 -0800
@@ -3368,15 +3368,17 @@
         pci_dev = pci_find_device(PCI_VENDOR_ID_AL,PCI_DEVICE_ID_AL_M1533, pci_dev);
         if (pci_dev == NULL)
                 return -1;
-	temp = 0x80;
-	pci_write_config_byte(pci_dev, 0x59, ~temp);
+	pci_read_config_byte(pci_dev, 0x59, &temp);
+	temp &= ~0x80;
+	pci_write_config_byte(pci_dev, 0x59, temp);
 	
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, pci_dev);
 	if (pci_dev == NULL)
                 return -1;
 
-	temp = 0x20;
-	pci_write_config_byte(pci_dev, 0xB8, ~temp);
+	pci_read_config_byte(pci_dev, 0xB8, &temp);
+	temp &= ~0x20;
+	pci_write_config_byte(pci_dev, 0xB8, temp);
 
 	return 0;
 }
@@ -3390,13 +3392,15 @@
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pci_dev);
 	if (pci_dev == NULL)
                 return -1;
-	temp = 0x80;
+	pci_read_config_byte(pci_dev, 0x59, &temp);
+	temp |= 0x80;
 	pci_write_config_byte(pci_dev, 0x59, temp);
 	
 	pci_dev = pci_find_device(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M7101, pci_dev);
  	if (pci_dev == NULL)
                 return -1;
-	temp = 0x20;
+	pci_read_config_byte(pci_dev, (int)0xB8, &temp);
+	temp |= 0x20;
 	pci_write_config_byte(pci_dev, (int)0xB8,(u8) temp);
 	if (chan_nums == 6) {
 		dwValue = inl(TRID_REG(card, ALI_SCTRL)) | 0x000f0000;

--Boundary-00=_9MyB+SBXvOIXIHC--
