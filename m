Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVKGUpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVKGUpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVKGUpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:45:04 -0500
Received: from fmr21.intel.com ([143.183.121.13]:16363 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932316AbVKGUpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:45:01 -0500
Subject: RE: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Rohit Seth <rohit.seth@intel.com>
To: Adam Litke <agl@us.ibm.com>
Cc: Andy Nelson <andy@thermo.lanl.gov>, ak@suse.de, nickpiggin@yahoo.com.au,
       akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       gmaxwell@gmail.com, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       torvalds@osdl.org
In-Reply-To: <1131389934.25133.69.camel@localhost.localdomain>
References: <20051107003452.3A0B41855A0@thermo.lanl.gov>
	 <1131389934.25133.69.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel 
Date: Mon, 07 Nov 2005 12:51:01 -0800
Message-Id: <1131396662.18176.41.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Nov 2005 20:43:56.0106 (UTC) FILETIME=[F8C6FAA0:01C5E3DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 12:58 -0600, Adam Litke wrote:

> I am currently working on an new approach to what you tried.  It
> requires fewer changes to the kernel and implements the special large
> page usage entirely in an LD_PRELOAD library.  And on newer kernels,
> programs linked with the .x ldscript you mention above can run using all
> small pages if not enough large pages are available.
> 

Isn't it true that most of the times we'll need to be worrying about
run-time allocation of memory (using malloc or such) as compared to
static.

> For the curious, here's how this all works:
> 1) Link the unmodified application source with a custom linker script which
> does the following:
>   - Align elf segments to large page boundaries
>   - Assert a non-standard Elf program header flag (PF_LINUX_HTLB)
>     to signal something (see below) to use large pages.

We'll need a similar flag for even code pages to start using hugetlb
pages. In this case to keep the kernel changes to minimum, RTLD will
need to modified.

> 2) Boot a kernel that supports copy-on-write for PRIVATE hugetlb pages
> 3) Use an LD_PRELOAD library which reloads the PF_LINUX_HTLB segments into
> large pages and transfers control back to the application.
> 

COW, swap etc. are all very nice (little!) features that make hugetlb to
get used more transparently.

-rohit



