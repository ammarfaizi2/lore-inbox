Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266738AbRGFPkT>; Fri, 6 Jul 2001 11:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266740AbRGFPkJ>; Fri, 6 Jul 2001 11:40:09 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:32447 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S266738AbRGFPkB>;
	Fri, 6 Jul 2001 11:40:01 -0400
Message-ID: <3B45DBCD.76B27634@mandrakesoft.com>
Date: Fri, 06 Jul 2001 11:39:57 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steffen Persvold <sp@scali.no>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Helge Hafting <helgehaf@idb.hist.no>,
        Vasu Varma P V <pvvvarma@techmas.hcltech.com>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: DMA memory limitation?
In-Reply-To: <E15ITTf-0004Dz-00@the-village.bc.nu> <3B45A08D.408D56@mandrakesoft.com> <3B45D656.440A34A9@scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold wrote:
> > pci_alloc_* is designed to support ISA.
> >
> > Pass pci_dev==NULL to pci_alloc_* for ISA devices, and it allocs GFP_DMA
> > for you.

> Sure, but the IA64 platforms that are out now doesn't have an IOMMU, so bounce buffers are
> used if you don't specify GFP_DMA in your get_free_page.
[...]
> (pci_alloc_consistent() allocates a buffer with GFP_DMA on IA64),

The important thing is that pci_alloc_consistent and the other PCI DMA
functions work as advertised on IA64.  If you pass NULL to
pci_alloc_consistent, IA64 should give you an ISA DMA-able address.  If
you don't, you get a 32-bit PCI DMA address.  Use of GFP_DMA is a
arch-specific detail, so don't let me confuse you there.

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
