Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWD3NB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWD3NB1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 09:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWD3NB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 09:01:27 -0400
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:60040 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751109AbWD3NB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 09:01:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vxs5km+fXNywZxWUdZpC0pkwn2cBEzqxjUrSSiN1gfnePzRqa5YwrNPxwUACU0a5Z2RnNcSFmobY3rYJ2HaIJF8onpVoyHyDnVxhXepFIHLNwOapBUkOowRkP4aC63ynmrwZzAoXUQ+dhxcdJ8j4EbqVXPPk/6s3zSakNbuOuPk=  ;
Message-ID: <44549D96.2050004@yahoo.com.au>
Date: Sun, 30 Apr 2006 21:20:54 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Chinner <dgc@sgi.com>
CC: Christoph Lameter <clameter@sgi.com>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com> <20060426114737.239806a2.akpm@osdl.org> <20060426184945.GL5002@suse.de> <Pine.LNX.4.64.0604261330310.20897@schroedinger.engr.sgi.com> <20060428140146.GA4657648@melbourne.sgi.com> <44548834.5050204@yahoo.com.au>
In-Reply-To: <44548834.5050204@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> As well as lockless pagecache, I think we can batch tree_lock operations
> in readahead. Would be interesting to see how much this patch helps.

Btw. the patch introduces multiple locked pages in pagecache from a single
thread, however there should be no new deadlocks or lock orderings
introduced. They are always aquired because they are new pages, so will all
be released. Visibility from other threads is no different to the case
where multiple pages locked by multiple threads.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
