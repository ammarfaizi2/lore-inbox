Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751995AbWJJC62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbWJJC62 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 22:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751996AbWJJC61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 22:58:27 -0400
Received: from ns2.suse.de ([195.135.220.15]:22401 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751995AbWJJC61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 22:58:27 -0400
Date: Tue, 10 Oct 2006 04:58:21 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: ptrace and pfn mappings
Message-ID: <20061010025821.GE15822@wotan.suse.de>
References: <20061009140354.13840.71273.sendpatchset@linux.site> <20061009140447.13840.20975.sendpatchset@linux.site> <1160427785.7752.19.camel@localhost.localdomain> <452AEC8B.2070008@yahoo.com.au> <1160442987.32237.34.camel@localhost.localdomain> <20061010022310.GC15822@wotan.suse.de> <1160448466.32237.59.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160448466.32237.59.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 12:47:46PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Switch the mm and do a copy_from_user? (rather than the GUP).
> > Sounds pretty ugly :P
> > 
> > Can you do a get_user_pfns, and do a copy_from_user on the pfn
> > addresses? In other words, is the memory / mmio at the end of a
> > given address the same from the perspective of any process? It
> > is for physical memory of course, which is why get_user_pages
> > works...
> 
> Doesn't help with the racyness.

I don't understand what the racyness is that you can solve by accessing
it from the target process's mm?

> > What if you hold your per-object lock over the operation? (I guess
> > it would have to nest *inside* mmap_sem, but that should be OK).
> 
> Over the ptrace operation ? how so ?

You just have to hold it over access_process_vm, AFAIKS. Once it
is copied into the kernel buffer that's done. Maybe I misunderstood
what the race is?
