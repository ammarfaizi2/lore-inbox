Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbVLLD2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbVLLD2X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 22:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVLLD2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 22:28:23 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:44370 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751059AbVLLD2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 22:28:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=YgkjzGjL8HoDg2COO0SXnmDrqNVLZ9J5axKHFUjYy2skF7+kdD7VqH6WuKPNsHWZCj/wKL0aE8BOM0qi5M5tig/5smZP6gdC+1YWLtJcC4UzIuL1i6kFyYibYBJbAvV2YfOTYBgwjDPmnsXoO3JVzLb0QOPKSdQ1PQax6rYXOiQ=  ;
Message-ID: <439CEE50.2060803@yahoo.com.au>
Date: Mon, 12 Dec 2005 14:28:16 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
References: <Pine.LNX.4.61.0512081908530.11737@goblin.wat.veritas.com> <20051208215600.GE13886@mellanox.co.il>
In-Reply-To: <20051208215600.GE13886@mellanox.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:
> Quoting Hugh Dickins <hugh@veritas.com>:
> 
>>Many would be pleased if we could manage without set_page_dirty_lock.
> 
> 
> It seems that I can do
> 
> 	if (TestSetPageLocked(page))
> 		schedule_work()
> 
> and in this way, avoid the schedule_work overhead for the common case
> where the page isnt locked.
> Right?
> 

I think you can do that - provided you ensure the page mapping hasn't
disappeared after locking it. However, I think you should try to the
simplest way first.

> If that works, I can mostly do things directly,
> although I'm still stuck with the problem of an app performing
> a fork + write into the same page while I'm doing DMA there.
> 
> I am currently solving this by doing a second get_user_pages after
> DMA is done and comparing the page lists, but this, of course,
> needs a task context ...
> 

Usually we don't care about these kinds of races happening. So long
as it doesn't oops the kernel or hang the hardware, it is up to
userspace not to do stuff like that.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
