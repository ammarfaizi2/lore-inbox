Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131356AbQKRWcS>; Sat, 18 Nov 2000 17:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131495AbQKRWcK>; Sat, 18 Nov 2000 17:32:10 -0500
Received: from [194.213.32.137] ([194.213.32.137]:9220 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131356AbQKRWb6>;
	Sat, 18 Nov 2000 17:31:58 -0500
Message-ID: <20001118214906.D382@bug.ucw.cz>
Date: Sat, 18 Nov 2000 21:49:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: KPATCH] Reserve VM for root (was: Re: Looking for better VM)
In-Reply-To: <200011142012.VAA00150@bug.ucw.cz> <Pine.LNX.4.30.0011161513480.20626-100000@fs129-190.f-secure.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0011161513480.20626-100000@fs129-190.f-secure.com>; from Szabolcs Szakacsits on Thu, Nov 16, 2000 at 04:01:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >    >main() { while(1) if (fork()) malloc(1); }
> >    >With the patch below I could ssh to the host and killall the offending
> >    >processes. To enable reserving VM space for root do
> > what about main() { while(1) system("ftp localhost &"); }
> > This. or so,ething similar should allow you to kill your machine
> > even with your patch from normal user account
> 
> This or something similar didn't kill the box [I've tried all local
> DoS from Packetstorm that I could find]. Please send a working

Sorry, I did not have working example, just feeling that something
like that should be possible.

> Note, I'm not discussing "local user can kill the box without limits",
> I say Linux "deadlocks" [it starts its own autonom life and usually
> your only chance is to hit the reset button] when there is continuous
> VM pressure by user applications. If you think fork() kills the box

That's clear bug, right? It should not deadlock, it should go to
OOM-killer and kill someone.

> BTW, I have a new version of the patch with that Linux behaves much
> better from root's point of view when the memory is more significantly
> overcommited. I'll post it if I have time [and there is interest].

There is interest. Yesterday atrey died due userland process eating
all memory.
								Pavel
PS: atrey is machine that gets my mail, so it is kind of important to
me.
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
