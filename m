Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136629AbRASBiE>; Thu, 18 Jan 2001 20:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136632AbRASBhy>; Thu, 18 Jan 2001 20:37:54 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:47523 "HELO
	localdomain") by vger.kernel.org with SMTP id <S136629AbRASBhp>;
	Thu, 18 Jan 2001 20:37:45 -0500
From: Davide Libenzi <davidel@xmail.virusscreen.com>
Organization: myCIO.com
Date: Thu, 18 Jan 2001 17:38:30 -0800
X-Mailer: KMail [version 1.1.95.5]
Content-Type: text/plain;
  charset="us-ascii"
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
To: Mike Kravetz <mkravetz@sequent.com>, Andi Kleen <ak@suse.de>
In-Reply-To: <20010119012616.D32087@athlon.random> <20010119020852.A6973@gruyere.muc.suse.de> <20010118172344.I8637@w-mikek.des.sequent.com>
In-Reply-To: <20010118172344.I8637@w-mikek.des.sequent.com>
Subject: Re: multi-queue scheduler update
MIME-Version: 1.0
Message-Id: <01011817383000.01413@ewok.dev.mycio.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 January 2001 17:33, Mike Kravetz wrote:
> On Fri, Jan 19, 2001 at 02:08:52AM +0100, Andi Kleen wrote:
> > On Thu, Jan 18, 2001 at 08:00:16PM -0500, Mark Hahn wrote:
> > > > >                            microseconds/yield
> > > > > # threads      2.2.16-22           2.4        2.4-multi-queue
> > > > > ------------   ---------         --------     ---------------
> > > > > 16               18.740            4.603         1.455
> > > >
> > > > I remeber the O(1) scheduler from Davide Libenzi was beating the
> > > > mainline O(N)
> > >
> > > isn't the normal case (as in "The Right Case to optimize")
> > > where there are close to zero runnable tasks?  what realistic/sane
> > > scenarios have very large numbers of spinning threads?  all server
> > > situations I can think of do not.  not volanomark -loopback, surely!
> >
> > I think the main point of Mike's patch is decreasing locking and cache
> > line bouncing overhead of multi cpu scheduling, not optimizing lots of
> > runnable tasks.
> >
> >
> > -Andi
>
> Andi is correct.  Although the results I posted may seem to indicate
> we are concentrating on high thread counts, this is really secondary
> to reducing lock contention within the scheduler.  A co-worker down
> the hall just ran pgbench (a postgresql db) benchmark and saw
> contention on the runqueue lock at 57%.  Now, I know nothing about this
> benchmark, but it will be interesting to see what happens after
> applying my patch.

Yep, the patch work in a different way and if these are the numbers it seems 
to be interesting.
Could You post results for a fewer number of tasks ?
I mean what is the performance loss for 1,2,..,5 tasks ?

To test You can use lmbench ( I don't remember the link ) and I should have 
the program I've used to test my patch somewhere.


- Davide
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
