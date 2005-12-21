Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVLUCaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVLUCaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 21:30:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVLUCaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 21:30:10 -0500
Received: from smtp109.plus.mail.mud.yahoo.com ([68.142.206.242]:22952 "HELO
	smtp109.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932259AbVLUCaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 21:30:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vb+QWMT2bYdgcLcqz3KDwJ6jwRUfN0AiCoLyLh46IwIcQ2kWbC8ZSJV9pDvKkZEr0D3D3Ttu7BF6vOHnftbXIas0rfLi+sP7Wcs41ZiHPwtC2BCfn9kVsvZHRy7iOJFN/lWlk82CQ8EzjEZnxWFtWOHPQpLlErQe1Umys7LrpFY=  ;
Message-ID: <43A8BE2C.1080905@yahoo.com.au>
Date: Wed, 21 Dec 2005 13:30:04 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Matt Mackall <mpm@selenic.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
References: <dnu8ku$ie4$1@sea.gmane.org>	 <1134790400.13138.160.camel@localhost.localdomain>	 <1134860251.13138.193.camel@localhost.localdomain>	 <20051220133230.GC24408@elte.hu>	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>	 <20051220135725.GA29392@elte.hu>	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>	 <1135093460.13138.302.camel@localhost.localdomain>	 <20051220181921.GF3356@waste.org> <1135106124.13138.339.camel@localhost.localdomain>
In-Reply-To: <1135106124.13138.339.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

> That looks like quite an undertaking, but may be well worth it.  I think
> Linux's memory management is starting to show it's age.  It's been

What do you mean by this? ie. what parts of it are a problem, and why?

I think that replacing the buddy allocator probably wouldn't be a good
idea because it is really fast and simple for page sized allocations which
are the most common, and it is good at naturally avoiding external
fragmentation. Internal fragmentation is not much of a problem because it
is handled by slab.

I can't see how replacing the buddy allocator with a completely agnostic
range allocator could be a win at all.

Perhaps it would make more sense for bootmem, resources, vmalloc, etc. and
I guess that is what Matt is suggesting.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
