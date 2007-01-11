Return-Path: <linux-kernel-owner+w=401wt.eu-S964937AbXAKDQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbXAKDQX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 22:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbXAKDQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 22:16:23 -0500
Received: from smtp.osdl.org ([65.172.181.24]:51006 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbXAKDQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 22:16:22 -0500
Date: Wed, 10 Jan 2007 19:15:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Aubrey <aubreylee@gmail.com>
cc: Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org, mjt@tls.msk.ru
Subject: Re: O_DIRECT question
In-Reply-To: <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0701101910110.3594@woody.osdl.org>
References: <6d6a94c50701101857v2af1e097xde69e592135e54ae@mail.gmail.com>
 <Pine.LNX.4.64.0701101902270.3594@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jan 2007, Linus Torvalds wrote:
> 
> So don't use O_DIRECT. Use things like madvise() and posix_fadvise() 
> instead. 

Side note: the only reason O_DIRECT exists is because database people are 
too used to it, because other OS's haven't had enough taste to tell them 
to do it right, so they've historically hacked their OS to get out of the 
way.

As a result, our madvise and/or posix_fadvise interfaces may not be all 
that strong, because people sadly don't use them that much. It's a sad 
example of a totally broken interface (O_DIRECT) resulting in better 
interfaces not getting used, and then not getting as much development 
effort put into them.

So O_DIRECT not only is a total disaster from a design standpoint (just 
look at all the crap it results in), it also indirectly has hurt better 
interfaces. For example, POSIX_FADV_NOREUSE (which _could_ be a useful and 
clean interface to make sure we don't pollute memory unnecessarily with 
cached pages after they are all done) ends up being a no-op ;/

Sad. And it's one of those self-fulfilling prophecies. Still, I hope some 
day we can just rip the damn disaster out.

			Linus
