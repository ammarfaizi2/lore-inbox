Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287471AbSAEDEP>; Fri, 4 Jan 2002 22:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287472AbSAEDEG>; Fri, 4 Jan 2002 22:04:06 -0500
Received: from elin.scali.no ([62.70.89.10]:39687 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S287471AbSAEDDz>;
	Fri, 4 Jan 2002 22:03:55 -0500
Message-ID: <3C366B70.DB1E9F0A@scali.no>
Date: Sat, 05 Jan 2002 03:56:48 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tommy Reynolds <reynolds@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Short question about the mmap method
In-Reply-To: <3C360FD5.91285F5D@scali.no> <20020104145949.682d51c4.reynolds@redhat.com> <3C3651E4.777EABA@scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold wrote:
> 
> Tommy Reynolds wrote:
> >
> > Uttered "Steffen Persvold" <sp@scali.no>, spoke thus:
> >
> > > Hi lkml readers,
> > >
> > > I have a question regarding drivers implementing the mmap and nopage methods.
> > > In some references I've read that pages in kernel allocated memory (either
> > > allocated with kmalloc, vmalloc or__get_free_pages) should be set to reserved
> > > (mem_map_reserve or set_bit(PG_reserved, page->flags) before they can be
> > > mmap'ed to guarantee that they can't be swapped out. Is this true ?
> >
> > [kv]malloc memory is _never_ subject to paging and can be mmap'ed with a
> > vengeance without resorting to mucking about with marking pages or the like.
> >
> > You're working too hard ;-)
> >

Another thing, when allocating memory with vmalloc, how can I be sure that the pages I get is
adressable within 4GB (i.e I wan't to call pci_map_sg on this buffer for my 32bit PCI device without
having to use bounce buffers ) ? On systems with less that 4GB of physical memory there's no
problem, but what happens if you have more (lets say an IA64 server with 16GB of RAM) and don't have
an IOMMU (like alpha and sparc) ?

I noticed a vmalloc_32 in linux/vmalloc.h (the comment says "32bit PA addressable pages - eg for PCI
32bit devices"), but is that one platform independent (I see that it is only using GFP_KERNEL, while
vmalloc is using GFP_KERNEL | __GFP_HIGHMEM) ? This issue goes for __get_free_pages too I guess.

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
