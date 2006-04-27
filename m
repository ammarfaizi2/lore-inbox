Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWD0Dt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWD0Dt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWD0Dt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:49:59 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:63876 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932354AbWD0Dt6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:49:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bxLMBz7z7PRAYMwm7NyT6krTAASpv0CEKaHLMqcpH038hvPFi4Vv1AVOPP0JzYElmoe8tsW56hpxpquPxoF/cVx8QugGC9Mmoq+gDYKTHIfIIUGGuTmSvGOsRshBCZEntI3y+Q3eBnNpIBhR8L8OiypAkA3e3AqrINtBrqaZL60=
Message-ID: <aec7e5c30604262049v3ae18915le415ee33b2f80fc4@mail.gmail.com>
Date: Thu, 27 Apr 2006 12:49:49 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Dave McCracken" <dmccr@us.ibm.com>
Subject: Re: [RFC/PATCH] Shared Page Tables [1/2]
Cc: "Dave Hansen" <haveblue@us.ibm.com>, "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
In-Reply-To: <C7A8E6F316A73810A5FF466E@10.1.1.4>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1144685591.570.36.camel@wildcat.int.mccr.org>
	 <1144695296.31255.16.camel@localhost.localdomain>
	 <C7A8E6F316A73810A5FF466E@10.1.1.4>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/06, Dave McCracken <dmccr@us.ibm.com> wrote:
> --On Monday, April 10, 2006 11:54:56 -0700 Dave Hansen
> <haveblue@us.ibm.com> wrote:
>
> >> Complete the macro definitions for pxd_page/pxd_page_kernel
> >
> > Could you explain a bit why these are needed for shared page tables?
>
> The existing definitions define pte_page and pmd_page to return the struct
> page for the pfn contained in that entry, and pmd_page_kernel returns the
> kernel virtual address of it.  However, pud_page and pgd_page are defined
> to return the kernel virtual address.  There are no macros that return the
> struct page.
>
> No one actually uses any of the pud_page and pgd_page macros (other than
> one reference in the same include file).  After some discussion on the list
> the last time I posted the patches, we agreed that changing pud_page and
> pgd_page to be consistent with pmd_page is the best solution.  We also
> agreed that I should go ahead and propagate that change across all
> architectures even though not all of them currently support shared page
> tables.  This patch is the result of that work.

What is the merge status of this patch?

I've written some generic page table creation code for kexec, but the
fact that pud_page() returns struct page * on i386 but unsigned long
on other architectures makes it hard to write clean generic code.

Any merge objections, or was this patch simply overlooked?

/ magnus
