Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270925AbUJUUDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270925AbUJUUDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270818AbUJUUDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:03:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:40371 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270841AbUJUUCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:02:01 -0400
Date: Thu, 21 Oct 2004 13:01:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include all vmas with unbacked pages in ELF core dumps
In-Reply-To: <Pine.LNX.4.44.0410211939570.12985-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0410211259400.2145@ppc970.osdl.org>
References: <Pine.LNX.4.44.0410211939570.12985-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Oct 2004, Hugh Dickins wrote:
> 
> 	if (!vma->anon_vma)
> 		return 0;

Ok. So the end result ends up pretty simple:

	static int maydump(struct vm_area_struct *vma)
	{
	        /* Do not dump I/O mapped devices, shared memory, or special mappings */        
	        if (vma->vm_flags & (VM_IO | VM_SHARED | VM_RESERVED))
	                return 0;

	        /* If it hasn't been written to, don't write it out */
	        if (!vma->anon_vma)
	                return 0;

	        return 1;
	}

does this make everybody happy?

Do the core-files blow up a lot from this? Or does it miss some case?

		Linus
