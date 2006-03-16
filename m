Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWCPRSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWCPRSi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbWCPRSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:18:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16352 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752436AbWCPRSh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:18:37 -0500
Date: Thu, 16 Mar 2006 09:18:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       inux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #5] 
In-Reply-To: <21253.1142509812@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603160914410.3618@g5.osdl.org>
References: <20060315200956.4a9e2cb3.akpm@osdl.org> 
 <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com>
  <21253.1142509812@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2006, David Howells wrote:
> 
> More or less, I think; but Nick has raised a good point about whether I should
> be mentioning the existence of things like caching at all in the document,
> except to say that memory barriers can't be assumed to have any effect on them.
> 
> The problem is that if I don't mention caches, I get lots of arguments about
> the effects locking primitives have (since in modern CPUs these happen within
> the caches and not much within memory). I can't just say these things affect
> memory because it's just not necessarily true:-/

Well, the argument I have against mentioning caches is that cache 
coherency order is _not_ the only thing that is relevant. As already 
mentioned, data speculation can cause exactly the same "non-causal" effect 
as cache update ordering, so from a _conceptual_ standpoint, the cache is 
really just one implementation detail in the much bigger picture of 
buffering and speculative work re-ordering operations...

So it might be a good idea to first explain the memory barriers in a more 
abstract sense without talking about what exactly goes on, and then have 
the section that gives _examples_ of what the CPU actually is doing that 
causes these barriers to be needed. And make it clear that the examples 
are just that - examples.

		Linus
