Return-Path: <linux-kernel-owner+w=401wt.eu-S965310AbXAKHFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965310AbXAKHFw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbXAKHFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:05:52 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:27125 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965310AbXAKHFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:05:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uyohJuV23kuHeNdC3Pq7iFD8FqiAgOgoXSkM+K5G5At4r8lM/A07CluKmd8I2CRtyA/HTEawP+3EAV+gZwnMaLzdlTNDv5796uPQV1qP8pB36XOksNy8++s27v5349iUIpogsJC1BsgumqimpzKV+PqTIE0tAwXnY+XfODlxeOQ=  ;
X-YMail-OSG: E03RR7cVM1lz1h0NEfw.3aI2oPK61ZjNlV1W.BZuxVPo1eZksqVxJWguprDsgip3xYIfv7vwQHE2IHvesuPfAKPYzAcGOCIWeFuELvW51mtvW09U2juqKxitIvTz4NoRD2.bqTlCcV4amVs-
Message-ID: <45A5E1B2.2050908@yahoo.com.au>
Date: Thu, 11 Jan 2007 18:05:22 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Aubrey <aubreylee@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	<Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>	<6d6a94c50701102150w4c3b46d0w6981267e2b873d37@mail.gmail.com>	<20070110220603.f3685385.akpm@osdl.org>	<6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com> <20070110225720.7a46e702.akpm@osdl.org>
In-Reply-To: <20070110225720.7a46e702.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 11 Jan 2007 14:45:12 +0800
> Aubrey <aubreylee@gmail.com> wrote:
> 
> 
>>>In the interim you could do the old "echo 3 > /proc/sys/vm/drop_caches"
>>>thing, but that's terribly crude - drop_caches is really only for debugging
>>>and benchmarking.
>>>
>>
>>Yes. This method can drop caches, but will fragment memory.
> 
> 
> That's what page reclaim will do as well.
> 
> What you want is Mel's antifragmentation work, or lumpy reclaim.
> 
> 
>>This is
>>not what I want. I want cache is limited to a tunable value of the
>>whole memory. For example, if total memory is 128M, is there a way to
>>trigger reclaim when cache size > 16M?
> 
> 
> If there was, it'd "fragment memory" as well.
> 
> You might get a little benefit from increasing /proc/sys/vm/min_free_kbytes,
> but not much.  Some page allocation tweaks would aid that.
> 
> But basically, to do this well, serious work is needed.

OTOH, the antifragmentation stuff can also break down eventually,
especially if higher order allocations are actually in common use.

What you _really_ want to do is avoid large mallocs after boot, or use
a CPU with an mmu. I don't think nommu linux was ever intended to be a
simple drop in replacement for a normal unix kernel.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
