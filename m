Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267402AbUHDUO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbUHDUO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUHDUO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:14:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:16087 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267402AbUHDUOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:14:10 -0400
From: Pat Gefre <pfg@sgi.com>
Message-Id: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com>
Subject: Altix I/O code reorganization
To: linux-ia64@vger.kernel.org
Date: Wed, 4 Aug 2004 15:14:08 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We have reorganized the I/O layer in the Altix code.

We are posting this code for review before submitting for inclusion in
the 2.5 tree.

The patch set is at: ftp://oss.sgi.com/projects/sn2/sn2-update/

It is based off the http://lia64.bkbits.net/to-linus-2.5 tree


The general changes are:
o added new hardware support
o code cleanup (typedefs, include files, etc.)
o simplified the directory structure (all files were arch/ia64/sn/io/
   are now under arch/ia64/sn/ioif/)
o code size reduced by >50%
o major reorg of the code itself
o copyright updates


The patches and a short comment for each:

001-deleted-files
#    contains all the files that are no longer needed

002-pci-fixup
#   The io_init.c file replaces the pci_bus_cvlink.c. A diff of the files
#   would not make much sense as the functionalities provided in pci_bus_cvlink.c
#   are no longer needed. The new functions needed are:
#
#        1. Getting Platform Specific Information for PCI Buses/Devices.
#        2. Getting Hardware Workaround Information.
#        3. Getting I/O Hub Information.
#
#   The io_init.c file basically contains all the routines that are needed to
#   allow a PCI Device Driver to perform Interrupts, PIOs and DMAs.

003-pci-support
#   There are some minor changes in these files. The biggest change is that we have
#   broken up the SN Platform Specific DMA mapping interfaces into 3 different
#   routines:
#
#        1.  32Bit Direct Mapping.
#        2.  32Bit PMU Mapping.
#        3.  64Bit Direct Mapping.
#
#   The SN Platform has 3 different PCI/PCIX Bridges. They are not all exactly the
#   same, however they do provide the same functionality. We have abstracted
#   the DMA mapping calls so that the caller will not have to be aware of the
#   hardware differences. Example:
#
#        *dma_handle = (*provider->dmatrans_direct64)(pcidev_info, phys_addr,
#                                  PCIIO_DMA_CMD | PCIIO_DMA_A64);
#
#   The Bus Driver for this card, determines the appropriate method.
#

004-pci-bridge-drivers
#   This set of new files supports 2 of our 3 PCI Bridges, PIC and TIOCP.
#   pcibr_dma.c is new and provides the PCI DMA Mapping routines.
#   pcibr_sal_interfaces.c is new and provides the SAL Interfaces.
#   pcibr_provider.c is new and defines the Chipset specific Provider Tables.
#
#   The rest of the file changes are mostly cleanup.

005-klconfig
#   Moved a file, but mostly cleanup

006-bte
#   Changes needed to remove hwgraph

007-io-hub-provider
#   Files needed to provide services for our I/O Hub devices

008-kdb-support-functions
#   KDB support functions

009-misc-sources
#   code cleanup
#   ran thru Lindent
#   changes needed for new I/O structure

010-new-includes
#   New includes with definitions for PCI devices, buses, and I/O hubs

011-misc-include-changes
#   code cleanup
#   misc changes needed for new I/O structure
