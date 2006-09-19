Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbWISQiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbWISQiS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 12:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWISQiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 12:38:18 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:9567 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030228AbWISQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 12:38:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=D+fOaDU4xx7grn11G0TwQRv1U/XCobiIGuByqVB3Ng7jfSGorJ2vGWb675H/R5MH0FuWI8sawvtlq2qWQzhNMWVHrMapduy0clRE23KjNF9Qklcv5x09Yf0adfJvipJcLCBvn8FgiGKaWUMpeFGZKXZl5f7KtB5Nd4Wrhp2IuB8=  ;
Message-ID: <45101CF3.5070207@yahoo.com.au>
Date: Wed, 20 Sep 2006 02:38:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Stern <stern@rowland.harvard.edu>
CC: "Paul E. McKenney" <paulmck@us.ibm.com>,
       David Howells <dhowells@redhat.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Uses for memory barriers
References: <Pine.LNX.4.44L0.0609191131140.22042-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0609191131140.22042-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern wrote:
> On Mon, 18 Sep 2006, Paul E. McKenney wrote:
> 
> 
>>Restating (and renumbering) the principles, all assuming no other stores
>>than those mentioned, assuming no aliasing among variables, and assuming
>>that each store changes the value of the target variable:
>>
>>(P0):	Each CPU sees its own stores and loads as occurring in program
>>	order.
>>
>>(P1):	If each CPU performs a series of stores to a single shared variable,
>>	then the series of values obtained by the a given CPUs stores and
>>	loads must be consistent with that obtained by each of the other
>>	CPUs.  It may or may not be possible to deduce a single global
>>	order from the full set of such series.
> 
> 
> Suppose three CPUs respectively write the values 1, 2, and 3 to a single 
> variable.  Are you saying that some CPU A might see the values 1,2 (in 
> that order), CPU B might see 2,3 (in that order), and CPU C might see 3,1 
> (in that order)?  Each CPU's view would be consistent with each of the 
> others but there would not be any global order.
> 
> Somehow I don't think that's what you intended.  In general the actual
> situation is much messier, with some writes masking others for some CPUs 
> in such a way that whenever two CPUs both see the same two writes, they 
> see them in the same order.  Is that all you meant to say?

I don't think that need be the case if one of the CPUs that has written
the variable forwards the store to a subsequent load before it reaches
the cache coherency (I could be wrong here). So if that is the case, then
your above example would be correct.

But if I'm wrong there, I think Paul's statement holds even if all
stores to a single cacheline are always instantly coherent (and thus do
have some global ordering). Consider a variation on your example where
one CPU loads 1,2 and another loads 1,3. What's the order?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
