Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSFZQpB>; Wed, 26 Jun 2002 12:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316678AbSFZQpA>; Wed, 26 Jun 2002 12:45:00 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:30633 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S316673AbSFZQo7>; Wed, 26 Jun 2002 12:44:59 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Larry Sendlosky'" <Larry.Sendlosky@storigen.com>,
       "'lkml'" <linux-kernel@vger.kernel.org>
Subject: RE: DMA from high memory regions
Date: Wed, 26 Jun 2002 09:43:22 -0700
Message-ID: <004301c21d30$969c5a20$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <7BFCE5F1EF28D64198522688F5449D5A03BFD8@xchangeserver2.storigen.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Many thanks for the reply. It sure works and I noticed that code in
pci_map_page() api. Previously I was using kernel 2.4.2 fron RedHat7.1 which
has no such kernel function.
Now, if I need to access that page in my device driver, how can I get kernel
virtual address without using kmap?

Thanks,
Imran.

-----Original Message-----
From: Larry Sendlosky [mailto:Larry.Sendlosky@storigen.com]
Sent: Wednesday, June 26, 2002 6:33 AM
To: imran.badr@cavium.com
Subject: RE: DMA from high memory regions


There is no need to kmap.

1) call map_user_kiobuf to make sure buffer is mapped and pages
   are not swapped.

2) call lock_kiovec to lock the pages for I/O

3) use the struct page pointers in the kiobuf maplist
   to compute physical page address of each page.
   eg  ((struct_page_pointer - mem_map) << PAGE_SHIFT)   is physical
   address of the page described by 'struct page *struct_page_pointer'.

   You now have the physical addresses needed to give to the device
   for DMA.


-----Original Message-----
From: Imran Badr [mailto:imran.badr@cavium.com]
Sent: Tuesday, June 25, 2002 7:30 PM
To: 'lkml'
Subject: DMA from high memory regions


Hi,

I am trying to setup DMA to/from user space. I get a user pointer in my
device driver, from which I build up kiobuf and call map_user_kiobuf. After
this, I call kmap to map pages to kernel virtual space and then virt_to_bus
to get bus address. Now if I define CONFIG_HIGHMEM and that page happens to
be in the memory region near 1GB then DMA never happens and I donot see any
data in result pointer. If CONFIG_HIGHMEM is not defined, then everything
works perfectly. Please suggest any solution.

Thanks,
Imran.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

