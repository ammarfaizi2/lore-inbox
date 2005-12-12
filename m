Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVLLJjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVLLJjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 04:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbVLLJjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 04:39:08 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:32360 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751171AbVLLJjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 04:39:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=X2dJYwCpYEMLptrCiC9oGP9fLd4PVt4qLv0IbKbpcmOBeua0VpgSHUwrJCNyp6jnhZ7bH/ndrFMxwxPhw7G9jluMtbCmDB7cmL1wJ1jlQrjeeCAB1Bt8+Ps8UieAOb98ggGJlAzkuRlHMkdl6Sw1pDwzpXZTVp4Mxam/LSbUUHU=  ;
Message-ID: <439D4533.6000708@yahoo.com.au>
Date: Mon, 12 Dec 2005 20:38:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dada1@cosmosbay.com, pj@sgi.com, linux-kernel@vger.kernel.org,
       Simon.Derr@bull.net, ak@suse.de, clameter@sgi.com
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>	<439D39A8.1020806@cosmosbay.com>	<439D3AD5.3080403@yahoo.com.au> <20051212011108.0725524d.akpm@osdl.org>
In-Reply-To: <20051212011108.0725524d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 

>>
>>Is it a good idea for all kmem_cache_t? If so, can we move
>>__read_mostly to the type definition?
>>
> 
> 
> Yes, I suppose that's worthwhile.
> 
> We've been shuffling towards removing kmem_cache_t in favour of `struct
> kmem_cache', but this is an argument against doing that.
> 
> If we can work out how:
> 
> void foo()
> {
> 	kmem_cache_t *p;
> }
> 
> That'll barf.
> 

Mmm. And the structure within structure, which Eric points out. I assumed
without grepping that those were mostly confined to slab itself and would
be easy to special case, but it turns out networking makes some use of
them too.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
