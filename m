Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWHBPMe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWHBPMe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWHBPMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:12:34 -0400
Received: from web25801.mail.ukl.yahoo.com ([217.12.10.186]:23691 "HELO
	web25801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751180AbWHBPMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:12:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=gEY0kAtf/0ZOnh9KmxQHVGmg9aaM304245NfUNDPeJxDQt2b6AUdy/IDo/9pGclQ8Ufr5JiIfxLxbrYHAWbmVNnVXZwcKQL55IvBr6+PhMTeOGDfCg4y+j+bsY8JjGz8Md4xA+xjWeF1AJjd844jtMhq695hiagFsjY1PTbuXok=  ;
Message-ID: <20060802151233.46707.qmail@web25801.mail.ukl.yahoo.com>
Date: Wed, 2 Aug 2006 15:12:33 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : sparsemem usage
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44D0B5C6.1040006@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> The memory allocator buddy location algorithm has an implicit assumption 
> that the memory map will be contigious and valid out to MAX_ORDER.  ie 
> that we can do relative arithmetic on a page* for a page to find its 
> buddy at all times.  The allocator never looks outside a MAX_ORDER 
> block, aligned to MAX_ORDER in physical pages.  SPARSEMEM's 
> implementation by it nature breaks up the mem_map at the section size. 
> Thus for the buddy to work a section must be >= MAX_ORDER in size to 
> maintain the contiguity constraint.

thanks for the explanation. But still something I'm missing, how can a
MAX_ORDER block be allocated in a memory whose size is only 128Ko ?
Can't it be detected by the buddy allocatorvery early without doing any 
relative arithmetic on a page* ?

> However, just because you have a small memory block in your memory map 
> doesn't mean that the sparsemem section size needs to be that small to 
> match.  If there is any valid memory in any section that section will be 
> instantiated and the valid memory marked within it, any invalid memory 
> is marked reserved.  

ah ok but that means that pfn_valid() will still returns ok for invalid page which
are in a invalid memory marked as reserved. Is it not risky ?

> The section size bounds the amount of internal 
> fragmentation we can have in the mem_map.  SPARSEMEM as its name 
> suggests wins biggest when memory is very sparsly populate. 

sorry but I don't understand. I would say that sparsemem section size should
be chosen to make mem_map[] and mem_section[] sizes as small as possible.

> If I am 
> reading correctly your memory is actually contigious.

well there're big holes in address space.

thanks

Francis




