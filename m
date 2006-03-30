Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWC3Qr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWC3Qr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWC3Qr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:47:58 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:12418 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750982AbWC3Qr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:47:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=cFPAUz6rGDYnrSBTVzyoGnA4XsNS1SxUscMcWcmY1iI6Xi0DEu7w1g88ooG80WzCZ+Gr38FtQLlVApvcc7pLiBwPLgKc3F1dRSLDkFdCXFclc/cESxFWBUNwsCek7KHl+4U9pCebMkyqIUNAWLD1frlsvGn82zA5laBTzMTDr5Q=  ;
Message-ID: <442B89B2.7010509@yahoo.com.au>
Date: Thu, 30 Mar 2006 17:33:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de> <442B4447.9050700@yahoo.com.au> <20060330070009.GG13476@suse.de>
In-Reply-To: <20060330070009.GG13476@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Mar 30 2006, Nick Piggin wrote:

>>Moving a page from a pipe to a filesystem might be harder, because you
>>don't know if it came from a filesystem (still on LRU) or not (in which
>>case you need to add it to LRU). If only you can keep track of this
> 
> 
> Well that, to me, is _the_ hard problem to solve for this. But you
> sort-of do know, my plan is/was to add a ->steal() hook to the pipe
> buffers that would 'unhook' the page so it was in a clean state to be
> added to the LRU/page cache again. If stealing failed, just fall back to
> copying (or hard error, let the flags decide).

Yeah, that's probably best to start with. If 'gift' copies become
widely used and performance critical we can look at tricks to speed
it up further (not that this way would be particularly slow itself).

My first thought is that falling back to copying would be the best
idea, because otherwise you can get random failures for any number of
reasons (dirty pages, page reclaim, migration, get_user_pages, etc).
If a future usage wants an error, we could add an extra flag?

>>
>>Unless someone beats me to it, I'll try coding something up when I get
>>a bit more free time.
> 
> 
> You are more than welcome, I hope to give it a little shot today and see
> how it goes.

Sure, I wouldn't get around to it for a while yet anyway, but I'd be
happy to review your patch if you do it earlier.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
