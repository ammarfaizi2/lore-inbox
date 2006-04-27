Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964949AbWD0GM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964949AbWD0GM2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWD0GM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:12:28 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:40879 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964949AbWD0GM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:12:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=afGGgspXBXK4RDdnTCNtyKqExp54E7srcVUu/2pk3dxog67ZecdI7hEtn1c4iYj9XoG6x9S3FRfQ57hPO9Q/XhGJEJxbPphlB/+sAYZnbBwnBdezB3TpWUbRO3xRPwpar8lqT/fl7mqY+M7ZuzuMPt+BZjCjvYhz8IL/MAE9KMk=  ;
Message-ID: <44505D75.8070409@yahoo.com.au>
Date: Thu, 27 Apr 2006 15:58:13 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de>	<20060426095511.0cc7a3f9.akpm@osdl.org>	<20060426174235.GC5002@suse.de>	<20060426111054.2b4f1736.akpm@osdl.org>	<20060426182323.GI5002@suse.de> <20060426114649.5a0e0dea.akpm@osdl.org>
In-Reply-To: <20060426114649.5a0e0dea.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> 
>>Are there cases where the lockless page cache performs worse than the
>>current one?
> 
> 
> Yeah - when human beings try to understand and maintain it.

Have any tried yet? ;)

I won't deny it is complex (because I don't like when I make the
same point and people go on to take great trouble to convince me
how simple it is!).

But I hope it isn't _too_ bad. It is basically a dozen line
function at the core, and that gets used to implement
find_get_page, find_lock_page. Their semantics remain the same,
so that's where the line is drawn (plus minor things, like an
addition for reclaim's remove-from-pagecache protocol).

IMO the rcu radix tree is probably the most complex bit... but
that pales in comparison to things like our prio tree, or RCU
trie.

> 
> The usual tradeoffs apply ;)

Definitely. It isn't fun if you just take the patch and merge it.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
