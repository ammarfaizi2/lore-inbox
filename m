Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946349AbWJSSs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946349AbWJSSs4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946362AbWJSSs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:48:56 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:13146 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1946349AbWJSSsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:48:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=DmXyiWF+lzqen3rsNSu9V/6kqh6gky51alsv9JcbPBQN1clUNfN4tjMQpWsSuI0R5IlE3s0X8jhGssvL5eyUX4R3j7iBCbVKtJnAWKiyJZVAvtP4fDdgtNiT9NCXific5bSi2n9mSoo1RXlXUfH0StYOGRefxnAYg2tP2eKutxA=  ;
Message-ID: <4537C892.4010000@yahoo.com.au>
Date: Fri, 20 Oct 2006 04:48:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
References: <1161275748231-git-send-email-ralf@linux-mips.org> <4537B9FB.7050303@yahoo.com.au> <20061019181346.GA5421@linux-mips.org>
In-Reply-To: <20061019181346.GA5421@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> On Fri, Oct 20, 2006 at 03:46:35AM +1000, Nick Piggin wrote:
> 
> 
>>What about if you just flush the caches after write protecting all
>>COW pages? Would that work? Simpler? Better performance? (I don't know)
> 
> 
> That would require changing the order of cache flush and tlb flush.  To

Can't we just move flush_cache_mm to below the copy_page_range, before
the flush_tlb_mm?

> keep certain architectures that require a valid translation in the TLB
> the cacheflush has to be done first.  Not sure if those architectures need
> a writeable mapping for dirty cachelines - I think hypersparc was one
> of them.

If the cache is dirty, then the TLB must have a writeable mapping in it,
mustn't it? If there is an architecture where this isn't the case, then
the current code is broken anyway, because in your example the T2 thread
is dirtying data right before the mapping gets write protected anyway.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
