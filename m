Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbSAGQov>; Mon, 7 Jan 2002 11:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276424AbSAGQol>; Mon, 7 Jan 2002 11:44:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32262 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274862AbSAGQoa>; Mon, 7 Jan 2002 11:44:30 -0500
Date: Mon, 7 Jan 2002 08:43:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthias Hanisch <mjh@vr-web.de>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Mikael Pettersson <mikpe@csd.uu.se>, <axboe@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre performance degradation on an old 486
In-Reply-To: <Pine.LNX.4.10.10201070803290.135-100000@pingu.franken.de>
Message-ID: <Pine.LNX.4.33.0201070841260.6450-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Jan 2002, Matthias Hanisch wrote:
>
> To answer your question, I wanted to profile 2.5.2-pre8 against
> 2.5.2-pre8-old-scheduler. _Fortunately_ I made some mistake and forgot to
> back out the following chunk of memory.
>
> --- v2.5.1/linux/arch/i386/kernel/process.c     Thu Oct  4 18:42:54 2001
> +++ linux/arch/i386/kernel/process.c    Thu Dec 27 08:21:28 2001
> @@ -125,7 +125,6 @@
>         /* endless idle loop with no priority at all */
>         init_idle();
>         current->nice = 20;
> -       current->counter = -100;
>
>         while (1) {
>                 void (*idle)(void) = pm_idle;

Hey, that would do it. It looks like the idle task ends up being a
_normal_ process (just nice'd down), so it will get real CPU time instead
of only getting scheduled when nothing else is runnable.

Davide, I think the bounce-buffer is a red herring, it's simply that we're
wasting time in idle..

		Linus

