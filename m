Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWDUIDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWDUIDs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWDUIDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:03:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932248AbWDUIDq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:03:46 -0400
Date: Fri, 21 Apr 2006 01:02:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: npiggin@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-Id: <20060421010244.2f36821c.akpm@osdl.org>
In-Reply-To: <20060421074156.GM21660@wotan.suse.de>
References: <20060301045901.12434.54077.sendpatchset@linux.site>
	<20060301045910.12434.4844.sendpatchset@linux.site>
	<20060421002938.3878aec5.akpm@osdl.org>
	<20060421074156.GM21660@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> > 
> > - are vma->vm_start and vma->vm_end always a multiple of PAGE_SIZE?  (I
> >   always forget).  If not, remap_valloc_range() looks a tad buggy.
> 
> I hope so.

do_mmap_pgoff() seems to dtrt.  It makes one wonder why vm_start and vm_end
aren't in units of PAGE_SIZE.

> > 
> > - remap_valloc_range() would lose a whole buncha typecasts if you use the
> >   gcc pointer-arith-with-void* extension.
> 
> Should I?

Well it's a gccism, and a good one.  We have lots of gccisms and using this
one here will neaten things up.
