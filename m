Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270984AbUJUWDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270984AbUJUWDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271010AbUJUWBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:01:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47789 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270984AbUJUWA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:00:27 -0400
Date: Thu, 21 Oct 2004 15:00:14 -0700
Message-Id: <200410212200.i9LM0EWM023663@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include all vmas with unbacked pages in ELF core dumps
In-Reply-To: Linus Torvalds's message of  Thursday, 21 October 2004 13:01:44 -0700 <Pine.LNX.4.58.0410211259400.2145@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: well, why *shouldn't* you pay property taxes on your editor?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On Thu, 21 Oct 2004, Hugh Dickins wrote:
> > 
> > 	if (!vma->anon_vma)
> > 		return 0;
> 
> Ok. So the end result ends up pretty simple:
> 
> 	static int maydump(struct vm_area_struct *vma)
> 	{
> 	        /* Do not dump I/O mapped devices, shared memory, or special mappings */        
> 	        if (vma->vm_flags & (VM_IO | VM_SHARED | VM_RESERVED))
> 	                return 0;
> 
> 	        /* If it hasn't been written to, don't write it out */
> 	        if (!vma->anon_vma)
> 	                return 0;
> 
> 	        return 1;
> 	}
> 
> does this make everybody happy?

I expect that has the same result as my patch (which tested vma->vm_file
instead of vma->vm_flags & VM_SHARED).  It produces the same good results
on the simple tests I've done (for glibc's RELRO segments).


Thanks,
Roland
