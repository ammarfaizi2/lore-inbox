Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWHIOTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWHIOTE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 10:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWHIOTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 10:19:04 -0400
Received: from web25814.mail.ukl.yahoo.com ([217.146.176.247]:2147 "HELO
	web25814.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750882AbWHIOTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 10:19:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=QoXzDPD842U+cNVtybyiik3eACLPGdBcw1enKyA3zQjb8qmLFvUt7RKac4ZiPV4qVIJFGUWcLSPB2LE84sf6zgoTueTUNmazUPwEzHGE276zeb/c0uO2IXwLpM0TJOoi6ecxbitsXRvgCtXjPTfiUHyUcwgZ8F2qPBQQMcn7E+E=  ;
Message-ID: <20060809141901.40003.qmail@web25814.mail.ukl.yahoo.com>
Date: Wed, 9 Aug 2006 14:19:01 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : Re : Re : sparsemem usage
To: Andy Whitcroft <apw@shadowen.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <44D1F688.2030806@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> 
> I have to re-iterate pfn_valid() does not mean pfn_valid_memory(), it
> means pfn_valid_memmap().  If you want to know if a page is valid and
> memory (at least on x86) you could use:
> 
>     if (pfn_valid(pfn) && page_is_ram(pfn)) {
>     }
> 
> It is rare you care how many real page frames there are in the system.
> You are more interested in how many usable frames there are.  Such as
> for use in sizing hashes or caches.  The reserved pages should be
> excluded in this calculation.  ACPI pages, BIOS pages and the like
> simply are no interest.
> 
> I don't see anywhere in the kernel using that construct to work out how
> many pages there are in the system.  Mostly we have architectual
> information to tell us what real physical pages exist in the system such
> as the srat or e820 etc.  If we really care about real page counts at
> that accuracy we have those to refer to.
> 

Not all arch have page_is_ram(). OK it should be easy to have but we will
need create new data structures to keep this info. The point is that it's
really easy for memory model such sparsemem to keep this info.

> Do you have a usage model in which we really care about the number of
> pages in the system to that level of accuracy?
> 

show_mem(), which is arch specific, needs to report them. And some
implementations use only pfn_valid().

thanks

Francis


