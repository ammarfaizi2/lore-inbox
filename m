Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265651AbUABVbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUABVbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:31:46 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38928 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265651AbUABVbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:31:44 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
Date: Fri, 02 Jan 2004 16:15:05 -0500
Organization: TMR Associates, Inc
Message-ID: <3FF5DF59.3090905@tmr.com>
References: <3FE492EF.2090202@colorfullife.com> <20031221113640.GF3438@mail.shareable.org> <3FE594D0.8000807@colorfullife.com> <20031221141456.GI3438@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073078388 7080 192.168.12.10 (2 Jan 2004 21:19:48 GMT)
X-Complaints-To: abuse@tmr.com
Cc: Manfred Spraul <manfred@colorfullife.com>, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
To: Jamie Lokier <jamie@shareable.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <20031221141456.GI3438@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> We have found the performance impact of the extra ->poll calls
> negligable with epoll.  They're simply not slow calls.  It's
> only when you're doing select() or poll() of many descriptors
> repeatedly that you notice, and that's already poor usage in other
> ways.

I do agree with you, but there is a lot of old software, and software 
written on/for BSD, which does do this. I'm not prepared to say that BSD 
does it better, but it's easier to fix in one place, the kernel, than 
many other places.

Your point about the complexity is also correct, but perhaps someone 
will offer a better solution to speeding up select(). I think anything 
as major as this might be better off in a development series, and that's 
a clear prod for someone to find a simpler way to do it ;-)

Old programs grow; INN uses select and worked fine with 10-20 peers, 
with 200 peers sharing 2m articles and 1 TB of data it seems to work 
less well on Linux than BSD or Solaris. I'd love to see faster, there 
are lots of other servers out there as well.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
