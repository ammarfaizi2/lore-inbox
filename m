Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWBFW02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWBFW02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWBFW02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:26:28 -0500
Received: from cantor2.suse.de ([195.135.220.15]:41680 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932397AbWBFW02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:26:28 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: OOM behavior in constrained memory situations
Date: Mon, 6 Feb 2006 23:25:56 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, pj@sgi.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.62.0602061253020.18594@schroedinger.engr.sgi.com> <200602062222.28630.ak@suse.de> <Pine.LNX.4.62.0602061415560.18919@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602061415560.18919@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602062325.57140.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 23:16, Christoph Lameter wrote:
> On Mon, 6 Feb 2006, Andi Kleen wrote:
> 
> > At least remnants from my old 80% hack to avoid this (huge_page_needed)
> > seem to be still there in mainline:
> > 
> > fs/hugetlbfs/inode.c:hugetlbfs_file_mmap
> > 
> >    bytes = huge_pages_needed(mapping, vma);
> >    if (!is_hugepage_mem_enough(bytes))
> >           return -ENOMEM;
> > 
> > 
> > So something must be broken if this doesn't work. Or did you allocate
> > the pages in some other way? 
> 
> huge pages are now allocated in the huge fault handler. If it would be 
> returning an OOM then the OOM killer may be activated.

Sorry Christoph - somehow I have the feeling we're miscommunicating already
all day.

Of course they are allocated in the huge fault handler. But the point
of that check is to check first if there are enough pages free and 
fail the allocation early, just to catch the easy mistakes (has 
races, that is why I called it a 80% solution) Just like
Linux mmap traditionally worked and still does if you don't enable
the strict overcommit checking.

-Andi
