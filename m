Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292907AbSCEMBo>; Tue, 5 Mar 2002 07:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292914AbSCEMBe>; Tue, 5 Mar 2002 07:01:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47232 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S292907AbSCEMB0>;
	Tue, 5 Mar 2002 07:01:26 -0500
Date: Tue, 05 Mar 2002 03:59:14 -0800 (PST)
Message-Id: <20020305.035914.55508499.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does kmalloc always return address below 4GB?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200203051152.DAA05010@adam.yggdrasil.com>
In-Reply-To: <200203051152.DAA05010@adam.yggdrasil.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Tue, 5 Mar 2002 03:52:14 -0800
   
   | If you acquired your memory via the page allocator
   | (i.e. __get_free_page*()) or the generic memory allocators
   | (i.e. kmalloc() or kmem_cache_alloc()) then you may DMA to/from
   | that memory using the addresses returned from those routines.
   
   	It might be a good idea to rephrase it.  If I knew what that
   sentence I would propose a patch to the DMA-mapping.txt file, but I
   honestly don't know what proposition that sentence is supposed
   to convey.  If there really is no guarantee that this sentence is
   conveying, then I guess the sentence should be deleted.

Probably it should qualify what it means with "and you used
GFP_KERNEL".  Because that was the intention.

I'll fix that.

However, you can use GFP_HIGH memory with pci_map_page _iff_
you set your DMA mask to allow 64-bits.

The original impetus for that quoted bit of DMA-mapping.txt
was to make sure nobody used vmalloc() or kmap() pointers.
