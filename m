Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289725AbSBER7p>; Tue, 5 Feb 2002 12:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289718AbSBER7d>; Tue, 5 Feb 2002 12:59:33 -0500
Received: from cc5993-b.ensch1.ov.nl.home.com ([212.204.161.160]:14608 "HELO
	packetstorm.nu") by vger.kernel.org with SMTP id <S289711AbSBER7N>;
	Tue, 5 Feb 2002 12:59:13 -0500
Reply-To: <alex@packetstorm.nu>
From: "Alex Scheele" <alex@packetstorm.nu>
To: "Roger Massey" <rmassey@avaya.com>
Cc: "Lkml" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.17 panic on boot - patch for ide-pci
Date: Tue, 5 Feb 2002 18:59:09 +0100
Message-ID: <IOEMLDKDBECBHMIOCKODCECACJAA.alex@packetstorm.nu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <029b01c1ae68$5df20b20$12320987@dr.avaya.com>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> --- drivers/ide/ide-pci.c Mon Feb  4 19:44:02 2002
> +++ drivers/ide/ide-pci.orig.c Mon Feb  4 19:37:50 2002
> @@ -836,11 +836,7 @@
>   pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
>   class_rev &= 0xff;
> 
> - if(class_rev >= (sizeof(chipset_names)/sizeof(char *))) {
> -  class_rev = (sizeof(chipset_names)/sizeof(char *)) - 1;
> - }
> -
> - strncpy(d->name, chipset_names[class_rev], strlen(d->name));
> + strcpy(d->name, chipset_names[class_rev]);
> 
>   switch(class_rev) {
>    case 4:
> --- drivers/ide/hpt366.c Mon Feb  4 19:32:45 2002
> +++ drivers/ide/hpt366.orig.c Mon Feb  4 19:33:30 2002
> @@ -214,9 +214,6 @@
>   pci_read_config_dword(bmide_dev, PCI_CLASS_REVISION, &class_rev);
>   class_rev &= 0xff;
> 
> - if(class_rev >= (sizeof(chipset_names)/sizeof(char *)))
> -  class_rev = (sizeof(chipset_names)/sizeof(char *)) -1;
> -
>          /*
>           * at that point bibma+0x2 et bibma+0xa are byte registers
>           * to investigate:

Seems u diffed the wrong way :) original file should be first.

--
	Alex (alex@packetstorm.nu)


