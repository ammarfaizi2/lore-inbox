Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbSJVTPc>; Tue, 22 Oct 2002 15:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261641AbSJVTPc>; Tue, 22 Oct 2002 15:15:32 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:51774 "EHLO
	baldur.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262006AbSJVTPb>; Tue, 22 Oct 2002 15:15:31 -0400
Date: Tue, 22 Oct 2002 14:21:18 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Bill Davidsen <davidsen@tmr.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
Message-ID: <188940000.1035314478@baldur.austin.ibm.com>
In-Reply-To: <407130000.1035313347@flay>
References: <Pine.LNX.3.96.1021022135649.7820C-100000@gatekeeper.tmr.com>
 <407130000.1035313347@flay>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Tuesday, October 22, 2002 12:02:27 -0700 "Martin J. Bligh"
<mbligh@aracnet.com> wrote:


>> I'm just trying to decide what this might do for a news server with
>> hundreds of readers mmap()ing a GB history file. Benchmarks show the 2.5
>> has more latency the 2.4, and this is likely to make that more obvious.
> 
> On the other hand, I don't think shared pagetables have an mmap hook,
> though that'd be easy enough to add. And if you're not reading the whole 
> history file, presumably the PTEs will only be sparsely instantiated
> anyway.

Actually shared page tables work on any shared memory area, no matter how
it was created.  When a page fault occurs and there's no pte page already
allocated (the common case for any newly mapped region) it checks the vma
to see if it's shared.  If it's shared, it gets the address_space for that
vma, then walks through all the shared vmas looking for one that's mapped
at the same address and offset and already has a pte page that can be
shared.

So if your history file is mapped at the same address for all your
processes then it will use shared page tables.  While it might be a nice
add-on to allow sharing if they're mapped on the same pte page boundary,
that doesn't seem likely enough to justify the extra work.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

