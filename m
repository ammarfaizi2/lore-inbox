Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751992AbWJJCsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbWJJCsi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbWJJCsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:48:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:55502 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751992AbWJJCsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:48:38 -0400
Subject: Re: ptrace and pfn mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061010022310.GC15822@wotan.suse.de>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
	 <20061009140447.13840.20975.sendpatchset@linux.site>
	 <1160427785.7752.19.camel@localhost.localdomain>
	 <452AEC8B.2070008@yahoo.com.au>
	 <1160442987.32237.34.camel@localhost.localdomain>
	 <20061010022310.GC15822@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 12:47:46 +1000
Message-Id: <1160448466.32237.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Switch the mm and do a copy_from_user? (rather than the GUP).
> Sounds pretty ugly :P
> 
> Can you do a get_user_pfns, and do a copy_from_user on the pfn
> addresses? In other words, is the memory / mmio at the end of a
> given address the same from the perspective of any process? It
> is for physical memory of course, which is why get_user_pages
> works...

Doesn't help with the racyness.

> > That means that the ptracing process will temporarily be running in the
> > kernel using a task->active_mm different from task->mm which might have
> > funny side effects due to assumptions that this won't happen here or
> > there, though I don't see any fundamental reasons why it couldn't be
> > made to work.
> > 
> > That do you guys think ? Any better idea ? The problem with mappings
> > like what SPUfs or the DRM want is that they can change (be remapped
> > between HW and backup memory, as described in previous emails), thus we
> > don't want to get struct pages even if available and peek at them as
> > they might not be valid anymore, same with PFNs (we could imagine
> > ioremap'ing those PFN's but that would be racy too). The only way that
> > is guaranteed not to be racy is to do exactly what a user do, that is do
> > user accesses via the target process vm itself....
> 
> What if you hold your per-object lock over the operation? (I guess
> it would have to nest *inside* mmap_sem, but that should be OK).

Over the ptrace operation ? how so ?

Ben.


