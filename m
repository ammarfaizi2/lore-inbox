Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWC3S6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWC3S6B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWC3S6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:58:01 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:6516 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750734AbWC3S6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:58:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sZp10HsbmCHaM5LMRnQF4CvXVI9xkBxZmzp+6mpbq/ej9fx6Neexz1QJJirKXK3PQEny+csb9OLbGbt/Xi6L919JQFYOG5DgiJ1h5Lbwq3SXM2Ew1PHcv7++gNgxI7Wj06OoHifioowUVSnCmDuEwH6AUtg+aTHY8WFsnevpTBs=  ;
Message-ID: <442B9616.3050400@yahoo.com.au>
Date: Thu, 30 Mar 2006 18:25:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
References: <20060329122841.GC8186@suse.de> <20060329143758.607c1ccc.akpm@osdl.org> <20060330074534.GL13476@suse.de> <20060330000240.156f4933.akpm@osdl.org> <20060330081008.GO13476@suse.de>
In-Reply-To: <20060330081008.GO13476@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Mar 30 2006, Andrew Morton wrote:

>>Maybe the code handles that by making sure that all the pages in the range
>>are already in pagecache - I didn't check.  But that would take some heroic
>>locking.
> 
> 
> It doesn't, I'm assuming that find_get_pages() returns consequtive pages
> atm. Would seem like the sane interface :-)
> 

It doesn't.

You could do a find_get_pages_and_holes (or something along those
lines), which would fetch contiguous pagecache and stick NULLs
if pages don't exist.

Would require a bit of radix-tree support to do it nicely, but you
could get started with a naive find_get_page loop.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
