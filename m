Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVAYQ6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVAYQ6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 11:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVAYQ6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 11:58:38 -0500
Received: from ozlabs.org ([203.10.76.45]:11909 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261978AbVAYQ60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 11:58:26 -0500
Date: Wed, 26 Jan 2005 03:57:45 +1100
From: Anton Blanchard <anton@samba.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: akpm@osdl.org, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       spyro@f2s.com
Subject: Re: [PATCH] Use MM_VM_SIZE in exit_mmap
Message-ID: <20050125165745.GA27433@krispykreme.ozlabs.ibm.com>
References: <20050125142210.GI5920@krispykreme.ozlabs.ibm.com> <20050125164642.GA17927@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125164642.GA17927@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I don't really like it in general when we do
> 
> #define MAYBE_CONST_LOOKING_THING      (some_func())
> 
> I would almost rather see something like task_size(current) used.

I dont particularly like it, but it would be better for that to be a
separate cleanup patch. I want to maximise my changes of this going in
soon :)

> > ===== include/linux/mm.h 1.212 vs edited =====
> > +++ edited/include/linux/mm.h	2005-01-26 01:20:12 +11:00
> > @@ -38,7 +38,7 @@
> >  #include <asm/atomic.h>
> >  
> >  #ifndef MM_VM_SIZE
> > -#define MM_VM_SIZE(mm)	TASK_SIZE
> > +#define MM_VM_SIZE(mm)	((TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK)
> >  #endif
> >  
> >  #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> ia64 asm/processor.h already has:
> 
> #define DEFAULT_TASK_SIZE       __IA64_UL_CONST(0xa000000000000000)
> [...]
> #define MM_VM_SIZE(mm)          DEFAULT_TASK_SIZE
> 
> So I think this will generate a warning there?

Im confused. It does? 

Anton
