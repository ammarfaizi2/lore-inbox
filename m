Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287852AbSATCDA>; Sat, 19 Jan 2002 21:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287854AbSATCCu>; Sat, 19 Jan 2002 21:02:50 -0500
Received: from femail45.sdc1.sfba.home.com ([24.254.60.39]:64971 "EHLO
	femail45.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S287852AbSATCC3>; Sat, 19 Jan 2002 21:02:29 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "David Luyer" <david_luyer@pacific.net.au>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "'Oliver Xymoron'" <oxymoron@waste.org>
Subject: Re: vm philosophising
Date: Sat, 19 Jan 2002 13:00:23 -0500
X-Mailer: KMail [version 1.3.1]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <004301c1a0a3$bd172a90$46943ecb@pacific.net.au>
In-Reply-To: <004301c1a0a3$bd172a90$46943ecb@pacific.net.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020120020228.SNES23469.femail45.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 January 2002 11:42 pm, David Luyer wrote:

> And while precommit may be something people ask for, I'd have to say
> many
> of them would, having experienced the difference on identical hardware,
> then realise what a bad idea it was and go back to the current mode.
> That is, it sounds like a big waste of time to implement the
> 'traditional'
> behaviour which Linux is already so much better than.
>
> David.

Precommit basically just asks the application to die when it first allocates 
memory if it's even possible for it to die in the most pathlogical usage case 
of that memory.

I.E. "die up front" instead of "die while running".  (There's no possible way 
this can improve performance.  If you want to never swap, just don't mount a 
swap partition.)  You don't even have to change the VM's behavior, it can 
still copy on write and such.  You just add a test to cause allocations to 
fail unnecessarily at times.

Throwing in a little extra code on mmaps and allocations to kill a process 
wouldn't be too hard.  It would be stupid outside of something like a 
financial transaction system (and probably even in there), but it technically 
shouldn't be all that hard to do.

Unless I missed something...?

Rob
