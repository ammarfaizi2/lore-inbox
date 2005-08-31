Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbVHaPjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbVHaPjO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVHaPjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:39:13 -0400
Received: from dvhart.com ([64.146.134.43]:63622 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S964842AbVHaPjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:39:12 -0400
Date: Wed, 31 Aug 2005 08:39:13 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Dave McCracken <dmccr@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] Implement shared page tables
Message-ID: <19490000.1125502753@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.61.0508311557190.17726@goblin.wat.veritas.com>
References: <7C49DFF721CB4E671DB260F9@[10.1.1.4]><Pine.LNX.4.61.0508311143340.15467@goblin.wat.veritas.com><1125489077.3213.12.camel@laptopd505.fenrus.org><Pine.LNX.4.61.0508311437070.16834@goblin.wat.veritas.com><16640000.1125498711@[10.10.2.4]> <Pine.LNX.4.61.0508311557190.17726@goblin.wat.veritas.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> They're incompatible, but you could be left to choose one or the other
>> via config option.
> 
> Wouldn't need config option: there's /proc/sys/kernel/randomize_va_space
> for the whole running system, compatibility check on the ELFs run, and
> the infinite stack rlimit: enough ways to suppress randomization if it
> doesn't suit you.

Even better - much easier to deal with distro stuff if we can do it at
runtime.
 
>> 3% on "a certain industry-standard database benchmark" (cough) is huge,
>> and we expect the benefit for PPC64 will be larger as we can share the
>> underlying hardware PTEs without TLB flushing as well.
> 
> Okay - and you're implying that 3% comes from _using_ the shared page
> tables, rather than from avoiding the fork/exit overhead of setting
> them up and tearing them down.  And it can't use huge TLB pages
> because...  fragmentation?

Yes - as I understand it, that was a straight measurement with/without the
patch, and the shmem segment was already using hugetlb (in both cases). 
Yes, I find that a bit odd as to why as well - they are still trying 
to get some detailed profiling to explain. 

M.

