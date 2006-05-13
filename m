Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWEMMxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWEMMxx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWEMMxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:53:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:62645 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932415AbWEMMxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:53:52 -0400
X-Authenticated: #14349625
Subject: Re: swapping and oom-killer: gfp_mask=0x201d2, order=0
From: Mike Galbraith <efault@gmx.de>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200605131511.05723.a1426z@gawab.com>
References: <200605111514.45503.a1426z@gawab.com>
	 <200605121517.59988.a1426z@gawab.com> <1147447913.7520.6.camel@homer>
	 <200605131511.05723.a1426z@gawab.com>
Content-Type: text/plain
Date: Sat, 13 May 2006 14:54:07 +0200
Message-Id: <1147524848.9829.20.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 15:11 +0300, Al Boldi wrote:
> Mike Galbraith wrote:
> > On Fri, 2006-05-12 at 15:17 +0300, Al Boldi wrote:
> > > Note that this is not specific to mem=8M, but rather a general oom
> > > observation even for mem=4G, where it is only much later to occur.
> >
> > An oom situation with 4G ram would be more interesting than this one.
> 
> Agreed, but can you tell me what readahead has to do with this oom?
> 
> oom-killer: gfp_mask=0x201d2, order=0
>  [<c013ff25>] out_of_memory+0xa5/0xc0
>  [<c0141099>] __alloc_pages+0x279/0x310
>  [<c0143669>] __do_page_cache_readahead+0xe9/0x120
>  [<c0143b3f>] max_sane_readahead+0x2f/0x50
>  [<c013d8cb>] filemap_nopage+0x2eb/0x370
>  [<c0149ea5>] do_no_page+0x65/0x220
>  [<c014a1dc>] __handle_mm_fault+0xec/0x200
>  [<c0113258>] do_page_fault+0x188/0x5c5
>  [<c01130d0>] do_page_fault+0x0/0x5c5
>  [<c0103a0f>] error_code+0x4f/0x54

Nothing except that it asked for a page at a bad time, triggering the
bad-hair-day reaction.  That being said, the readahead allocation mask
should have probably included GFP_NORETRY.  (though with 8MB, if the
readahead didn't get you, the subsequent read probably would anyway)

	-Mike

