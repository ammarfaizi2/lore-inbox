Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313558AbSEUMY3>; Tue, 21 May 2002 08:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSEUMY2>; Tue, 21 May 2002 08:24:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3273 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313558AbSEUMY2>;
	Tue, 21 May 2002 08:24:28 -0400
Date: Tue, 21 May 2002 05:10:31 -0700 (PDT)
Message-Id: <20020521.051031.56144279.davem@redhat.com>
To: paulus@samba.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Make 2.5.17 TLB even more friendlier
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15594.15138.312494.817676@argo.ozlabs.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Paul Mackerras <paulus@samba.org>
   Date: Tue, 21 May 2002 22:18:42 +1000 (EST)

   I still need tlb_end_vma in this case - or at least I need a hook
   that gets called after all the tlb_remove_tlb_entry calls are done but
   before clear_page_tables is called.  If I had that hook (called in
   both the exit_mmap and unmap cases) then I would not need the
   tlb_start/end_vma hooks.
   
You get called via pte_free_tlb() and pmd_free_tlb() for every
operation performed by clear_page_tables().  The PTEs themselves are
all cleared out at the point that clear_page_tables, so you can't
possibly need the PTE contents.  I am assuming therefore you just
need to get at the linkage, and those two pte/pmd hooks give you
that.


