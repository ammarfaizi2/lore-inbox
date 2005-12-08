Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVLHTdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVLHTdd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbVLHTdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:33:33 -0500
Received: from gold.veritas.com ([143.127.12.110]:45129 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932280AbVLHTdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:33:32 -0500
Date: Thu, 8 Dec 2005 19:33:16 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Dave Hansen <haveblue@us.ibm.com>
cc: Badari Pulavarty <pbadari@us.ibm.com>, Andy Whitcroft <andyw@uk.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, dwg@au1.ibm.com,
       "ADAM G. LITKE [imap]" <agl@us.ibm.com>
Subject: Re: 2.6.15-rc4 panic in __nr_to_section() with CONFIG_SPARSEMEM
In-Reply-To: <1134069335.6159.21.camel@localhost>
Message-ID: <Pine.LNX.4.61.0512081930340.11944@goblin.wat.veritas.com>
References: <1133995060.21841.56.camel@localhost.localdomain> 
 <43976AA4.2060606@uk.ibm.com>  <1133997772.21841.62.camel@localhost.localdomain>
  <1134002888.30387.82.camel@localhost>  <1134058055.21841.70.camel@localhost.localdomain>
 <1134069335.6159.21.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 08 Dec 2005 19:33:21.0946 (UTC) FILETIME=[3FD3AFA0:01C5FC2E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Dave Hansen wrote:
> On Thu, 2005-12-08 at 08:07 -0800, Badari Pulavarty wrote:
> > No. It doesn't help. It looks like ppc pmd_huge() always returns 0.
> > Don't know why ? :(
> 
> The ppc64 hugetlb pages don't line up on PMD boundaries like they do on
> i386.  The entries are stored in regular old PTEs.  
> 
> I really don't like coding the two different hugetlb cases, but I can't
> think of a better way to do it.  Anyone care to test on ppc64?

Oh, it isn't worth that effort, just test is_vm_hugetlb_page(vma)
in show_smap, and skip it if so - or make up appropriate numbers
from (vm_end - vm_start) in that case if you like.

Hugh
