Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbTDBXpu>; Wed, 2 Apr 2003 18:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbTDBXpu>; Wed, 2 Apr 2003 18:45:50 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:62709 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S263216AbTDBXpt>; Wed, 2 Apr 2003 18:45:49 -0500
Date: Thu, 3 Apr 2003 00:59:09 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <linux-mm@kvack.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
In-Reply-To: <110950000.1049326945@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0304030053240.1279-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Apr 2003, Dave McCracken wrote:
> --On Wednesday, April 02, 2003 15:38:45 -0800 Andrew Morton
> <akpm@digeo.com> wrote:
> 
> > But:
> > 
> > +	/* Double check to make sure the pte page hasn't been freed */
> > +	if (!pmd_present(*pmd))
> > +		goto out_unmap;
> > +
> > 	==> munmap, pte page is freed, reallocated for pagecache, someone
> > 	    happens to write the correct value into it.
> > 	
> > +	if (page_to_pfn(page) != pte_pfn(*pte))
> > +		goto out_unmap;
> > +
> > +	if (addr)
> > +		*addr = address;
> > +
> 
> Oops.  The pmd_present() check should be after the page_to_pfn() !=
> pte_pfn() check.

No, you're forgetting that the case Andrew rightly indicates is
covered by the ptecount check I added to page_convert_anon, and
commented at length there.  As I said yesterday, I don't think
this "Double check" on *pmd serves any real purpose as coded
(whereas the earlier "Double check" on *pgd is vital).

Hugh

