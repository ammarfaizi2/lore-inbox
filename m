Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752488AbWCQBUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbWCQBUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbWCQBUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:20:45 -0500
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:33423 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1752490AbWCQBUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:20:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=v8Ao/nU0kRCE02F+SLOG/5vAEUXqOAVfjsD78SOIUhJPsDvIaqchfioK331ite7zQ0kL09de8SqVaxYKM3GhFOrPUiKHaM4PVoKAFlVrV1yAxRpqsm28H4gtHF+3cmoe2BxKDFgTgg3aLTEKejEtfglrQ1XlHl0NrKYinVjo1CA=  ;
Message-ID: <441A0EE7.60809@yahoo.com.au>
Date: Fri, 17 Mar 2006 12:20:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #5]
References: <20060315200956.4a9e2cb3.akpm@osdl.org>  <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com>  <21253.1142509812@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0603160914410.3618@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603160914410.3618@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Well, the argument I have against mentioning caches is that cache 
> coherency order is _not_ the only thing that is relevant. As already 
> mentioned, data speculation can cause exactly the same "non-causal" effect 
> as cache update ordering, so from a _conceptual_ standpoint, the cache is 
> really just one implementation detail in the much bigger picture of 
> buffering and speculative work re-ordering operations...
> 

Agreed. I wonder how you can best illustrate the theoretical machine
model (from a programmer's point of view). I guess each consistency
domain has an horizon (barrier, but I'm trying to avoid that word in
this context) over which memory barriers will provide some partial
ordering on transactions going to and/or from the horizon.

            +---+   :   |c
            |CPU|---:---|a m
            +---+   :   |c e
                    :   |h m
            +---+   :   |e o
            |CPU|---:---|d r
            +---+   :   |  y

I guess you could think of a smp_wmb() in this case being a wall that
moves out from the CPU along with other memory stores, and stops them
from passing (the problem with a "wall" is that it doesn't easily apply
to a full smp_mb() unless you have loads travelling the same way, which
has its own intuitiveness problems).

> So it might be a good idea to first explain the memory barriers in a more 
> abstract sense without talking about what exactly goes on, and then have 
> the section that gives _examples_ of what the CPU actually is doing that 
> causes these barriers to be needed. And make it clear that the examples 
> are just that - examples.
> 

Yeah that would be nice. The abstract explanation will be tricky. Maybe
it isn't so critical to be easily understandable if it is backed by
examples.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
