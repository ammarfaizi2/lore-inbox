Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155388AbPFNTvC>; Mon, 14 Jun 1999 15:51:02 -0400
Received: by vger.rutgers.edu id <S155064AbPFNTqU>; Mon, 14 Jun 1999 15:46:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:23134 "EHLO atrey.karlin.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S155023AbPFNTla>; Mon, 14 Jun 1999 15:41:30 -0400
Message-ID: <19990613214810.A548@bug.ucw.cz>
Date: Sun, 13 Jun 1999 21:48:10 +0200
From: Pavel Machek <pavel@bug.ucw.cz>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: size of pid_t (was: Re: NR_TASKS as config option)
References: <UTC199906131847.UAA26622.aeb@eland.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <UTC199906131847.UAA26622.aeb@eland.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Jun 13, 1999 at 08:47:08PM +0200
Sender: owner-linux-kernel@vger.rutgers.edu

Hi!

>         I'd actually like to see a 64-bit pid_t.
>         First of all, I've already once being bitten
>         by a bug caused by a re-used PID...
> 
> Yes, eventually we'll have to.
> But a 32-bit pid_t is not so bad:
> With a hundred new processes spawned every second
> a 32-bit pid_t will wrap only after about 500 days.

Everyone should assume PID's are being reused! If you have buggy apps
which assume pid's not to be reused, then just watch your proc and
reboot when you are coming to 2G-th process ;-). (Ok, there's one bug
in kernel w.r.t. pid wrapparound - in console and it allows console
user to send arbitrary signals to newly created processes.)

What is bad is that clusters pretty much need 32bit pids... 

> Conclusion:
> - a 64-bit pid_t is most convenient for the kernel, but
>   gives trouble with libc.
> - a 32-bit pid_t is what we have today, but we use only
>   15 bits because of SYSV IPC (or perhaps other reasons
>   I am unaware of).

And becuase /proc internals. But please please go and change it.

								Pavel
-- 
I'm really pavel@ucw.cz. Look at http://195.113.31.123/~pavel.  Pavel
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
