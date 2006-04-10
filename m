Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWDJTFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWDJTFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbWDJTFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:05:44 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:28036 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S932110AbWDJTFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:05:43 -0400
Date: Mon, 10 Apr 2006 14:05:18 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC/PATCH] Shared Page Tables [1/2]
Message-ID: <C7A8E6F316A73810A5FF466E@[10.1.1.4]>
In-Reply-To: <1144695296.31255.16.camel@localhost.localdomain>
References: <1144685591.570.36.camel@wildcat.int.mccr.org>
 <1144695296.31255.16.camel@localhost.localdomain>
X-Mailer: Mulberry/4.0.0b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Monday, April 10, 2006 11:54:56 -0700 Dave Hansen
<haveblue@us.ibm.com> wrote:

>> Complete the macro definitions for pxd_page/pxd_page_kernel 
> 
> Could you explain a bit why these are needed for shared page tables?

The existing definitions define pte_page and pmd_page to return the struct
page for the pfn contained in that entry, and pmd_page_kernel returns the
kernel virtual address of it.  However, pud_page and pgd_page are defined
to return the kernel virtual address.  There are no macros that return the
struct page.

No one actually uses any of the pud_page and pgd_page macros (other than
one reference in the same include file).  After some discussion on the list
the last time I posted the patches, we agreed that changing pud_page and
pgd_page to be consistent with pmd_page is the best solution.  We also
agreed that I should go ahead and propagate that change across all
architectures even though not all of them currently support shared page
tables.  This patch is the result of that work.

Dave McCracken



