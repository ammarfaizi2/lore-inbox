Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWFBCVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFBCVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 22:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWFBCVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 22:21:43 -0400
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:19809 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751136AbWFBCVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 22:21:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=2gu4TPnRmMBz3ZCap5ij0VJR5GctPJ/JO7zaMbFN779XVj03mrfu7PJCOg5qGpdKCGHm9zPfPbuat9YnBXRnENYkWZihLCuFvWwLC7IUfESy+ysXVEbI57gmthc/oV4ouXstPiqkPK2Sb3Ff1o7fSWdVCqLc4u39IEWedoGdkLw=  ;
Message-ID: <447FA0AE.9050002@yahoo.com.au>
Date: Fri, 02 Jun 2006 12:21:34 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org> <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org> <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org> <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au> <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au> <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au> <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au> <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au> <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org> <447DC22C.5070503@yahoo.com.au> <Pine.LNX.4.64.0605310937170.24646@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605310937170.24646@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 1 Jun 2006, Nick Piggin wrote:
> 
>>I keep telling you. Put the unplug after submission of IO. Not before
>>waiting for IO.
> 
> 
> And that's exactly where we have the lock_page().

In some cases.

> 
> And you ignored the list of _requirements_ I had, so you just missed the 
> other place you _have_ to have the unplug, namely in the "found a page 
> that was not yet up-to-date" case (look for the other lock_page()). 

I know you have to unplug there. I didn't ignore anything. Where is
the problem?

> Because the person who started the IO might be off doing something else, 
> and may not be unplugging now (or ever, in the case of readahead).
> 
> In other words, when you start arguing, at least read my emails. Your 
> suggestion would have introduced a bug by not waiting on that other place.

No. I'm saying the "person" who started IO _could_ be the one unplugging.
Always.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
