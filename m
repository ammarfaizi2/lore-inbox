Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424833AbWLCEMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424833AbWLCEMZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 23:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424842AbWLCEMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 23:12:25 -0500
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:25764 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1424833AbWLCEMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 23:12:25 -0500
Date: Sat, 2 Dec 2006 23:06:57 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Bad PCI function mask in atiixp driver (was: Re: Linux
  2.6.19)
To: Matthijs <thotter@gmail.com>
Cc: Anatoli Antonovitch <antonovi@ati.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200612022309_MC3-1-D3AF-ED27@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <4571D9FE.2050107@gmail.com>

On Sat, 02 Dec 2006 20:54:38 +0100, Matthijs wrote:

> make modules gives me these warnings in modpost and then errors out:
> WARNING: Can't handle masks in drivers/ide/pci/atiixp:FFFF05

Message is from scripts/file2alias.c::do_pci_entry():

        if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
            || (subclass_mask != 0 && subclass_mask != 0xFF)
            || (interface_mask != 0 && interface_mask != 0xFF)) {
                warn("Can't handle masks in %s:%04X\n",
                     filename, id->class_mask);
                return 0;
        }

and it is complaining about this recent addition to atiixp.c:

@@ -348,6 +368,7 @@ static struct pci_device_id atiixp_pci_t
        { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
        { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
        { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+       { PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP600_SATA, PCI_ANY_ID, PCI_ANY_ID, (PCI_CLASS_STORAGE_IDE<<8)|0x8a, 0xffff05, 1},
        { 0, },
 };
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
-- 
Chuck
"Even supernovas have their duller moments."
