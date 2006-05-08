Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbWEHTth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWEHTth (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 15:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWEHTth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 15:49:37 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33240 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750761AbWEHTtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 15:49:36 -0400
Message-ID: <445FA0CA.4010008@us.ibm.com>
Date: Mon, 08 May 2006 14:49:30 -0500
From: Brian Twichell <tbrian@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Dave McCracken <dmccr@us.ibm.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2][RFC] New version of shared page tables
References: <1146671004.24422.20.camel@wildcat.int.mccr.org> <Pine.LNX.4.64.0605031650190.3057@blonde.wat.veritas.com> <57DF992082E5BD7D36C9D441@[10.1.1.4]> <Pine.LNX.4.64.0605061620560.5462@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0605061620560.5462@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>Let me say (while perhaps others are still reading) that I'm seriously
>wondering whether you should actually restrict your shared pagetable work
>to the hugetlb case.  I realize that would be a disappointing limitation
>to you, and would remove the 25%/50% improvement cases, leaving only the
>3%/4% last-ounce-of-performance cases.
>
>But it's worrying me a lot that these complications to core mm code will
>_almost_ never apply to the majority of users, will get little testing
>outside of specialist setups.  I'd feel safer to remove that "almost",
>and consign shared pagetables to the hugetlb ghetto, if that would
>indeed remove their handling from the common code paths.  (Whereas,
>if we didn't have hugetlb, I would be arguing strongly for shared pts.)
>
Hi,

In the case of x86-64, if pagetable sharing for small pages was 
eliminated, we'd lose more than the 27-33% throughput improvement 
observed when the bufferpools are in small pages.  We'd also lose a 
significant chunk of the 3% improvement observed when the bufferpools 
are in hugepages.  This occurs because there is still small page 
pagetable sharing being achieved, minimally for database text, when the 
bufferpools are in hugepages.  The performance counters indicated that 
ITLB and DTLB page walks were reduced by 28% and 10%, respectively, in 
the x86-64/hugepage case.

To be clear, all measurements discussed in my post were performed with 
kernels config'ed to share pagetables for both small pages and hugepages.

If we had to choose between pagetable sharing for small pages and 
hugepages, we would be in favor of retaining pagetable sharing for small 
pages.  That is where the discernable benefit is for customers that run 
with "out-of-the-box" settings.  Also, there is still some benefit there 
on x86-64 for customers that use hugepages for the bufferpools.

Cheers,
Brian

