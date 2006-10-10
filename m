Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWJJDn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWJJDn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 23:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWJJDn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 23:43:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:56015 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964927AbWJJDn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 23:43:26 -0400
Subject: Re: ptrace and pfn mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061010030344.GF15822@wotan.suse.de>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
	 <20061009140447.13840.20975.sendpatchset@linux.site>
	 <1160427785.7752.19.camel@localhost.localdomain>
	 <452AEC8B.2070008@yahoo.com.au>
	 <1160442987.32237.34.camel@localhost.localdomain>
	 <20061010022310.GC15822@wotan.suse.de>
	 <1160448466.32237.59.camel@localhost.localdomain>
	 <1160448968.32237.68.camel@localhost.localdomain>
	 <20061010030344.GF15822@wotan.suse.de>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 13:42:55 +1000
Message-Id: <1160451775.32237.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hold your per-object lock? I'm not talking about using mmap_sem for
> migration, but the per-object lock in access_process_vm. I thought
> this prevented migration?

As I said in my previous mail. access_process_vm() is a generic function
called by ptrace, it has 0 knowledge of the internal locking scheme of
a driver providing a nopage/nopfn for a vma.

> OK, just do one pfn at a time. For ptrace that is fine. access_process_vm
> already copies from source into kernel buffer, then kernel buffer into
> target.

Even one pfn at a time ... the only way would be if we also took the PTE
lock during the copy in fact. That's the only lock that would provide
that same guarantees as an access I think.

Ben.


