Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRLGMrn>; Fri, 7 Dec 2001 07:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278428AbRLGMri>; Fri, 7 Dec 2001 07:47:38 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:29428 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S279313AbRLGMrV>;
	Fri, 7 Dec 2001 07:47:21 -0500
Date: Fri, 7 Dec 2001 13:46:45 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Martin Eriksson <nitrax@giron.wox.org>
cc: "Calin A. Culianu" <calin@ajvar.org>,
        Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][highly-experimental] via-mwq (Was: Re: VIA acknowledges
 North Bridge bug...)
In-Reply-To: <006d01c17f09$f4d61ab0$0201a8c0@HOMER>
Message-ID: <Pine.GSO.4.30.0112071344040.142-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Dec 2001, Martin Eriksson wrote:

> I've (hastily) put these changes into "arch/i386/kernel/pci-pc.c" and had to
> modify "include/linux/pci_ids.h" too.
>
> The patch is included, but a warning: I have no VIA based computer that I
> can test this on myself...


I noticed one little typo:

[...]
+static void __init pci_fixup_via_kt266_athlon_bug(struct pci_dev *d)
+{
+	u8 v;
+	pci_read_config_byte(d, 0x95, &v);
+	if (v & 0xE0) {
+		printk("PCI: Disabling VIA VT8366 Memory Write Queue\n");
+		v &= 0x1f; /* clear bit 55.7, 6, 5 */
                                       ^^^^^
+		pci_write_config_byte(d, 0x95, v);
+	}
+}
+

It should also be 95 imho.

regards,
-- 
Balazs Pozsar

