Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbTACOtT>; Fri, 3 Jan 2003 09:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267539AbTACOtT>; Fri, 3 Jan 2003 09:49:19 -0500
Received: from f39.sea2.hotmail.com ([207.68.165.39]:8200 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267530AbTACOtQ>;
	Fri, 3 Jan 2003 09:49:16 -0500
X-Originating-IP: [218.75.193.47]
From: "fretre lewis" <fretre3618@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: question about pci code
Date: Fri, 03 Jan 2003 14:57:42 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F39TBBbtUAZWahZI7TY0000abab@hotmail.com>
X-OriginalArrivalTime: 03 Jan 2003 14:57:42.0928 (UTC) FILETIME=[77CD5100:01C2B338]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi,all

  I am reading code about pci, and I can't understand some lines in
pci_check_direct(), in arch/i386/kernel/pci-pc.c

well, I wonder why "outb (0x01, 0xCFB);" if check configuration type 1 ? and 
why
"outb (0x00, 0xCFB);" if check configuration type 2?

please help me,thanks a lot

406 static struct pci_ops * __devinit pci_check_direct(void)
407 {
408         unsigned int tmp;
409         unsigned long flags;
410
411         __save_flags(flags); __cli();
412
413         /*
414          * Check if configuration type 1 works.
415          */
416         if (pci_probe & PCI_PROBE_CONF1) {
417                 outb (0x01, 0xCFB);
418                 tmp = inl (0xCF8);
419                 outl (0x80000000, 0xCF8);
420                 if (inl (0xCF8) == 0x80000000 &&
421                     pci_sanity_check(&pci_direct_conf1)) {
422                         outl (tmp, 0xCF8);
423                         __restore_flags(flags);
424                         printk(KERN_INFO "PCI: Using configuration type 
1\n");
425                         request_region(0xCF8, 8, "PCI conf1");
426                         return &pci_direct_conf1;
427                 }
428                 outl (tmp, 0xCF8);
429         }
430
431         /*
432          * Check if configuration type 2 works.
433          */
434         if (pci_probe & PCI_PROBE_CONF2) {
435                 outb (0x00, 0xCFB);
436                 outb (0x00, 0xCF8);
437                 outb (0x00, 0xCFA);
438                 if (inb (0xCF8) == 0x00 && inb (0xCFA) == 0x00 &&
439                     pci_sanity_check(&pci_direct_conf2)) {
440                         __restore_flags(flags);
441                         printk(KERN_INFO "PCI: Using configuration type 
2\n");
442                         request_region(0xCF8, 4, "PCI conf2");
443                         return &pci_direct_conf2;
444                 }
445         }
446
447         __restore_flags(flags);
448         return NULL;
449 }
450
451 #endif





_________________________________________________________________
MSN 8 helps eliminate e-mail viruses. Get 2 months FREE* 
http://join.msn.com/?page=features/virus

