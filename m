Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWD0I3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWD0I3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWD0I3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:29:06 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:42938 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964815AbWD0I3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:29:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=X5xVyB7XEVtxEGTUvRIZjg7qL8XdjiHizbpDDdNvbgX0ljLqd0wk+87lE9tfr3oUDYXEN2rPcNW6XzdgKqY5IvlmuCzSCnc5QyE6rf9gnYqN6eAC9HpwE0MtEfRnc6RCQnlz4+Z4auu7b04vA/aVoruw/nUaYWz6TBZI5d3kO0g=  ;
Message-ID: <4450796A.2030908@yahoo.com.au>
Date: Thu, 27 Apr 2006 17:57:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <20060426191557.GA9211@suse.de> <20060426131200.516cbabc.akpm@osdl.org> <20060427074533.GJ9211@suse.de>
In-Reply-To: <20060427074533.GJ9211@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> Things look pretty bad for the lockless kernel though, Nick any idea
> what is going on there? The splice change is pretty simple, see the top
> three patches here:

Could just be the use of spin lock instead of read lock.

I don't think it would be hard to convert find_get_pages_contig
to be lockless.

Patched vanilla numbers look nicer, but I'm curious as to why
__do_page_cache was so bad before, if the file was in cache.
Presumably it should not more than double tree_lock acquisition...
it isn't getting called multiple times for each page, is it?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
