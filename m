Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155143AbPFOAqF>; Mon, 14 Jun 1999 20:46:05 -0400
Received: by vger.rutgers.edu id <S154873AbPFOApL>; Mon, 14 Jun 1999 20:45:11 -0400
Received: from [208.232.87.36] ([208.232.87.36]:34130 "HELO CAraptorUU.geoworks.com") by vger.rutgers.edu with SMTP id <S154920AbPFOAlx>; Mon, 14 Jun 1999 20:41:53 -0400
Date: Mon, 14 Jun 1999 17:43:00 -0700
From: Mike Touloumtzis <miket@geoworks.com>
To: Pavel Machek <pavel@bug.ucw.cz>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.rutgers.edu
Subject: Re: size of pid_t (was: Re: NR_TASKS as config option)
Message-ID: <19990614174300.L22748@sarcastro.geoworks.com>
References: <UTC199906131847.UAA26622.aeb@eland.cwi.nl> <19990613214810.A548@bug.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <19990613214810.A548@bug.ucw.cz>; from Pavel Machek on Sun, Jun 13, 1999 at 09:48:10PM +0200
Sender: owner-linux-kernel@vger.rutgers.edu


Some Unices (AIX?) use random PID allocation to make PID
prediction more difficult.  Is this perceived to be worth
it, or is it a non-issue?

miket

On Sun, Jun 13, 1999 at 09:48:10PM +0200, Pavel Machek wrote:
>
> > 
> > Yes, eventually we'll have to.
> > But a 32-bit pid_t is not so bad:
> > With a hundred new processes spawned every second
> > a 32-bit pid_t will wrap only after about 500 days.
> 
> Everyone should assume PID's are being reused! If you have buggy apps
> which assume pid's not to be reused, then just watch your proc and
> reboot when you are coming to 2G-th process ;-). (Ok, there's one bug
> in kernel w.r.t. pid wrapparound - in console and it allows console
> user to send arbitrary signals to newly created processes.)
> 
> What is bad is that clusters pretty much need 32bit pids... 
> 
> > Conclusion:
> > - a 64-bit pid_t is most convenient for the kernel, but
> >   gives trouble with libc.
> > - a 32-bit pid_t is what we have today, but we use only
> >   15 bits because of SYSV IPC (or perhaps other reasons
> >   I am unaware of).
> 
> And becuase /proc internals. But please please go and change it.
> 
> 								Pavel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
