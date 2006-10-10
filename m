Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWJJMqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWJJMqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWJJMql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:46:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:15318 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964809AbWJJMql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:46:41 -0400
Subject: Re: ptrace and pfn mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Nick Piggin <npiggin@suse.de>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061010123128.GA23775@infradead.org>
References: <20061009140354.13840.71273.sendpatchset@linux.site>
	 <20061009140447.13840.20975.sendpatchset@linux.site>
	 <1160427785.7752.19.camel@localhost.localdomain>
	 <452AEC8B.2070008@yahoo.com.au>
	 <1160442987.32237.34.camel@localhost.localdomain>
	 <20061010123128.GA23775@infradead.org>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 22:42:15 +1000
Message-Id: <1160484135.6177.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think the best idea is to add a new ->access method to the vm_operations
> that's called by access_process_vm() when it exists and VM_IO or VM_PFNMAP
> are set.   ->access would take the required object locks and copy out the
> data manually.  This should work both for spufs and drm.

Another option is to have access_process_vm() lookup the PTE and lock it
while copying the data from the page.

something like

	- lookup pte & lock
	- check if pte still present
	- copy data to temp kernel buffer
	- unlock pte
	- copy data to user buffer

Ben.

