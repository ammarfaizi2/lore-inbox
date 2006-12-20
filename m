Return-Path: <linux-kernel-owner+w=401wt.eu-S964842AbWLTDwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWLTDwq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWLTDwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:52:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:33151 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964842AbWLTDwp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:52:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M4LQnhtuaziJYo5PHVt75Fo2EBaIY2IH3j4DSOjp8gaW0j166HGqBKmYfYFyTXHdU2Je0ki5ObtI9wdamrpetpPvmCZljqFGPKEcvzwPGPUijevMJYROieZWzM+mBS+un72rKXLiGw0ZOM4HwvbNCNyyQktl8j+5CWEnGXX8R50=
Message-ID: <5767b9100612191952o593a4c48w50f0d483533a3a09@mail.gmail.com>
Date: Wed, 20 Dec 2006 11:52:44 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Add pci class code for SATA
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <5767b9100612191941n461f2b39k93d2cec43a31205a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0612171409340.9120@localhost.localdomain>
	 <1166551886.2977.5.camel@localhost.localdomain>
	 <45883E64.20400@garzik.org>
	 <5767b9100612191913p29675249v18803c65f536bda4@mail.gmail.com>
	 <5767b9100612191941n461f2b39k93d2cec43a31205a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Conke Hu <conke.hu@gmail.com> wrote:
> On 12/20/06, Conke Hu <conke.hu@gmail.com> wrote:
> > On 12/20/06, Jeff Garzik <jeff@garzik.org> wrote:
> > > Conke Hu wrote:
> > > > Add pci class code 0x0106 for SATA to pci_ids.h
> > > >
> > > > signed-off-by: conke.hu@gmail.com
> > > > --------------------
> > > > --- linux-2.6.20-rc1/include/linux/pci_ids.h.orig     2006-12-20
> > > > 01:58:30.000000000 +0800
> > > > +++ linux-2.6.20-rc1/include/linux/pci_ids.h  2006-12-20
> > > > 01:59:07.000000000 +0800
> > > > @@ -15,6 +15,7 @@
> > > >  #define PCI_CLASS_STORAGE_FLOPPY     0x0102
> > > >  #define PCI_CLASS_STORAGE_IPI                0x0103
> > > >  #define PCI_CLASS_STORAGE_RAID               0x0104
> > > > +#define PCI_CLASS_STORAGE_SATA               0x0106
> > > >  #define PCI_CLASS_STORAGE_SAS                0x0107
> > > >  #define PCI_CLASS_STORAGE_OTHER              0x0180
> > >
> > > Two comments:
> > >
> > > 1) I think "_SATA" is an inaccurate description.  It should be _AHCI AFAICS.
> > >
> > > 2) Typically we don't add constants unless they are used somewhere...
> > >
> > >         Jeff
> > >
> >
> > Hi Jeff,
> >     According to PCI spec 3.0, 0x0106 means SATA controller, 0x010601
> > means AHCI and 0x010600 means vendor specific SATA controller. Pls see
> > the following table (PCI spec 3.0 P296):
> >
> > Base Class      Sub-Class       Interface       Meaning
> > --------------------------------------------------------
> >                 00h             00h             SCSI bus controller
> >                 ------------------------------------------------
> >                 01h             xxh             IDE controller
> >                 -----------------------------------------------
> >                 02h             00h             Floppy disk controller
> >                 -----------------------------------------------------
> >                 03h             00h             IPI bus controller
> >                 --------------------------------------------------
> >                 04h             00h             RAID controller
> > 01h             ------------------------------------------------
> >                                 20h             ATA controller with ADMA interface
> >                 05h             ---------------------------------------------------
> >                                 30h             ATA controller with ADMA interface
> >                 -------------------------------------------------------------------
> >                                 00h             Serial ATA controller–vendor specific interface
> >                 06h             -----------------------------------------------------------------
> >                                 01h             Serial ATA controller–AHCI 1.0 interface
> >                 -------------------------------------------------------------------------
> >                 07h             00h             Serial Attached SCSI (SAS) controller
> >                 ---------------------------------------------------------------------
> >                 80h             00h             Other mass storage controller
> > ------------------------------------------------------------------------------
> >
> >
> > So, I think, the following macro is correct:
> > #define PCI_CLASS_STORAGE_SATA               0x0106
> > If you would define AHCI class code, it should be 0x010601, not 0x0106:
> > #define PCI_CLASS_STORAGE_SATA_AHCI               0x010601
> >
> > And, I think that PCI_CLASS_STORAGE_SATA had better be added to
> > pci_ids.h since the class code 0x0106 is used more than once. e.g.
> > ahci.c uses the magic number 0x0106 twice, and it might be used more
> > in future.
> >
> > Best regards,
> > Conke
> >
>
>
> Here is a patch to show more details:
> -----------------------------------
> diff -Nur linux-2.6.20-rc1.orig/drivers/ata/ahci.c
> linux-2.6.20-rc1/drivers/ata/ahci.c
> --- linux-2.6.20-rc1.orig/drivers/ata/ahci.c    2006-12-20 10:25:00.000000000 +0800
> +++ linux-2.6.20-rc1/drivers/ata/ahci.c 2006-12-20 10:13:24.000000000 +0800
> @@ -418,7 +418,7 @@
>
>         /* Generic, PCI class code for AHCI */
>         { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> -         0x010601, 0xffffff, board_ahci },
> +         PCI_CLASS_STORAGE_SATA<<8|1, 0xffffff, board_ahci },
>
>         { }     /* terminate list */
>  };
> @@ -1586,11 +1586,11 @@
>                 speed_s = "?";
>
>         pci_read_config_word(pdev, 0x0a, &cc);
> -       if (cc == 0x0101)
> +       if (cc == PCI_CLASS_STORAGE_IDE)
>                 scc_s = "IDE";
> -       else if (cc == 0x0106)
> +       else if (cc == PCI_CLASS_STORAGE_SATA)
>                 scc_s = "SATA";
> -       else if (cc == 0x0104)
> +       else if (cc == PCI_CLASS_STORAGE_RAID)
>                 scc_s = "RAID";
>         else
>                 scc_s = "unknown";
> diff -Nur linux-2.6.20-rc1.orig/include/linux/pci_ids.h
> linux-2.6.20-rc1/include/linux/pci_ids.h
> --- linux-2.6.20-rc1.orig/include/linux/pci_ids.h       2006-12-20
> 10:24:51.000000000 +0800
> +++ linux-2.6.20-rc1/include/linux/pci_ids.h    2006-12-20 10:08:15.000000000 +0800
> @@ -15,6 +15,7 @@
>  #define PCI_CLASS_STORAGE_FLOPPY       0x0102
>  #define PCI_CLASS_STORAGE_IPI          0x0103
>  #define PCI_CLASS_STORAGE_RAID         0x0104
> +#define PCI_CLASS_STORAGE_SATA         0x0106
>  #define PCI_CLASS_STORAGE_SAS          0x0107
>  #define PCI_CLASS_STORAGE_OTHER                0x018
>


