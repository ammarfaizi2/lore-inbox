Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbVH2Dhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbVH2Dhg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 23:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVH2Dhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 23:37:36 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:56990 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750789AbVH2Dhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 23:37:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vYvCzSnvZhFgI+kkeoMt/ZplvefTBgeFjnDNxiqmTFrxJ8QxrAdOcgKBhrZctdp7/HfV2rUdv7O58J+s/1Me2CZqjbInRYCsnpcCHT1zSvyZS02O+6tM4NvPiJxCoFehLC5FiqtyquU6Htzo0Vq5BP7iLFQ18GMjRm7QPD8l2q0=  ;
Message-ID: <4312830C.8000308@yahoo.com.au>
Date: Mon, 29 Aug 2005 13:37:48 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
References: <1125159996.5159.8.camel@mulgrave>	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>	 <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave>	 <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave>
In-Reply-To: <1125285994.5048.40.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Sun, 2005-08-28 at 18:35 -0700, Andrew Morton wrote:

>>It does make the tree higher and hence will incur some more cache missing
>>when descending the tree.
> 
> 
> Actually, I don't think it does:  the common user is the page tree.
> Obviously, I've changed nothing on 64 bits, so we only need to consider
> what I've done on 32 bits.  A page size is almost universally 4k on 32
> bit, so we need 20 bits to store the page tree index.  Regardless of
> whether the index size is 5 or 6, that gives a radix tree depth of 4.
> 

s/common/only ?

But the page tree is indexed by file offset rather than virtual
address, and we try to span the file's pagecache with the smallest
possible tree. So it will tend to make the trees taller.

> 
>>We changed the node size a few years back.  umm.... 
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0206.2/0141.html
> 
> 
> Yes, but that was to reduce the index size from 7 to 6 for slab
> allocation reasons.  I've just reduced it to 5 on 32 bit.
> 
> 
>>It would be a little bit sad to be unable to make such tuning adjustments
>>in the future.  Not a huge loss, but a loss.
> 
> 
> Well .. OK .. If the benchmarks say I've slowed us down on 32 bits, I'll
> put the variable sizing back in the tag array.
> 

I'm curious: what do the benchmarks say about your gang lookup?

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
