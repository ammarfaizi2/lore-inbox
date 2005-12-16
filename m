Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbVLPAhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbVLPAhL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 19:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVLPAhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 19:37:11 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:45201 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751192AbVLPAhJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 19:37:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sPGZ5j+t0sAKM28rSLTgsfwJliu6q+VCaPj5Gban4gVSTWdmeIfpnoS98yAF/94P3wNKOqO1v8YnO4aQNv3wPOC6UNGY/fXapeEYyyeqXqEMM97WSvGEq24tqutzSeeob+Cax3H4LPvXesKAb7EcBkr0dYmB6IKWN0O0WzK3nGw=
Message-ID: <2c0942db0512151637o3c95239ha2f2bee20923b276@mail.gmail.com>
Date: Thu, 15 Dec 2005 16:37:08 -0800
From: Ray Lee <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, arjan@infradead.org
In-Reply-To: <1134688488.12086.172.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051215212447.GR23349@stusta.de>
	 <20051215140013.7d4ffd5b.akpm@osdl.org>
	 <20051215223000.GU23349@stusta.de>
	 <43A1DB18.4030307@wolfmountaingroup.com>
	 <1134688488.12086.172.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Man, I've been holding my tongue on this conversation for a while,
but it seems my better angels have deserted me.)

On 12/15/05, Lee Revell <rlrevell@joe-job.com> wrote:
> Bugzilla link please.

No, that's not how failure engineering is done. A guy designing a
bridge doesn't cut all the supports back to the bare minimum just to
save money because his design says that the remaining metal should be
strong enough. If you can't prove it, and it's a safety issue
(continuing my analogy in the physical world), then you engineer for
failure. Can you handle all occurrences? No, a hurricane Katrina comes
along every once in a while. Can you weather more than you did before?
Yes. In the meantime, their are fewer poor sods falling off the bridge
that have to open a bugzilla report.

The world of software is no different. If someone wants to remove the
8k stacks option, they'd better prove that they're making my servers
more reliable. I've seen zero arguments for why 8k stacks is unviable.
(I've also wondered why we can't just have IRQ stacks plus 8k thread
stacks -- seemingly the best of both worlds) Instead, what I've seen
is that we have coders who don't like the idea of any non-order-zero
allocations taking place, because big systems running poorly coded
Java apps with massive threading can hit problems with allocations
from time to time.

The answer for that is the same answer the kernel community usually
gives about poorly designed userspace applications: rewrite them.

I'm quite open to being proved wrong. If someone has a counter case
they can toss forth, please do so. Systems taking lots of interrupts?
Then how about 8k + IRQ stacks? With a counterexample I'll gladly
concede that I'm an ignorant slut[*] -- excuse me, Saturday Night Live
flashbacks -- an ignorant git, and shut up. ([*] is only half right,
I'm not all that ignorant).

If someone doesn't show a counter case, then may I suggest people
consider the possibility that this is not proper engineering. Prove
it, or provide a safety blanket. But don't yank the blanket without
proving the lack of problem.

Ray
