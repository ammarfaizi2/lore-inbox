Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279641AbRJ2Xvl>; Mon, 29 Oct 2001 18:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279645AbRJ2Xvd>; Mon, 29 Oct 2001 18:51:33 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:28425 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S279641AbRJ2XvQ>;
	Mon, 29 Oct 2001 18:51:16 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15325.60263.576568.255244@cargo.ozlabs.ibm.com>
Date: Tue, 30 Oct 2001 10:51:03 +1100 (EST)
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029180837.F25434@redhat.com>
In-Reply-To: <20011029180837.F25434@redhat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise writes:

> The following:
> 
> @@ -50,7 +50,6 @@
>  
>         /* Don't look at this pte if it's been accessed recently. */
>         if (ptep_test_and_clear_young(page_table)) {
> -               flush_tlb_page(vma, address);
>                 mark_page_accessed(page);
>                 return 0;
>         }
> 
> is completely bogus.  Without the tlb flush, the system may never update 
> the accessed bit on a page that is heavily being used.

On PPC, the page wouldn't even need to be being heavily used.  Most
PPCs have an MMU hash table that we use as a level-2 cache for the
TLB.  With this change, we won't see the accessed bit being set again
for any page unless there is so much memory in use that we start
evicting PTEs from the hash table, and that is very rare in practice.

So I'm with Ben on this one.

Paul.

