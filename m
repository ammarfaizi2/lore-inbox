Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbTFOGhd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 02:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFOGhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 02:37:33 -0400
Received: from dp.samba.org ([66.70.73.150]:31886 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261411AbTFOGhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 02:37:32 -0400
Date: Sun, 15 Jun 2003 16:51:02 +1000
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Roland McGrath <roland@redhat.com>, davidm@hpl.hp.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: FIXMAP-related change to mm/memory.c
Message-ID: <20030615065102.GD31148@krispykreme>
References: <16105.28970.526326.249287@napali.hpl.hp.com> <200306130656.h5D6uGc32359@magilla.sf.frob.com> <20030613001517.5413e511.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030613001517.5413e511.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >  			static struct vm_area_struct fixmap_vma = {
> >   				/* Catch users - if there are any valid
> >   				   ones, we can make this be "&init_mm" or
> >   				   something.  */
> >   				.vm_mm = NULL,
> >  -				.vm_start = FIXADDR_START,
> >  -				.vm_end = FIXADDR_TOP,
> >  +				.vm_start = FIXADDR_USER_START,
> >  +				.vm_end = FIXADDR_USER_END,
> >   				.vm_page_prot = PAGE_READONLY,
> >   				.vm_flags = VM_READ | VM_EXEC,
> >   			};
> 
> Note that the current version of this code does not compile for User Mode
> Linux.  Its FIXADDR_TOP is not a constant.   It would be nice to fix that
> this time around.
> 
> It appears that this patch will break x86_64, parisc and um.

Its a problem on ppc64 too. I want to put the signal trampolines into
a fixmap area above the stack, ie different places on 32bit and 64bit
executables.

Anton
