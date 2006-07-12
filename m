Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWGLWMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWGLWMG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWGLWMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:12:06 -0400
Received: from ns2.suse.de ([195.135.220.15]:4317 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751457AbWGLWMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:12:03 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Date: Thu, 13 Jul 2006 00:11:38 +0200
User-Agent: KMail/1.9.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712212245.GB10944@elte.hu>
In-Reply-To: <20060712212245.GB10944@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607130011.39014.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 23:22, Ingo Molnar wrote:

> 
> i think Andrea didnt even try to fix/generalize ptrace perhaps because 
> that would make his 'security feature' too banal? 

seccomp in its current state is already "banal". I think that was the
whole point of it. If he had wanted to do something complicated I'm sure
LSM would have offered lots of opportunity to go wild @). But seccomp
is really simple and easy to analyze. I bet if he could have made
it simpler he would have done that too.

That said the problems I see with using ptrace for this is that it
just adds too many context switches for each syscall and would be likely too slow.
Hmm, actually there might not be that many syscalls for these applications
(just some reads and writes) so it might work or not. But it would certainly be slower 
than it is right now. Would probably need some testing.

If utrace allows to do the filtering in kernel space it would 
be probably a useful replacement. I don't remember enough of the code
to know if it can do this or not. But I suppose it would still
need a kernel module or kernel patch of some sort to implement this
specific filtering.

> there's 
> nothing inherently insecure about the _client side_ of the ptrace APIs 
> or the client side of ptrace implementation. 

Agreed. 

> So my suggestion is to get  
> utrace in, to implement an utrace module that implements untrusted code 
> execution and then lets get rid of seccomp.

Sounds fine to me in theory (without having looked at any code) 

-Andi
