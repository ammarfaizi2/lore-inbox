Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289608AbSAJTK7>; Thu, 10 Jan 2002 14:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289593AbSAJTKu>; Thu, 10 Jan 2002 14:10:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17167 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289586AbSAJTKh>; Thu, 10 Jan 2002 14:10:37 -0500
Date: Thu, 10 Jan 2002 11:09:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Mike Kravetz <kravetz@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.40.0201101107350.1493-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201101107120.2809-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Jan 2002, Davide Libenzi wrote:
> >
> > It wasn't a good night for benchmarking.  I had a typo in the
> > script to run chat reniced and as a result didn't collect any
> > numbers for this.  In addition, the kernel with Davide's patch
> > failed to boot with 8 CPUs enabled.  Can't see any '# CPU specific'
> > mods in the patch.  In any case, here is what I do have.
>
> Doh !! Do you have a panic dump Mike ?

I bet it's just the placement of "init_idle()" in init/main.c, which is
unrelated to the scheduling proper, but if the kernel thread is started
before the boot CPU has done its "init_idle()", then the scheduler state
isn't really set up fully yet.

(Old bug, I think its been there for a long time, I just think that the
old scheduler didn't much care, and the "child runs first" logic in
particular of the new scheduler probably just showed it more clearly)

		Linus

