Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWEaQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWEaQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbWEaQ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:26:57 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:10370 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750957AbWEaQ04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:26:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=q37AapZlLJatddbbdDcSpMeY9B1mJX3pC7FUS9NbnLUfjGE+aaQeJvoaQIx66anaMCn6Ql7ue9CibTINYadqI4Nv0Z48DGWXXq/oUZH7JWKXcpeJ45h0W7r/f8dc5eJmSVCHWyj49DB2KdU//MTVusjOjXVjccewON7DJW4uKvQ=  ;
Message-ID: <447DC3C6.3030709@yahoo.com.au>
Date: Thu, 01 Jun 2006 02:26:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au> <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au> <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au> <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org> <Pine.LNX.4.64.0605310903310.24646@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605310903310.24646@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> And I suspect your objection to unplugging is not really about unplugging 
> itself. It's literally about the fact that we use the same page lock for 
> IO and for the ->mapping thing, isn't it?

Nearly, but not quite that far: it's that we sync_page in lock_page.

I don't think using the single lock for both is too bad (in many
ways they are related eg. you don't want the page to be truncated
while IO is in progress).

> 
> IOW, you don't actually dislike plugging itself, you dislike it due to the 
> effects of a totally unrelated locking issue, namely that we use the same 
> lock for two totally independent things. If the ->mapping thing were to 
> use a PG_map_lock that didn't affect plugging one way or the other, you 
> wouldn't have any issues with unplugging, would you?
> 
> And I think _that_ is what really gets us to the problem. 

No I don't dislike plugging at all ;) Just this tangle as you say.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
