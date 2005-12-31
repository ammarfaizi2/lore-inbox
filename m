Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVLaHyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVLaHyd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 02:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbVLaHyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 02:54:33 -0500
Received: from smtp108.plus.mail.mud.yahoo.com ([68.142.206.241]:52578 "HELO
	smtp108.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751319AbVLaHyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 02:54:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=nIRNFHmf/LUr5T4UdcXxiUQTdUM/sNl2KQO+TDkUFHllKJsQ5vDp3rvO3HFGCpxWKmX+O6Gyn5pMUdzjC2+ByGyTk0JbHCR96UxUQdzXEjqpy7Hfu0zk8PK/ZkZGsem+B4MWOpALOT30eTTQtygtRsbpfpreNTaYA3q8YhOVxUU=  ;
Message-ID: <43B63931.6000307@yahoo.com.au>
Date: Sat, 31 Dec 2005 18:54:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com> <20051231064615.GB11069@dmt.cnet>
In-Reply-To: <20051231064615.GB11069@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> 
> What about this addition to the documentation above, to make it a little more 
> verbose:
> 
> 	The possible race scenario is restricted to kernel preemption,
> 	and could happen as follows:
> 
> 	thread A				thread B
> a)	movl    xyz(%ebp), %eax			movl    xyz(%ebp), %eax
> b)	incl    %eax				incl    %eax
> c)	movl    %eax, xyz(%ebp)			movl    %eax, xyz(%ebp)
> 
> Thread A can be preempted in b), and thread B succesfully increments the
> counter, writing it back to memory. Now thread A resumes execution, with
> its stale copy of the counter, and overwrites the current counter.
> 
> Resulting in increments lost.
> 
> However that should be relatively rare condition.
> 

Hi Guys,

I've been waiting for some mm/ patches to clear from -mm before commenting
too much... however I see that this patch is actually against -mm itself,
with my __mod_page_state stuff in it... that makes the page state accounting
much lighter weight AND is not racy.

So I'm not exactly sure why such a patch as this is wanted now? Are there
any more xxx_page_state hotspots? (I admit to only looking at page faults,
page allocator, and page reclaim).

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
