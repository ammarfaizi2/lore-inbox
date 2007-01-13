Return-Path: <linux-kernel-owner+w=401wt.eu-S1161273AbXAMEwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbXAMEwK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 23:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbXAMEwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 23:52:10 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:22014 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1161273AbXAMEwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 23:52:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CZtSIod7+jzj3ZCRHTvFrsFLIi5Cxy4OE33w18qYe+K3g04M6JxmM/Ogyi2dAseD01g6qcWKrgOfwYb0IQpNO2kQ3/xG2c+c5rf8FnCx2g8qWKV6sIGuR2IO/kLtTezYR0BkmFaXu+IcO6QfwkA5nUjOUjlo+BGTvqlshYRydUw=  ;
X-YMail-OSG: RjNAsYwVM1mp9N8eL8b4PPLj_HfQlXdHQNChAxSCMO2txYQcj3o7YT.BPg6jeQeq6XJE305A5l.101voM0HmHg9ao2Pf61qIy0boEUgFYU8cU_KW6zdLtZ5r_6eSsF9ekZKnZp6Amjhf4DFWgQWjT93s1z21ilZqXNEL0HlEXoy_mwMkO16o0LF8jwwZ
Message-ID: <45A8655E.8050708@yahoo.com.au>
Date: Sat, 13 Jan 2007 15:51:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Aubrey <aubreylee@gmail.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>	 <6d6a94c50701102245g6afe6aacxfcb2136baee5cbfa@mail.gmail.com>	 <20070110225720.7a46e702.akpm@osdl.org>	 <45A5E1B2.2050908@yahoo.com.au>	 <6d6a94c50701102354l7ab41a3bp4761566204f1d992@mail.gmail.com>	 <45A5F157.9030001@yahoo.com.au> <45A6F70E.1050902@tmr.com>	 <45A70EF9.40408@yahoo.com.au>	 <Pine.LNX.4.64.0701112044070.3594@woody.osdl.org>	 <45A714F8.6020600@yahoo.com.au> <6d6a94c50701112122l66a4866bg548009dddb806434@mail.gmail.com> <45A7A23F.7040801@tmr.com>
In-Reply-To: <45A7A23F.7040801@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> The point is that if you want to be able to allocate at all, sometimes 
> you will have to write dirty pages, garbage collect, and move or swap 
> programs. The hardware is just too limited to do something less painful, 
> and the user can't see memory to do things better. Linus is right, 
> 'Claiming that there is a "proper solution" is usually a total red 
> herring. Quite often there isn't, and the "paper over" is actually not 
> papering over, it's quite possibly the best solution there is.' I think 
> any solution is going to be ugly, unfortunately.

It seems quite robust and clean to me, actually. Any userspace memory
that absolutely must be large contiguous regions have to be allocated at
boot or from a pool reserved at boot. All other allocations can be broken
into smaller ones.

Write dirty pages, garbage collect, move or swap programs isn't going
to be robust because there is lots of vital kernel memory that cannot be
moved and will cause fragmentation.

The reclaimable zone work that went on a while ago for hugepages is
exactly how you would also fix this problem and still have a reasonable
degree of flexibility at runtime. It isn't really ugly or hard,  compared
with some of the non-working "solutions" that have been proposed.

The other good thing is that the core mm already has practically
everything required, so the functionality is unintrusive.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
