Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQK3VWu>; Thu, 30 Nov 2000 16:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129426AbQK3VWk>; Thu, 30 Nov 2000 16:22:40 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3844 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129385AbQK3VW2>;
	Thu, 30 Nov 2000 16:22:28 -0500
Message-ID: <20001130010057.B124@bug.ucw.cz>
Date: Thu, 30 Nov 2000 01:00:57 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
        Tigran Aivazian <tigran@veritas.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no RLIMIT_NPROC for root, please
In-Reply-To: <20001128214309.F2680@sith.mimuw.edu.pl> <Pine.LNX.4.21.0011282049470.1940-100000@penguin.homenet> <20001128221155.G2680@sith.mimuw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001128221155.G2680@sith.mimuw.edu.pl>; from Jan Rekorajski on Tue, Nov 28, 2000 at 10:11:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On Tue, 28 Nov 2000, Jan Rekorajski wrote:
> > > --- linux/kernel/fork.c~	Tue Sep  5 23:48:59 2000
> > > +++ linux/kernel/fork.c	Sun Nov 26 20:22:20 2000
> > > @@ -560,7 +560,8 @@
> > >  	*p = *current;
> > >  
> > >  	retval = -EAGAIN;
> > > -	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur)
> > > +	if (p->user->uid &&
> > > +	   (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur))
> > 
> > Jan,
> > 
> > Hardcoding things signifying special treatment of uid=0 is almost always a
> > bad idea. If you _really_ think that superuser (whatever entity that might
> > be) should be exempt from RLIMIT_NPROC and can prove that (SuSv2 seems to
> > be silent so you may be right), then you should use capable() to do proper
> > capability test and not that horrible explicit uid test as in your patch
> > above.
> 
> Ok, how about setting limits on login? When this looks like:
> 
> --- uid = 0 here
> setrlimit(RLIMIT_NPROC, n)
> fork()		<- this will fail if root has >n processes
> setuid(user)
> 
> and it is hard to change this sequence, all PAM enabled apps depend
> on it :(

So PAM dictates kernel changes? Fix pam, do not break kernel.
									Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
