Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWGLWMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWGLWMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWGLWML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:12:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:3293 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750761AbWGLWMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:12:03 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] let CONFIG_SECCOMP default to n
Date: Thu, 13 Jul 2006 00:06:12 +0200
User-Agent: KMail/1.9.3
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>
References: <20060630014050.GI19712@stusta.de> <p73wtain80h.fsf@verdi.suse.de> <20060712210732.GA10182@elte.hu>
In-Reply-To: <20060712210732.GA10182@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607130006.12705.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 23:07, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > If the TSC disabling code is taken out the runtime overhead of seccomp 
> > is also very small because it's only tested in slow paths.
> 
> correct. But when i suggested to do precisely that i got a rant from 
> Andrea of how super duper important it was to disable the TSC for 
> seccomp ... (which argument is almost total hogwash)

I wouldn't call it completely hogwash - there was a published paper
with a demo of an attack - but still the attack required to so much
preparation and advance knowledge of the system that it seemed
more of academical value to me. At least for the standard kernel
we chose to not care about it. So for seccomp it was also not needed
imho.

> 
> so i'm going with the simpler path of making seccomp default-off. (which 
> solves the problem as far as i'm concerned - i.e. no default overhead in 
> the scheduler.)

I think without the context switch overhead it's a moderately useful facility.
Ok currently near nobody uses it, but having a very lightweight sandbox
with simple security semantics and that's easy to use is a useful 
facility for more secure user space.

It certainly would need to be better advertised to be any useful.
e.g. with a simple user space library that makes it easy to use.

> 
> but Andrea's creative arguments wrt. his decision to not pledge the 
> seccomp related patent to GPL users makes me worry about whether this 
> technology is untainted. 

I don't know any details about this, but I would generally trust Andrea not to
attempt to do anything evil regarding kernel & patents.

> 
> another problem is the double standard Andrea's code is enjoying. 
> Despite good resons to apply the patch, it has not been applied yet, 
> with no explanation. Again, i request the patch below to be applied to 
> the upstream kernel. 

I can put in a patch into my tree for the next merge to disable the TSC
disable code on i386 too like I did earlier for x86-64.

I don't have a great opinion on the Kconfig defaults, so I won't put
in a patch for that.

-Andi
