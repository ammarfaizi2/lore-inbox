Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129160AbRA3LWd>; Tue, 30 Jan 2001 06:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRA3LWX>; Tue, 30 Jan 2001 06:22:23 -0500
Received: from hermes.mixx.net ([212.84.196.2]:51727 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129160AbRA3LWG>;
	Tue, 30 Jan 2001 06:22:06 -0500
Message-ID: <3A76A35F.6CD57281@innominate.de>
Date: Tue, 30 Jan 2001 12:19:59 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Kernel Janitor's TODO list
In-Reply-To: <3A74451F.DA29FD17@uow.edu.au> <E14NPEr-0005LR-00@halfway>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> In message <3A74451F.DA29FD17@uow.edu.au> you write:
> >       http://www.uwsg.iu.edu/hypermail/linux/kernel/0005.3/0269.html
> >
> > A lot of the timer deletion races are hard to fix because of
> > the deadlock problem.
> 
> Hmmm...
> 
>         For 2.5, changing the timer interface to disallow mod_timer or
> add_timer (equivalent) on self, and making the timerfn return num
> jiffies to next run (0 = don't rerun) would solve this, right?
> I don't see a maintainable way of solving this otherwise,

It seems silly not to provide direct support for such a simple, useful
mechanism as a periodic timer.  This can be accomplished easily by
adding a field 'periodic' to struct timer_list.  If 'periodic' is
non-zero then run_timer_list uses it to set the 'expires' field and
re-inserts the timer.

For what it's worth, this is backward compatible with the existing
strategy.  The timer_list->function is still in complete control of
things if it wants to be, but forbidding it from re-adding itself sounds
like an awfully good idea.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
