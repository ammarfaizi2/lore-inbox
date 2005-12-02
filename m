Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVLBC1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVLBC1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 21:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbVLBC1L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 21:27:11 -0500
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:56192 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964798AbVLBC1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 21:27:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=4vLbPop0Xh1m7DAopweAB1bBfg+X/ildvw2rkN7ebSZORXZvxumt7tyEagm5oQPlk/b/caqDk2s/GgmMEikO0296MxDkd9lb83Gcm564flPr1AuqeoLxVzHBuye3d/qX2V1V7M1OHOm1WeuslyZlddGQ0FBx4yGrib/ay/9ckUc=  ;
Message-ID: <438FB0FA.3050806@yahoo.com.au>
Date: Fri, 02 Dec 2005 13:27:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
CC: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, christoph@lameter.com, riel@redhat.com,
       a.p.zijlstra@chello.nl, npiggin@suse.de, andrea@suse.de,
       magnus.damm@gmail.com
Subject: Re: [PATCH 02/12] mm: supporting variables and functions for balanced
 zone aging
References: <20051201101810.837245000@localhost.localdomain> <20051201101933.936973000@localhost.localdomain> <20051201023714.612f0bbf.akpm@osdl.org> <20051201222846.GA3646@dmt.cnet> <20051201150349.3538638e.akpm@osdl.org> <20051202011924.GA3516@mail.ustc.edu.cn> <20051201173015.675f4d80.akpm@osdl.org> <20051202020407.GA4445@mail.ustc.edu.cn>
In-Reply-To: <20051202020407.GA4445@mail.ustc.edu.cn>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> On Thu, Dec 01, 2005 at 05:30:15PM -0800, Andrew Morton wrote:
> 
>>> But lines 865-866 together with line 846 make most shrink_zone() invocations
>>> only run one batch of scan. The numbers become:
>>
>>True.  Need to go into a huddle with the changelogs, but I have a feeling
>>that lines 865 and 866 aren't very important.  What happens if we remove
>>them?
> 
> 
> Maybe the answer is: can we accept to free 15M memory at one time for a 64G zone?
> (Or can we simply increase the DEF_PRIORITY?)
> 

0.02% of the memory? Why not? I think you should be more worried
about what happens when the priority winds up.

I think your proposal to synch reclaim rates between zones is fine
when all pages have similar properties, but could behave strangely
when you do have different requirements on different zones.

> btw, maybe it's time to lower the low_mem_reserve.
> There should be no need to keep ~50M free memory with the balancing patch.
> 

min_free_kbytes? This number really isn't anything to do with balancing
and more to do with the amount of reserve kept for things like GFP_ATOMIC
and recursive allocations. Let's not lower it ;)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
