Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbSAEBP0>; Fri, 4 Jan 2002 20:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286198AbSAEBPP>; Fri, 4 Jan 2002 20:15:15 -0500
Received: from elin.scali.no ([62.70.89.10]:31751 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S286196AbSAEBOz>;
	Fri, 4 Jan 2002 20:14:55 -0500
Message-ID: <3C3651E4.777EABA@scali.no>
Date: Sat, 05 Jan 2002 02:07:48 +0100
From: Steffen Persvold <sp@scali.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-ac18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tommy Reynolds <reynolds@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Short question about the mmap method
In-Reply-To: <3C360FD5.91285F5D@scali.no> <20020104145949.682d51c4.reynolds@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Reynolds wrote:
> 
> Uttered "Steffen Persvold" <sp@scali.no>, spoke thus:
> 
> > Hi lkml readers,
> >
> > I have a question regarding drivers implementing the mmap and nopage methods.
> > In some references I've read that pages in kernel allocated memory (either
> > allocated with kmalloc, vmalloc or__get_free_pages) should be set to reserved
> > (mem_map_reserve or set_bit(PG_reserved, page->flags) before they can be
> > mmap'ed to guarantee that they can't be swapped out. Is this true ?
> 
> [kv]malloc memory is _never_ subject to paging and can be mmap'ed with a
> vengeance without resorting to mucking about with marking pages or the like.
> 
> You're working too hard ;-)
> 

OK, thanks. But I found out that if you want to use remap_page_range on kmalloc'ed memory you need
to set the reserve bit first. Without it, it just doesn't work. When using the nopage method no
reserving is necessary.


What about my question regarding locking the mm spinlock table before traversing the page table (for
vmalloc'ed memory). Any ideas there ?

Regards,
-- 
  Steffen Persvold   | Scalable Linux Systems |   Try out the world's best   
 mailto:sp@scali.no  |  http://www.scali.com  | performing MPI implementation:
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6   |      - ScaMPI 1.12.2 -         
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY   | >300MBytes/s and <4uS latency
