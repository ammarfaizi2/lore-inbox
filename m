Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316488AbSE3UvZ>; Thu, 30 May 2002 16:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSE3UvY>; Thu, 30 May 2002 16:51:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7867 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316488AbSE3UvX>;
	Thu, 30 May 2002 16:51:23 -0400
Date: Thu, 30 May 2002 13:35:55 -0700 (PDT)
Message-Id: <20020530.133555.51807197.davem@redhat.com>
To: lilbilchow@yahoo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: is pci_alloc_consistent() really consistent on a pentium?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020530204406.55023.qmail@web13808.mail.yahoo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Chow <lilbilchow@yahoo.com>
   Date: Thu, 30 May 2002 13:44:06 -0700 (PDT)

   If IA32 builds use the i386 version of
   pci_alloc_consistent(), how is the memory provided by
   this function really write-thru (on a pentium) since
   it appears to only set up the default mapping
   (PCD/PWT==0)? In contrast, pgprot_noncached() and
   pci_mmap_page_range() explicitly set these bits on a
   pentium (i.e. when boot_cpu_data.x86 > 3). Or am I
   missing something?

pci_mmap_page_range maps I/O memory, like frame buffers and
device registers.

pci_alloc_consistent promises only that CPU writes will be coherent
with PCI device DMA activity.  For Pentium this holds true with all
normal ram, because once the cpu does the store coherent transactions
on the system bus (from, for example, the PCI device) will take a hit
on the L2 cache line of the cpu and thus the cpu will provide the most
up to date copy of the data.
