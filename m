Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267182AbRGPCN6>; Sun, 15 Jul 2001 22:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbRGPCNs>; Sun, 15 Jul 2001 22:13:48 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:64772 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S267182AbRGPCNj>; Sun, 15 Jul 2001 22:13:39 -0400
Message-ID: <3B524DCD.3C6D6187@delusion.de>
Date: Mon, 16 Jul 2001 04:13:33 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-ac4
In-Reply-To: <20010716004933.A18030@lightning.swansea.linux.org.uk> <3B524B36.A9F926CC@delusion.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Udo A. Steinberg" wrote:
> 
> Alan Cox wrote:
> 
> > 2.4.6-ac4
> > o       Update VIA southbridge bug fix to VIA provided  (me)
> >         workaround.
> >         | Except we apply it even when no sblive is
> >         | present
> 
> 
> I have a VIA 686a chipset and the workaround is being enabled nonetheless.
> I guess that's not quite correct. ac3 did the right thing, ac4 doesn't.

I kinda see why (relevant part of -ac4 patch):
The underlined piece won't ever execute, and the range doesn't reflect the
comment above.


+       p=pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, NULL);
+       if(p!=NULL)
+       {
+               pci_read_config_byte(p, PCI_CLASS_REVISION, &rev);
+               /* 0x40 - 0x4f == 686B, 0x10 - 0x2f == 686A; thanks Dan Hollis
+               /* Check for buggy part revisions */
+               if (rev < 0x40 && rev > 0x42)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+                       return;
+       }
+       else
+       {
+               p = pci_find_device(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231, NULL);
+               if(p==NULL)     /* No problem parts */
+                       return;
+               pci_read_config_byte(p, PCI_CLASS_REVISION, &rev);
+               /* Check for buggy part revisions */
+               if (rev < 0x10 && rev > 0x12)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+                       return;
+       }
