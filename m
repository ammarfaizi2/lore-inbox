Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTLOWOg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbTLOWOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:14:36 -0500
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:20660 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264257AbTLOWOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:14:32 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16350.12846.591123.874866@wombat.chubb.wattle.id.au>
Date: Tue, 16 Dec 2003 09:14:06 +1100
To: =?ISO-8859-1?Q?Damien_Courouss=E9?= <damien.courousse@imag.fr>
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
Subject: Re: PCI lib for 2.4
In-Reply-To: <6414C79D-2EED-11D8-82D9-000393C76BFA@imag.fr>
References: <16348.59126.537876.178991@wombat.chubb.wattle.id.au>
	<6414C79D-2EED-11D8-82D9-000393C76BFA@imag.fr>
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Damien" == Damien Courouss <Damien> writes:

Damien> Hi, Actually, it will be first a user-space driver.

Damien> Maybe I wasn't clear:

The user-space libpci.a has headers in /usr/include/pci/pci.h
Do #include <pci/pci.h> to get at them.
On debian, at least, you need the pciutils-dev package.
Unfortunately, there are no manual pages (yet?)

And *do* look at the example code that comes with libpci.a

pci_resource_start() and so on are kernel functions; you get the same
info in a different way using libpci.a -- Look at the source of lspci
to see what you can do.

(In brief:
        struct pci_access *pacc;
        struct pci_dev *dev;

	pacc = pci_alloc();

        pci_init(pacc);
        pci_scan_bus(pacc);
        for (dev = pacc->devices; dev; dev = dev->next)
        {
                if (dev->vendor_id == PCI_VENDOR_ID_AAA &&
                    dev->device_id == PCI_DEVICE_ID_AAA_BBB)
                    break;
        }
        if (dev == NULL){
                fprintf(stderr, "No AAA BBB device\n");
		exit(1);
	}
        
        pciconf = xmalloc(sizeof *pciconf);
        pciconf->pciconfig.accesstype = PCI_CONFIG;
        pciconf->pciconfig.devp = dev;

        pci_fill_info(dev, PCI_FILL_IDENT | PCI_FILL_BASES | PCI_FILL_IRQ); 

        /*
         * Get the first 64-bytes of config space
         */
        pci_read_block(dev, 0, config, 64);
)

--
Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT gelato.unsw.edu.au
The technical we do immediately,  the political takes *forever*
