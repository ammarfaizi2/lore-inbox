Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbREaPd3>; Thu, 31 May 2001 11:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbREaPdU>; Thu, 31 May 2001 11:33:20 -0400
Received: from comverse-in.com ([38.150.222.2]:10437 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S261715AbREaPdR>; Thu, 31 May 2001 11:33:17 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678F08@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Jeff Garzik'" <jgarzik@mandrakesoft.com>,
        "'Martin Mares'" <pci-ids@ucw.cz>, Keith Owens <kaos@ocs.com.au>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Linus Torvalds'" <torvalds@transmeta.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.4.x: update for PCI vendor id 0x12d4
Date: Thu, 31 May 2001 11:31:52 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> 
> > "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com> wrote:
> > >What I don't understand is why pci_ids.h doesn't get
> > >generated from pci.ids as well.
> 
> Although they are similar, you cannot reliably generate useable C
> constants from english words in the PCI id list...

I agree. Still, right now the update of the 2 is independant. Do you think
that 
merging the C constant names (with the common prefix stripped)
into the PCI id list so that there's a single source to control it would be
better? 

It's also possible to apply an heuristic to only store "exception" C names 
there - just take the 1st word and make it uppercase:

pci.ids:
1043  Asustek Computer, Inc.

would automatically map into what it is now:
pci_ids.h
#define PCI_VENDOR_ID_ASUSTEK		0x1043

whereas for 0x1042 one would have to change in the pci.ids: 
1042  Micron
	1000  FDC 37C665
	1001  37C922
	3000  Samurai_0
	3010  Samurai_1
	3020  Samurai_IDE

into
1042{PCTECH}  Micron
	1000{RZ1000}  FDC 37C665
	1001{RZ1001}  37C922
	3000  Samurai_0
	3010  Samurai_1
	3020  Samurai_IDE

to generate in the .h
#define PCI_VENDOR_ID_PCTECH		0x1042
#define PCI_DEVICE_ID_PCTECH_RZ1000	0x1000
#define PCI_DEVICE_ID_PCTECH_RZ1001	0x1001
#define PCI_DEVICE_ID_PCTECH_SAMURAI_0	0x3000
#define PCI_DEVICE_ID_PCTECH_SAMURAI_1	0x3010
#define PCI_DEVICE_ID_PCTECH_SAMURAI_IDE 0x3020

You get the idea... This way it is also very easy to look up the .ids file
and see instantly where the names mismatch severely.

Does this make sense? If you think it does (say so), I can easily make this
into the tree of your choice in a backward-compatible way. There'll be an
option to generate the older .ids, too, for easier merge back into the 2.2
series.

Vassilii
P.S. Even if you don't think the merge of the 2 files is worth it, don't
forget to apply the 12d4 patch...	
