Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTIBVXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTIBVXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:23:02 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55434 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261292AbTIBVWz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:22:55 -0400
Date: Tue, 2 Sep 2003 22:20:56 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, rusty@rustcorp.com.au, mingo@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-ID: <20030902212056.GA16805@mail.jlokier.co.uk>
References: <20030902065144.GC7619@mail.jlokier.co.uk> <Pine.LNX.4.44.0309021626540.1542-100000@localhost.localdomain> <20030902195427.GA15262@mail.jlokier.co.uk> <20030902131537.53d02113.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902131537.53d02113.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jamie Lokier <jamie@shareable.org> wrote:
> >
> > 	3. For (vma & VM_SHARED), look up futex_qs keyed on
> > 	   (vma->vm_file, vma->vm_pgoff + (uaddr - vma->vm_start) >>
> > 	   PAGE_SHIFT, offset).
> 
> That's a bit meaningless in non-linear mappings.

You think it's worth supporting futexes on non-linear mappings?
I see your point of view; they could be useful.

In that case, the (vma & VM_SHARED) case needs to look up the correct
pgoff or page after all.

It might be worth a VM_NONLINEAR flag, to skip walking the page table
in the non-linear case, but that's just an optimisation.

-- Jamie

