Return-Path: <linux-kernel-owner+w=401wt.eu-S964829AbWLTDNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964829AbWLTDNF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 22:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWLTDNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 22:13:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:44037 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964829AbWLTDND convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 22:13:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NQYM4Cvuk+NXvPI2Cavlif40lmS8reRXuYe/vKrHaZgWDUvomi51FqlmBCHDFwxgrVScM+26DQXL0L8lXWbq7vOC9+Mb24H45/w5WtusJOILCq+j9WjS+NQ79jdPRA0ir/Iw8IvHqcIJ0POQNj9bFhNexzplZteKEJbF5bIGMss=
Message-ID: <5767b9100612191913p29675249v18803c65f536bda4@mail.gmail.com>
Date: Wed, 20 Dec 2006 11:13:02 +0800
From: "Conke Hu" <conke.hu@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>, Alan <alan@lxorguk.ukuu.org.uk>,
       "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH] Add pci class code for SATA
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <45883E64.20400@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0612171409340.9120@localhost.localdomain>
	 <1166551886.2977.5.camel@localhost.localdomain>
	 <45883E64.20400@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/06, Jeff Garzik <jeff@garzik.org> wrote:
> Conke Hu wrote:
> > Add pci class code 0x0106 for SATA to pci_ids.h
> >
> > signed-off-by: conke.hu@gmail.com
> > --------------------
> > --- linux-2.6.20-rc1/include/linux/pci_ids.h.orig     2006-12-20
> > 01:58:30.000000000 +0800
> > +++ linux-2.6.20-rc1/include/linux/pci_ids.h  2006-12-20
> > 01:59:07.000000000 +0800
> > @@ -15,6 +15,7 @@
> >  #define PCI_CLASS_STORAGE_FLOPPY     0x0102
> >  #define PCI_CLASS_STORAGE_IPI                0x0103
> >  #define PCI_CLASS_STORAGE_RAID               0x0104
> > +#define PCI_CLASS_STORAGE_SATA               0x0106
> >  #define PCI_CLASS_STORAGE_SAS                0x0107
> >  #define PCI_CLASS_STORAGE_OTHER              0x0180
>
> Two comments:
>
> 1) I think "_SATA" is an inaccurate description.  It should be _AHCI AFAICS.
>
> 2) Typically we don't add constants unless they are used somewhere...
>
>         Jeff
>

Hi Jeff,
    According to PCI spec 3.0, 0x0106 means SATA controller, 0x010601
means AHCI and 0x010600 means vendor specific SATA controller. Pls see
the following table (PCI spec 3.0 P296):

Base Class 	Sub-Class 	Interface 	Meaning
--------------------------------------------------------
 		00h		00h 		SCSI bus controller
		------------------------------------------------
		01h 		xxh 		IDE controller
		-----------------------------------------------
		02h 		00h 		Floppy disk controller
		-----------------------------------------------------
		03h 		00h 		IPI bus controller
		--------------------------------------------------
		04h 		00h 		RAID controller
01h		------------------------------------------------
				20h 		ATA controller with ADMA interface
		05h		---------------------------------------------------
				30h 		ATA controller with ADMA interface
		-------------------------------------------------------------------
				00h 		Serial ATA controller–vendor specific interface
		06h		-----------------------------------------------------------------
		 		01h 		Serial ATA controller–AHCI 1.0 interface
		-------------------------------------------------------------------------
		07h 		00h 		Serial Attached SCSI (SAS) controller
		---------------------------------------------------------------------
		80h 		00h 		Other mass storage controller
------------------------------------------------------------------------------


So, I think, the following macro is correct:
#define PCI_CLASS_STORAGE_SATA               0x0106
If you would define AHCI class code, it should be 0x010601, not 0x0106:
#define PCI_CLASS_STORAGE_SATA_AHCI               0x010601

And, I think that PCI_CLASS_STORAGE_SATA had better be added to
pci_ids.h since the class code 0x0106 is used more than once. e.g.
ahci.c uses the magic number 0x0106 twice, and it might be used more
in future.

Best regards,
Conke
