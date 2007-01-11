Return-Path: <linux-kernel-owner+w=401wt.eu-S965296AbXAKGKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965296AbXAKGKR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 01:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbXAKGKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 01:10:17 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:29173 "HELO
	smtp107.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965299AbXAKGKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 01:10:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=BO4nkxluKjgR0Rp1G9mt+hD3xY5tQe31hkCxpWGx0ICclz84oj6TtC/3oY+/0N1b+Abrnp6//aaP+PpC2f6vEDhsTTyAen2ImC95ltn+ADF0Z5JPHsYIcle86ucg3WggC9SUqX5zsekJDnYkDiJPq3y+TsALH1HtGeLxltNGKqk=  ;
X-YMail-OSG: ATPQZqcVM1kIyFU1XgPfq4EdhOfULqewcJjdfvynaQgXFbmbPUnGXfdiY7wJYsvj1Qm6E36Hzcq6Fsc_gUaBOMqYv6olrXw1sN7SNIP53ppZVjkoTIphRCcI0HEztNLHQ4fRvBF37a73.P3FOoroBzeVTFeGGJdnAXqORyzq9uLh0uDMzELVI8PQUzHe
Message-ID: <45A5D4A7.7020202@yahoo.com.au>
Date: Thu, 11 Jan 2007 17:09:43 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Aubrey <aubreylee@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Hugh Dickins <hugh@veritas.com>, linux-kernel@vger.kernel.org,
       hch@infradead.org, kenneth.w.chen@intel.com, akpm@osdl.org,
       mjt@tls.msk.ru
Subject: Re: O_DIRECT question
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com> <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org> <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 10 Jan 2007, Linus Torvalds wrote:
> 
>>So don't use O_DIRECT. Use things like madvise() and posix_fadvise() 
>>instead. 
> 
> 
> Side note: the only reason O_DIRECT exists is because database people are 
> too used to it, because other OS's haven't had enough taste to tell them 
> to do it right, so they've historically hacked their OS to get out of the 
> way.
> 
> As a result, our madvise and/or posix_fadvise interfaces may not be all 
> that strong, because people sadly don't use them that much. It's a sad 
> example of a totally broken interface (O_DIRECT) resulting in better 
> interfaces not getting used, and then not getting as much development 
> effort put into them.
> 
> So O_DIRECT not only is a total disaster from a design standpoint (just 
> look at all the crap it results in), it also indirectly has hurt better 
> interfaces. For example, POSIX_FADV_NOREUSE (which _could_ be a useful and 
> clean interface to make sure we don't pollute memory unnecessarily with 
> cached pages after they are all done) ends up being a no-op ;/
> 
> Sad. And it's one of those self-fulfilling prophecies. Still, I hope some 
> day we can just rip the damn disaster out.

Speaking of which, why did we obsolete raw devices? And/or why not just
go with a minimal O_DIRECT on block device support? Not a rhetorical
question -- I wasn't involved in the discussions when they happened, so
I would be interested.

O_DIRECT is still crazily racy versus pagecache operations. Chris Mason's
recent patches to attempt to fix it, while actually doing quite a fine
job, are very intrusive and complex for such a sad corner case.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
