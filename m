Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVJaHJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVJaHJd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 02:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVJaHJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 02:09:33 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:26975 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932274AbVJaHJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 02:09:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=S7XC+YleGITpNAvQ0zsx3YqHCupUpNfyZXGWzfkTbgeAL8+HfDoIvpCq7Bj77aLK9/4neJZ81YAvHEoKrHQKMfBcNZGJCuBKV0y3RjSdTPlLjSfuAAwWzkIaN+NQRTHGHE87NEUwwxiLJl19XvC8XPYgBDY3g9fBYdtFkRSqO00=  ;
Message-ID: <4365C39F.2080006@yahoo.com.au>
Date: Mon, 31 Oct 2005 18:11:27 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kravetz@us.ibm.com, mel@csn.ul.ie, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
References: <20051030183354.22266.42795.sendpatchset@skynet.csn.ul.ie>	<20051031055725.GA3820@w-mikek2.ibm.com>	<4365BBC4.2090906@yahoo.com.au> <20051030235440.6938a0e9.akpm@osdl.org>
In-Reply-To: <20051030235440.6938a0e9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>Despite what people were trying to tell me at Ottawa, this patch
>>set really does add quite a lot of complexity to the page
>>allocator, and it seems to be increasingly only of benefit to
>>dynamically allocating hugepages and memory hot unplug.
> 
> 
> Remember that Rohit is seeing ~10% variation between runs of scientific
> software, and that his patch to use higher-order pages to preload the
> percpu-pages magazines fixed that up.  I assume this means that it provided
> up to 10% speedup, which is a lot.
> 

OK, I wasn't aware of this. I wonder what other approaches we could
try to add a bit of colour to our pages? I bet something simple like
trying to hand out alternate odd/even pages per task might help.

> But the patch caused page allocator fragmentation and several reports of
> gigE Tx buffer allocation failures, so I dropped it.
> 
> We think that Mel's patches will allow us to reintroduce Rohit's
> optimisation.
> 
> 
>>If that is the case, do we really want to make such sacrifices
>>for the huge machines that want these things? What about just
>>making an extra zone for easy-to-reclaim things to live in?
>>
>>This could possibly even be resized at runtime according to
>>demand with the memory hotplug stuff (though I haven't been
>>following that).
>>
>>Don't take this as criticism of the actual implementation or its
>>effectiveness.
>>
> 
> 
> But yes, adding additional complexity is a black mark, and these patches
> add quite a bit.  (Ditto the fine-looking adaptive readahead patches, btw).
> 

They do look quite fine. They seem to get their claws pretty deep
into page reclaim, but I guess that is to be expected if we want
to increase readahead smarts much more.

However, I'm hoping bits of that can be merged at a time, and
interfaces and page reclaim stuff can be discussed and the best
option taken. No such luck with these patches AFAIKS - simply
adding another level of page groups, and another level of
heuristics to the page allocator is going to hurt. By definition.
I do wonder why zones can't be used... though I'm sure there are
good reasons.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
