Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSEUMUJ>; Tue, 21 May 2002 08:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSEUMUI>; Tue, 21 May 2002 08:20:08 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:24798 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S313416AbSEUMUI>;
	Tue, 21 May 2002 08:20:08 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.15138.312494.817676@argo.ozlabs.ibm.com>
Date: Tue, 21 May 2002 22:18:42 +1000 (EST)
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <20020520.230750.83973189.davem@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> The next part is allowing for a "full_mm_flush" state such that
> tlb_flush() can make decisions based upon that.  Then we move
> the tlb_{start,end}_vma() invocations one level up.  So for
> the exit_mmap case it is:
> 
> 	tlb_gather_mmu(mm, 1);
> 
> 	flush_cache_mm(mm);
> 
> 	for each vma {
> 		...
> 		unmap_page_range(...);
> 	}
> 
> 	clear_page_tables();
> 	tlb_finish_mmu();

I still need tlb_end_vma in this case - or at least I need a hook
that gets called after all the tlb_remove_tlb_entry calls are done but
before clear_page_tables is called.  If I had that hook (called in
both the exit_mmap and unmap cases) then I would not need the
tlb_start/end_vma hooks.

Regards,
Paul.