or, pls see this one:
------------------------
diff -Nur linux-2.6.20-rc1.orig/drivers/ata/ahci.c
linux-2.6.20-rc1/drivers/ata/ahci.c
--- linux-2.6.20-rc1.orig/drivers/ata/ahci.c	2006-12-20 10:25:00.000000000 +0800
+++ linux-2.6.20-rc1/drivers/ata/ahci.c	2006-12-20 11:45:45.000000000 +0800
@@ -418,7 +418,7 @@

 	/* Generic, PCI class code for AHCI */
 	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-	  0x010601, 0xffffff, board_ahci },
+	  PCI_CLASS_STORAGE_SATA_AHCI, 0xffffff, board_ahci },

 	{ }	/* terminate list */
 };
@@ -1586,11 +1586,11 @@
 		speed_s = "?";

 	pci_read_config_word(pdev, 0x0a, &cc);
-	if (cc == 0x0101)
+	if (cc == PCI_CLASS_STORAGE_IDE)
 		scc_s = "IDE";
-	else if (cc == 0x0106)
+	else if (cc == PCI_CLASS_STORAGE_SATA)
 		scc_s = "SATA";
-	else if (cc == 0x0104)
+	else if (cc == PCI_CLASS_STORAGE_RAID)
 		scc_s = "RAID";
 	else
 		scc_s = "unknown";
diff -Nur linux-2.6.20-rc1.orig/include/linux/pci_ids.h
linux-2.6.20-rc1/include/linux/pci_ids.h
--- linux-2.6.20-rc1.orig/include/linux/pci_ids.h	2006-12-20
10:24:51.000000000 +0800
+++ linux-2.6.20-rc1/include/linux/pci_ids.h	2006-12-20 11:45:07.000000000 +0800
@@ -15,6 +15,8 @@
 #define PCI_CLASS_STORAGE_FLOPPY	0x0102
 #define PCI_CLASS_STORAGE_IPI		0x0103
 #define PCI_CLASS_STORAGE_RAID		0x0104
+#define PCI_CLASS_STORAGE_SATA		0x0106
+#define PCI_CLASS_STORAGE_SATA_AHCI	0x010601
 #define PCI_CLASS_STORAGE_SAS		0x0107
 #define PCI_CLASS_STORAGE_OTHER		0x0180


BTW, the 2 patches above are just my suggestion, not formal patch. If
either of them is acceptible, I will send out a formal patch. Thanks!

Conke
