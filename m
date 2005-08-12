Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVHLEEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVHLEEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 00:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVHLEEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 00:04:45 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:16516 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750797AbVHLEEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 00:04:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=bFLlNmC51d6A/qe/4B3fDYpwWE/IyxeSeSsmG2dqWxGnomz9lpHh8y/QiAiQiWM/qkN51nOVg1au2uL5g9qwOiEwmgRpdneWL42wJDctkHjtq5hsmne2wsGgYaQ2wYmpBcU8QDosSkhjfx4QEpDBcH4hjua9t0Gu7qIx6SI9boI=  ;
Subject: Re: [patch 6/7] mm: lockless pagecache
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: paulmck@us.ibm.com
Cc: Paul McKenney <paul.mckenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050812014924.GQ1300@us.ibm.com>
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au>
	 <42FB42EF.1040401@yahoo.com.au> <42FB4311.2070807@yahoo.com.au>
	 <42FB43A8.8060902@yahoo.com.au> <42FB43CB.5080403@yahoo.com.au>
	 <42FB4454.2010601@yahoo.com.au>  <20050812014924.GQ1300@us.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 14:04:39 +1000
Message-Id: <1123819479.5098.16.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 18:49 -0700, Paul E. McKenney wrote:
> On Thu, Aug 11, 2005 at 10:28:04PM +1000, Nick Piggin wrote:
> > 6/7
> > 
> > -- 
> > SUSE Labs, Novell Inc.
> > 
> 
> > Use the speculative get_page and the lockless radix tree lookups
> > to introduce lockless page cache lookups (ie. no mapping->tree_lock).
> > 
> > The only atomicity changes this should introduce is the use of a
> > non atomic pagevec lookup for truncate, however what atomicity
> > guarantees there were are probably not too useful anyway.
> 
> I don't understand the placement of the rcu_read_lock() and
> rcu_read_unlock() calls.  Again, possibly because I don't understand
> the overall algorithm yet.  And again, search for blank lines.
> 

I hope I gave a satisfactory answer to this in the last email. If
not, let me know what I've missed...

Indeed you are right that we could push all the RCU locking down
into the radix tree lookups in the places you mention _if_ we
didn't rely on lookups returning radix tree *slots*.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
