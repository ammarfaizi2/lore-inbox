Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279257AbRJ2MOn>; Mon, 29 Oct 2001 07:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279243AbRJ2MOd>; Mon, 29 Oct 2001 07:14:33 -0500
Received: from protactinium.btinternet.com ([194.73.73.176]:53206 "EHLO
	protactinium") by vger.kernel.org with ESMTP id <S279250AbRJ2MO1>;
	Mon, 29 Oct 2001 07:14:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jeff <je4d@pobox.com>
Reply-To: je4d@pobox.com
To: linux-kernel@vger.kernel.org
Subject: Problem with VT82c686(a) chipset (acpi quirks)
Date: Mon, 29 Oct 2001 12:14:20 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15yBJm-0003n6-00@protactinium>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary:
The kernel appears to e calling the wrong quirk, or the quirk dosent work as 
it should. the quirk that is being called is quirk_vt82c686_acpi, causing an 
address space collision

Detail:
Im using 2.4.13-ac2 at the moment, but the problem is unchanged when i use 
anyhting recent(2.4.7, 2.4.12).

It's a Compaq EvoN150 laptop, and appears to have a VIA Appolo PLE133
("http://www.via.com.tw/jsp/en/products/apollo/ple133.jsp") chipset. (Compaq 
tech. support told me it had a VT8601 (northbridge) in it, and a VT82C686A 
(southbridge) in it, chipsets listed at "http://www.viaarena.com/?PageID=14" 
(they also said it had a fdc37m869 super io (?))).
Anyway..
i got an address space collision from it. heres the relevent (i thing) dmesg, 
after i compiled with DBG on in pci.c, pcisetup-res.c, 
arch/i386/kernel/pci-i386.h => pci-pc.c, quirks.c:
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/0601] 000600 00
PCI: Calling quirk c010dc30 for 00:00.0
Found 00:08 [1106/8601] 000604 01
PCI: Calling quirk c010dc30 for 00:01.0
Found 00:38 [1106/0686] 000601 00
PCI: Calling quirk c010dc30 for 00:07.0
Found 00:39 [1106/0571] 000101 00
PCI: Calling quirk c010dc30 for 00:07.1
PCI: IDE base address fixup for 00:07.1
Found 00:3a [1106/3038] 000c03 00
PCI: Calling quirk c010dc30 for 00:07.2
Found 00:3c [1106/3057] 000680 00
PCI: Calling quirk c010dc30 for 00:07.4
PCI: Calling quirk c03469d0 for 00:07.4
PCI: Address space collision on region 9 of device VIA Technologies, Inc. 
VT82C686 [Apollo Super ACPI] [8080:808f] 
PCI: Calling quirk c0346a80 for 00:07.4
Found 00:3d [1106/3058] 000401 00

I also run a kernel before with an output statment in 
kernel/resource.c line 119 outputing confilct->name to find the conflicting 
device, which was VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

If anyone can help with this, plz email me je4d@pobox.com, and do likewise if 
u need/want any more info.

Many Thanks
        - Jeff
