Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbRBWVJo>; Fri, 23 Feb 2001 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130293AbRBWVJe>; Fri, 23 Feb 2001 16:09:34 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:45068 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130267AbRBWVJX>; Fri, 23 Feb 2001 16:09:23 -0500
Date: Fri, 23 Feb 2001 13:09:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac15
In-Reply-To: <20010223214057.A22808@athlon.random>
Message-ID: <Pine.LNX.4.10.10102231306140.21515-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Feb 2001, Andrea Arcangeli wrote:
> 
> I think that can't happen. Infact I think the whole section:
> 
> 		pmd = pmd_offset(pgd, address);
> 		pmd_k = pmd_offset(pgd_k, address);
> 
> 		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
> 			goto bad_area_nosemaphore;
> 		set_pmd(pmd, *pmd_k);
> 		return;
> 
> is superflows.

No. Think about the differences in PAE and non-PAE mode. 

> The middle pagetable is shared and the pmd_t entry is set by vmalloc itself (it
> just points to the as well shared pte), it's only the pgd that is setup lazily

In non-PAE mode, the pgd entry doesn't exist. pgd_present() returns a
unconditional 1. Its' the pmd functions that kick in then.

		Linus

