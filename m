Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269566AbUIZPjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269566AbUIZPjk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 11:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269567AbUIZPjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 11:39:40 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:38877 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269566AbUIZPji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 11:39:38 -0400
Date: Sun, 26 Sep 2004 17:39:28 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all set_pte must be written in asm
Message-ID: <20040926153928.GV3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random> <1096155207.475.40.camel@gaston> <20040926002037.GP3309@dualathlon.random> <1096159487.18234.64.camel@gaston> <20040926013200.GT3309@dualathlon.random> <1096176535.18235.293.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096176535.18235.293.camel@gaston>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 03:29:48PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2004-09-26 at 11:32, Andrea Arcangeli wrote:
> 
> > maybe I'm biased because I'm reading x86-64 code, but where? the
> > software mkdirty and mkyoung seem to all be inside the page_table_lock.
> 
> ppc and ppc64 who treat their hash table as a kind of big tlb cache, and
> embedded ppc's with software loaded TLBs all have the TLB or hash refill
> mecanism "mimmic" a HW TLB load, that is it is assembly code that will
> set the DIRTY or ACCESSED bits without taking the page table lock

ok, I thought you were talking about common code setting the dirty and
accessed bit. The x86 architecture in hardware as well sets dirty and
accessed bit, without the page table lock.

> Oh, I side-tracked a bit on the need to make the PTE update & hash flush
> atomic on ppc64 using the per-PTE lock _PAGE_BUSY bit we have there if
> we ever implement that lockless do_page_fault(), but that was a side

agreed.

> discussion, sorry for confusion.

No problem.

> Right, in your hypotetical scenario, I'd just have to make sure an std
> instruction is generated on ppc64 

exactly.
