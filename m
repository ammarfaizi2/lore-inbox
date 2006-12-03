Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936660AbWLCEY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936660AbWLCEY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 23:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936661AbWLCEY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 23:24:26 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:54937 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S936660AbWLCEY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 23:24:26 -0500
Date: Sat, 2 Dec 2006 20:24:41 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Matthijs <thotter@gmail.com>, Anatoli Antonovitch <antonovi@ati.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bad PCI function mask in atiixp driver (was: Re: Linux 2.6.19)
Message-Id: <20061202202441.434bc62a.randy.dunlap@oracle.com>
In-Reply-To: <200612022309_MC3-1-D3AF-ED27@compuserve.com>
References: <200612022309_MC3-1-D3AF-ED27@compuserve.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006 23:06:57 -0500 Chuck Ebbert wrote:

> In-Reply-To: <4571D9FE.2050107@gmail.com>
> 
> On Sat, 02 Dec 2006 20:54:38 +0100, Matthijs wrote:
> 
> > make modules gives me these warnings in modpost and then errors out:
> > WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05
> 
> Message is from scripts/file2alias.c::do_pci_entry():
> 
>         if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
>             || (subclass_mask != 0 && subclass_mask != 0xFF)
>             || (interface_mask != 0 && interface_mask != 0xFF)) {
>                 warn("Can't handle masks in %s:%04X\n",
>                      filename, id->class_mask);
>                 return 0;
>         }
> 
> and it is complaining about this recent addition to atiixp.c:
> 
> @@ -348,6 +368,7 @@ static struct pci_device_id atiixp_pci_t
>         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>         { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> +       { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID, PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},
>         { 0, },
>  };
>  MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
> -- 

http://lkml.org/lkml/2006/11/01/199

However, I'm still dubious.

---
~Randy
