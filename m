Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313300AbSEYDPR>; Fri, 24 May 2002 23:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSEYDPQ>; Fri, 24 May 2002 23:15:16 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:14099 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S313300AbSEYDPP>; Fri, 24 May 2002 23:15:15 -0400
Message-ID: <3CEF0157.ACF6518E@opersys.com>
Date: Fri, 24 May 2002 23:13:27 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205241619590.28735-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> On Fri, 24 May 2002, Karim Yaghmour wrote:
> >
> > This matter remained unchanged until the FSF came out later and
> > declared publicly that the patent was violating the GPL.
> 
> Side note: they did this, apparently while Caldera was in the process of
> suing FSMlabs over the fact that they didn't want to pay for their
> OpenUnix usage... Hmm..

Speaking of suing, did you know that FSMLabs filed suit against Lineo
in the federal court of Delaware last June. Lineo's licensing of FSMLabs
"technology" only came after that.

> > I could have understood that this was indeed genuine, but here we
> > have Eben Moglen, a respected lawyer,
> 
> I would be a _lot_ happier with Moglen if he didn't have so many ties to
> the FSF, and being biased. These days you can apparently buy a "gpl
> compliance certification" from the FSF for $20k. Those kinds of ties do
> _not_ make me any happier about the FSF's status as an independent entity.

Aside from your personal opinion about the FSF and Moglen, I find it
unfortunate that you don't take the time to investigate this a little
bit further on your own before dismissing it altogether.

> The RT part of an app under RTLinux has to be a kernel module anyway,

This is incorrect, see below.

> and as I personally consider the GPL to be the only kind of module I care
> about, I think that is good.

First:
There's another real-time extension for Linux called RTAI that is unrelated
to RTLinux.

Second:
I said in my previous email that RTAI provides a facility to enable user-space
processes to become hard-real-time tasks using a single system call. There
are no modules involved in this. You start the RT process exactly as you
would start another process on the command line and it enters hard-real-time
mode using the call I mentionned earlier.

Here's an example:

int main(int argc, char *argv[])
{

...
        mlockall(MCL_CURRENT | MCL_FUTURE);

 	if (!(hrttsk = rt_task_init(hrttsk_name, 1, 0, 0))) {
		printf("CANNOT INIT MASTER TASK\n");
		exit(3);
	}

	if (oneshot) rt_set_oneshot_mode();
	else rt_set_periodic_mode();
	period = (int) nano2count((RTIME)periodns);
	start_rt_timer(period);

        if (uspsh) rt_usp_signal_handler(handler);

        if (softhard) {
                rt_make_hard_real_time();
        }

	rt_task_make_periodic(hrttsk, rt_get_time() + period, period);

...
}

Starting from the call to rt_mak_hard_real_time() this Linux _process_
has now become a hard-real-time task scheduled by RTAI.

Mind you, all of this is in __USER-SPACE__. There are no modules involved.

Yet, even though this is entirely done in user-space, this isn't allowed
by the patent.

> Whatever non-RT tools used to visualize the RT data equally clearly aren't
> covered by _that_ particular patent, so I think the whole thing is a
> complete and utter red herring.

I'm sorry, but I'm missing the point here about visualization tools.
Such tools are not part of any of the real-time Linux community's
concerns.

That said, if you feel better seing this as a red herring, then feel
free to do so. Real-time developers who actually have to choose a real
OS for their application, however, are seing Linux as the red herring.
And as long as you continue to ignore this problem, they will continue
to choose other OSes over Linux.

I don't like to be saying any of this, but this is exactly what is
happening every day in the field.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
