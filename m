Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbTLPRsP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 12:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTLPRre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 12:47:34 -0500
Received: from imag.imag.fr ([129.88.30.1]:56201 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262040AbTLPRqV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 12:46:21 -0500
Date: Tue, 16 Dec 2003 18:37:53 +0100
Subject: Re: PCI lib for 2.4 //kwds: pci, dma, mapping memory, kernel vs. user-space.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>
To: Peter Chubb <peter@chubb.wattle.id.au>
From: =?ISO-8859-1?Q?Damien_Courouss=E9?= <damien.courousse@imag.fr>
In-Reply-To: <16350.12846.591123.874866@wombat.chubb.wattle.id.au>
Message-Id: <93DFAFF4-2FEE-11D8-92AC-000393C76BFA@imag.fr>
Content-Transfer-Encoding: 8BIT
X-Mailer: Apple Mail (2.552)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thanks for your answer.

% 2 pci.h files %
I had a look at example code that comes with libpci.a. Actually, that's 
what I had done since that's the only way I may do it.

I did not yet understand why I find two differents pci.h files, and why 
I cannot use one of them (since my compiler can't link with the lib)... 
Is there a specific way of using the second one, which I did not 
understand?

I work on RedHat 8, kernel 2.4.18-14
- pci.h No 1 is in /usr/include/pci , linked with /usr/include/linux 
 >>> the one I can use

- No 2 is in /usr/src/linux2.4.18-14/include/linux >>> the one I can't 
use, but I'd like to.


% dma support %
It should be OK like that, but my driver will have to support dma 
features... and I don't have available functions to do it, since I may 
not use pci.h file Number 2.
Do I have any other solution?


% mapping memory %
It seems I have many(?) ways for mapping memory, depending if the 
driver will be in kernel or user-space:
- I could use 'ioremap', but it seems to be designed for kernel-driver. 
And that's again the same thing, since I cannot use it. My <asm/io.h> 
file does not support it. (ugh?) I think I should find it here, as all 
documentation I found says that.
- I may use mmap too.

% kernel/user-space %
I have to develop a driver for a card designed for data-acquisition. 
The stream of data will have to be as fast as possible, since the card 
will have to support high data-rates.
What is the best, do  you think, to develop a driver. Should I do it in 
kernel or user-space? I mean, it seems that kernel accesses cost many 
CPU resources, whereas in user-space, I could have better performances 
if kernel accesses are limited...

Damien




Le lundi, 15 déc 2003, à 23:14 Europe/Paris, Peter Chubb a écrit :

>>>>>> "Damien" == Damien Courouss <Damien> writes:
>
> Damien> Hi, Actually, it will be first a user-space driver.
>
> Damien> Maybe I wasn't clear:
>
> The user-space libpci.a has headers in /usr/include/pci/pci.h
> Do #include <pci/pci.h> to get at them.
> On debian, at least, you need the pciutils-dev package.
> Unfortunately, there are no manual pages (yet?)
>
> And *do* look at the example code that comes with libpci.a
>
> pci_resource_start() and so on are kernel functions; you get the same
> info in a different way using libpci.a -- Look at the source of lspci
> to see what you can do.
>
> (In brief:
>         struct pci_access *pacc;
>         struct pci_dev *dev;
>
> 	pacc = pci_alloc();
>
>         pci_init(pacc);
>         pci_scan_bus(pacc);
>         for (dev = pacc->devices; dev; dev = dev->next)
>         {
>                 if (dev->vendor_id == PCI_VENDOR_ID_AAA &&
>                     dev->device_id == PCI_DEVICE_ID_AAA_BBB)
>                     break;
>         }
>         if (dev == NULL){
>                 fprintf(stderr, "No AAA BBB device\n");
> 		exit(1);
> 	}
>
>         pciconf = xmalloc(sizeof *pciconf);
>         pciconf->pciconfig.accesstype = PCI_CONFIG;
>         pciconf->pciconfig.devp = dev;
>
>         pci_fill_info(dev, PCI_FILL_IDENT | PCI_FILL_BASES | 
> PCI_FILL_IRQ);
>
>         /*
>          * Get the first 64-bytes of config space
>          */
>         pci_read_block(dev, 0, config, 64);
> )
>
> --
> Dr Peter Chubb  http://www.gelato.unsw.edu.au  peterc AT 
> gelato.unsw.edu.au
> The technical we do immediately,  the political takes *forever*
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

