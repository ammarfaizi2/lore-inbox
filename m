Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVBRPmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVBRPmh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 10:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVBRPmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 10:42:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:30598 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261208AbVBRPmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 10:42:35 -0500
Subject: Re: [RFC][PATCH] Sparse Memory Handling (hot-add foundation)
From: Dave Hansen <haveblue@us.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: lhms <lhms-devel@lists.sourceforge.net>, linux-mm <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew E Tolentino <matthew.e.tolentino@intel.com>
In-Reply-To: <m1zmy2b2w9.fsf@muc.de>
References: <1108685033.6482.38.camel@localhost>  <m1zmy2b2w9.fsf@muc.de>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 07:42:31 -0800
Message-Id: <1108741351.6482.61.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 11:04 +0100, Andi Kleen wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
> 
> > The attached patch, largely written by Andy Whitcroft, implements a
> > feature which is similar to DISCONTIGMEM, but has some added features.
> > Instead of splitting up the mem_map for each NUMA node, this splits it
> > up into areas that represent fixed blocks of memory.  This allows
> > individual pieces of that memory to be easily added and removed.
>
> I'm curious - how does this affect .text size for a i386 or x86-64 NUMA
> kernel? One area I wanted to improve on x86-64 for a long time was
> to shrink the big virt_to_page() etc. inline macros. Your new code
> actually looks a bit smaller.

On x86, it looks like a 3k increase in text size.  I know Matt Tolentino
has been testing it on x86_64, he might have a comparison there for you.

$ size i386-T41-laptop*/vmlinux
   text    data     bss     dec     hex filename
2897131  580592  204252 3681975  382eb7 i386-T41-laptop.sparse/vmlinux
2894166  581832  203228 3679226  3823fa i386-T41-laptop/vmlinux

BTW, this PAE is on and uses 36-bits of physaddr space.  

-- Dave

