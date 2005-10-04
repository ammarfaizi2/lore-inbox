Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbVJDBGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVJDBGv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 21:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVJDBGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 21:06:51 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:65437 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750892AbVJDBGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 21:06:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=XWyrlX8ppauClzSB1hyBVKbFnAtRTC7rR/On1uNyOK+NEULZ0uh83hA5/gM03eYmp0Iy9AXAcUKxZX4gfmbQVQMbm4pvO/lrDDngVe5Tsx4IlugUvknIj5E/nPSt8TbSdSMjimPzeHMm6CBGwOStS7zLxLAtRZqlGoVrMFAc0Mg=  ;
Subject: Re: [RFC] mempool_alloc() pre-allocated object usage
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Paul Mundt <paul.mundt@nokia.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4341476A.80809@didntduck.org>
References: <20051003143634.GA1702@nokia.com> <4341476A.80809@didntduck.org>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 11:06:16 +1000
Message-Id: <1128387976.12501.12.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-03 at 10:59 -0400, Brian Gerst wrote:
> Paul Mundt wrote:
> > The downside to this is that some people may be expecting that
> > pre-allocated elements are used as reserve space for when regular
> > allocations aren't possible. In which case, this would break that
> > behaviour.
> 
> This is the original intent of the mempool.  There must be objects in 
> reserve so that the machine doesn't deadlock on critical allocations 
> (ie. disk writes) under memory pressure.
> 

No, the semantics are that at least 'min' objects must be able to
be allocated at one time. The user must be able to proceed far enough
to release its objects in this case, and that ensures no deadlock.

The problem with using the pool first is that it requires the lock
to be taken and is also not NUMA aware. So from a scalability point of
view, I don't think it is a good idea.

Perhaps you could introduce a new mempool allocation interface to do
it your way?

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
