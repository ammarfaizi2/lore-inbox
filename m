Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265371AbRF2BHZ>; Thu, 28 Jun 2001 21:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbRF2BHP>; Thu, 28 Jun 2001 21:07:15 -0400
Received: from [192.187.140.129] ([192.187.140.129]:30153 "EHLO paracel.com")
	by vger.kernel.org with ESMTP id <S265371AbRF2BHH>;
	Thu, 28 Jun 2001 21:07:07 -0400
From: "Christophe Beaumont" <christophe@paracel.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: [Q] mmap/munmap of physical address
Date: Thu, 28 Jun 2001 18:08:17 -0700
Message-ID: <NFBBINOGHMOOBMPNBAHKMEFLCEAA.christophe@paracel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am fighting with a little problem here.
I have reserved a chunk of physical memory for my personnal
use and out of the kernel scope (linux mem=1024M).
I have now to handle this reserved memory by myself with
a simple scheme (I need BIG contiguous memory chunks (over
64Megs, and only few of them).
My idea was to create a driver for that memory & mmap()
in it. So far so good, I can mmap() from user side, driver
works fine as far as remap_page_range() is concerned.
Now comes the freeing/unmapping of those regions. I have
implemented my personnal vm_operations_struct to take care
of house keeping....
BUT
the close(struct vm_area_struct *vma) only gives me back
a virtual address, and a call to virt_to_phys(vma->start)
doesn't point back to the physical address I gave when mmaping.
As I have multiple processes, I cannot associate (virt addr,
phys addr) [2 processes could have the same virt addr pointing
to 2 different physical areas].

I am wondering if there is something totally obvious I am
missing there in the process (i.e., is there unmap_page_range
taking the virtual address as input... ;)  )

Thanks in advance...


Christophe Beaumont

Sr Software Engineer                     Phone: 626-744-2078
Paracel, Inc.                              Fax: 626-744-2001
1055 East Colorado Blvd,   email: chris.beaumont@paracel.com
Pasadena, CA 91106-2341                 www: www.paracel.com



