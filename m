Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266395AbUBEQeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 11:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUBEQeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 11:34:24 -0500
Received: from cs24243203-239.austin.rr.com ([24.243.203.239]:4878 "EHLO
	raptor.int.mccr.org") by vger.kernel.org with ESMTP id S266395AbUBEQeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 11:34:15 -0500
Date: Thu, 05 Feb 2004 10:32:59 -0600
From: Dave McCracken <dmccr@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>, Timothy Miller <miller@techsource.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
Message-ID: <488580000.1075998779@[10.1.1.5]>
In-Reply-To: <1075937097.27944.1361.camel@nighthawk>
References: <20040204185446.91810.qmail@web9705.mail.yahoo.com>	
 <Pine.LNX.4.53.0402041402310.2722@chaos> <361730000.1075923354@[10.1.1.5]>	
 <40216B25.3020207@techsource.com> <1075937097.27944.1361.camel@nighthawk>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Wednesday, February 04, 2004 15:24:57 -0800 Dave Hansen
<haveblue@us.ibm.com> wrote:

>> Let's say this defragmenter allowed the kernel to detect when 1024 4k 
>> pages were contiguous and aligned properly and could silently replace 
>> the processor mapping tables so that all of these "pages" would be 
>> mapped by one TLB entry.  (At such time that some pages need to get 
>> freed, the VM would silently switch back to the 4k model.)
>> 
>> This would reduce TLB entries for a lot of programs above a certain 
>> size, and therefore improve peformance.
> 
> This is something that would be interesting to pursue, but we already
> have hugetlbfs which does this when you need it explicitly.  When you
> know that TLB coverage is a problem, that's your fix for now. 

Hugetlbfs runs from a dedicated pool of large mlocked pages.  This limits
how many hugetlbfs users there can be.

One of the things that's been discussed is letting hugetlbfs use the buddy
allocator in some fashion so it can grow dynamically.  The main barrier to
it is fragmentation, so a working defrag might make it feasible.

Dave McCracken

