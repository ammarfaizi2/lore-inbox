Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWDACRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWDACRA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 21:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDACQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 21:16:59 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:23913 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751477AbWDACQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 21:16:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=B7PovoOCTBGdw/X1wrZfZZcH5+lw1NqtHQO3jmjZ8KtE3NliQpjaS0q+hvIRrwSyLENyEnkxluZhf3hd7oPcUoytFEHmKHH4D4rJIAjynERXNcUhXTBnu5FKWc3fV0uON+X59SQOEhWNEm0ykXXXruKd0SA7oNW1Pq360KbbU8M=  ;
Message-ID: <442DE293.8020702@yahoo.com.au>
Date: Sat, 01 Apr 2006 12:16:51 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: davem@davemloft.net, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
References: <200603312123.k2VLNqg06655@unix-os.sc.intel.com> <Pine.LNX.4.64.0603311327050.8126@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603311327050.8126@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Fri, 31 Mar 2006, Chen, Kenneth W wrote:
> 
> 
>>>I think we could say that lock semantics are different from barriers. They 
>>>are more like acquire and release on IA64. The problem with smb_mb_*** is 
>>>that the coder *explicitly* requested a barrier operation and we do not 
>>>give it to him.
>>
>>I was browsing sparc64 code and it defines:
>>
>>include/asm-sparc64/bitops.h:
>>#define smp_mb__after_clear_bit()      membar_storeload_storestore()
>>
>>With my very naïve knowledge of sparc64, it doesn't look like a full barrier.
>>Maybe sparc64 is broken too ...
> 
> 
> Dave, how does sparc64 handle this situation?

It looks like sparc64 always expects paired smp_mb__* operations,
before and after the clear_bit.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
