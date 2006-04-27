Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbWD0PR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbWD0PR0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 11:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWD0PR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 11:17:26 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:61852 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965150AbWD0PRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 11:17:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=etyi9gzezKycvx89PCMeb5VjIffogLDuzDpqua6fc5do6n6Jua6sj5AyOlPaGOSPQGU77Hn6RAaVzycGhCmpvl6JS8SZOjNIuhfS0wBjy6R9YSu+FS7WI0ioFzIolWkGT+016WoARx6Apf6If6aVr2vqrTsOVB0KKtsk427L3JY=  ;
Message-ID: <4450C8C6.9040309@yahoo.com.au>
Date: Thu, 27 Apr 2006 23:36:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <20060426191557.GA9211@suse.de> <20060426131200.516cbabc.akpm@osdl.org> <20060427074533.GJ9211@suse.de> <4450796A.2030908@yahoo.com.au> <44507AA9.2010005@yahoo.com.au> <20060427090000.GA23137@suse.de>
In-Reply-To: <20060427090000.GA23137@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Apr 27 2006, Nick Piggin wrote:

>>Hmm, what's more, find_get_pages_contig shouldn't result in any
>>fewer tree_lock acquires than the open coded thing there now
>>(for the densely populated pagecache case).
> 
> 
> How do you figure? The open coded one does a find_get_page() on each
> page in that range, so for x number of pages we'll grab and release
> ->tree_lock x times.

Yeah you're right. I had in mind that you were using
find_get_pages_contig in readahead, rather than in splice.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
