Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWDZU2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWDZU2o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWDZU2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:28:43 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:44147 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964867AbWDZU2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:28:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OHxHdjN+e8k0+GFykE9Zg9KGcHSrXsqwUwvJq1uOElCcU0yKlllbmUHmJbF72KFbdbIA3v8RugEI97FN6pAtKyc02y/AveBFfNJr0wAenNwb3lH26v8byDFIrWOCCfnShUKfS9wGPnnJeLO7nzPrnq9JoD3mMI4/Yx1X6O/aUFw=  ;
Message-ID: <444F9A8D.3040604@yahoo.com.au>
Date: Thu, 27 Apr 2006 02:06:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, Jan Beulich <jbeulich@novell.com>,
       Zachary Amsden <zach@vmware.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: PAE entries must have their low word cleared first
References: <444F95D8.76E4.0078.0@novell.com> <Pine.LNX.4.64.0604261538260.9915@blonde.wat.veritas.com> <946b367619cfd3dcd3ba547e216e494b@cl.cam.ac.uk> <Pine.LNX.4.64.0604261636570.11246@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0604261636570.11246@blonde.wat.veritas.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Wed, 26 Apr 2006, Keir Fraser wrote:
> 
>>We cannot use pte_clear() unless we redefine it for PAE. Currently it reduces
>>to set_pte() which explicitly uses the wrong ordering (sets high *then* low,
>>because it's normally used to introduce a mapping).
> 
> 
> I overlooked that reversal completely.  What a very good point.
> I think that actually pte_clear() _does_ need to be redefined for PAE,
> to reverse that ordering as you point out.  Take a look at its use in
> mm/highmem.c (where a comment states it's safe against speculative
> execution, but a comment can't guarantee that!): what do you think?

Speculative execution is safe I think (and so is ptep_get_and_clear_full,
because in neither case will the virtual address be visible).

Speculative prefetching + tlb instantiation, apparently no.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
