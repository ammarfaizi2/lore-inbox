Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWCUMzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWCUMzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbWCUMzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:55:20 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:42427 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751627AbWCUMzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:55:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=jR1rqEqpsjY2u8o5lQllkl53gXfZCIxWl3rWAmY7jzMSRjrP6WXisWd+09qSPZEXdiWqLJAuZmg93ovgp/dDBs4BOw/QvHPHFmSxs9rWH2KTfyGVJhzy1OJp/CsnxwAlUuXGCJhHf1ddqReSckn7cQpPa6IF+BHPelzeCKm0GFI=  ;
Message-ID: <441FEF8D.7090905@yahoo.com.au>
Date: Tue, 21 Mar 2006 23:20:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Stone Wang <pwstone@gmail.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][0/8] (Targeting 2.6.17) Posix memory locking and balanced
 mlock-LRU semantic
References: <bc56f2f0603200535s2b801775m@mail.gmail.com>
In-Reply-To: <bc56f2f0603200535s2b801775m@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stone Wang wrote:
> Both one of my friends(who is working on a DBMS oriented from
> PostgreSQL) and i had encountered unexpected OOMs with mlock/mlockall.
> 

I'm not sure this is a great idea. There are more conditions than just
mlock that prevent pages being reclaimed. Running out of swap, for
example, no swap, page temporarily pinned (in other words -- any duration
from fleeting to permanent). I think something _much_ simpler could be
done for a more general approach just to teach the VM to tolerate these
pages a bit better.

Also, supposing we do want this, I think there is a fairly significant
queue of mm stuff you need to line up behind... it is probably asking
too much to target 2.6.17 for such a significant change in any case.

But despite all that I looked though and have a few comments ;)
Kudos for jumping in and getting your hands dirty! It can be tricky code.

> The patch brings Linux with:
> 1. Posix mlock/munlock/mlockall/munlockall.
>    Get mlock/munlock/mlockall/munlockall to Posix definiton: transaction-like,
>    just as described in the manpage(2) of mlock/munlock/mlockall/munlockall.
>    Thus users of mlock system call series will always have an clear map of
>    mlocked areas.

In what way are we not now posix compliant now?

-- 
SUSE Labs, Novell Inc.


Send instant messages to your online friends http://au.messenger.yahoo.com 
