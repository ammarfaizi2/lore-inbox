Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWARB1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWARB1d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWARB1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:27:33 -0500
Received: from fmr22.intel.com ([143.183.121.14]:32683 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964774AbWARB1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:27:33 -0500
Message-Id: <200601180127.k0I1R8g18386@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Robin Holt'" <holt@sgi.com>, "Dave McCracken" <dmccr@us.ibm.com>
Cc: "Hugh Dickins" <hugh@veritas.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
Subject: RE: [PATCH/RFC] Shared page tables
Date: Tue, 17 Jan 2006 17:27:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYbwWz7YMGPOQ4DQsm63GMRaRD+1wADCOag
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <20060117235302.GA22451@lnx-holt.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote on Tuesday, January 17, 2006 3:53 PM
> This appears to work on ia64 with the attached patch.  Could you
> send me any test application you think would be helpful for me
> to verify it is operating correctly?  I could not get the PTSHARE_PUD
> to compile.  I put _NO_ effort into it.  I found the following line
> was invalid and quit trying.
> 
> --- linux-2.6.orig/arch/ia64/Kconfig	2006-01-14 07:16:46.149226872 -0600
> +++ linux-2.6/arch/ia64/Kconfig	2006-01-14 07:25:02.228853432 -0600
> @@ -289,6 +289,38 @@ source "mm/Kconfig"
>  config ARCH_SELECT_MEMORY_MODEL
>  	def_bool y
>  
> +
> +config PTSHARE_HUGEPAGE
> +	bool
> +	depends on PTSHARE && PTSHARE_PMD
> +	default y
> +

You need to thread carefully with hugetlb ptshare on ia64. PTE for
hugetlb page on ia64 observe full page table levels, not like x86
that sits in the pmd level.

- Ken

