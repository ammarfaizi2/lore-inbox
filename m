Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292520AbSCELNQ>; Tue, 5 Mar 2002 06:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292582AbSCELNG>; Tue, 5 Mar 2002 06:13:06 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:53192 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S292520AbSCELNA>; Tue, 5 Mar 2002 06:13:00 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 5 Mar 2002 03:12:52 -0800
Message-Id: <200203051112.DAA03159@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Does kmalloc always return address below 4GB?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I am trying to convert linux-2.5.6-pre2/drivers/scsi/advansys.c
to the DMA mapping system described in Documenation/DMA-mapping.txt
in an effort to try to help to make all of the drivers compile again.
I have a question that would help me with this process, and probably
others who has occasion to fiddle with any of the many devices covered
by this question.

	According to DMA-mapping.txt, I am allowed to use use
an address returned from kmalloc as a DMA address, without
need to convert by pci_map_single or allocate space with
pci_alloc_consistent.  The advansys.c hardware (and probably
many PCI devices) asssumes 32-bit addresses.  Can I rely on
on all architectures that support PCI or ISA that kmalloc
will always return an address below 2**32 if GFP_HIGHMEM
is not specified?  If not, then I guess I can use
pci_alloc_consistent and pci_map_single as necessary, since they
should can potentially know that I am using a device that
only understands 32-bit addresses, from my earlier call to
pci_set_dma_mask.  However, I assume that it is considered
simpler and therefore better to avoid these routines when possible.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
