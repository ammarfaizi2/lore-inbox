Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136482AbREIORI>; Wed, 9 May 2001 10:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136484AbREIOQ7>; Wed, 9 May 2001 10:16:59 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:32786 "HELO
	zcamail04.zca.compaq.com") by vger.kernel.org with SMTP
	id <S136482AbREIOQr>; Wed, 9 May 2001 10:16:47 -0400
Message-ID: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDE0@aeoexc1.aeo.cpqcorp.net>
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "'andrea@suse.de'" <andrea@suse.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: [BUG] memory mngt > 2 Gbytes and DMA for the Alpha? pci_iommu.c
Date: Wed, 9 May 2001 16:12:41 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi lkml,

There is likely a bug in the management of memory above two Gigabytes and
DMA in kernel 2.4.4
(up to ac-6) with the alpha. :-(

My hardware is: an Alphaserver ES40 with 4 Cpus and 8 Gigabytes of RAM,
myrinet 2k board, SCSI,
3Com905b ethernet, DE600 ethernet and Qlogic Fiber Channel board.

The Fiber Chanel, the myrinet board and any of the two Ethernet boards all
have troubles working with 
such a big RAM.

They all produce pci_map_sg_failed errors on the logs before totally
crashing the system under load.
(That is not totally right, sometime I don't get anything into the
logs.....)

When I say under load I mean telnet is working with ethernet but massive ftp
is freezing the box.
For the Fiber Channel storage, everything is fine with little files, but
massive dd lead to freezing the box.


BUT

When I boot the system with mem=2048M, everything is back... network,
storage...

and at last, memory crunching C code (allocation,read and write to larger
and larger buffers) 
works fine with the whole RAM.



My understanding is that when the PCI boards want to switch to high
throughtput they go for DMA
and DMA is not working correctly with memory above 2 GBytes. 

The Error message comes from arch/alpha/pci_iommu.c. 

Do you think that makes sense ? What else could I do to help finding the bug
?

Thks for any help

----------------------------------------------------------------------------
--
Sebastien CABANIOLS
COMPAQ France 
HPTC Engineer
CustomSystems & Solutions  Annecy  
High Performance Technical Computing 
Office No.  +33 (0)4 50 09 44 10
Fax No.  +33 (0)4 50 64 01 39 
Email.   sebastien.cabaniols@compaq.com 
----------------------------------------------------------------------------
--

  
