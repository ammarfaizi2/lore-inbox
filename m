Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270624AbSISJMl>; Thu, 19 Sep 2002 05:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270630AbSISJMl>; Thu, 19 Sep 2002 05:12:41 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55426 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S270624AbSISJMl>;
	Thu, 19 Sep 2002 05:12:41 -0400
Date: Thu, 19 Sep 2002 11:25:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209182304040.4563-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209191116070.2377-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Sep 2002, Linus Torvalds wrote:

> However:
> 
> >  	read_lock(&tasklist_lock);
> > - 	for_each_process(p) {
> > -		if ((tty->session > 0) && (p->session == tty->session) &&
> > -		    p->leader) {
> > -			send_sig(SIGHUP,p,1);
> > -			send_sig(SIGCONT,p,1);
[...]

> This looks a bit wrong. In particular, the old code used to set "p->tty"  
> to NULL if it matched any process, while the new code only does that for
> processes in the right session. Hmm?

i had this code changed back and forth twice already, because i was unsure
whether it's correct. It's true that it's not an equivalent
transformation, but after some thinking it looked correct to me. Isnt
there a 1:1 relationship between the tty and the session ID in this case?
Ie. the previous code was pessimistic and just scanned for matching
p->tty's outside of the tty->session == p->session space, but it should
not have done so.

i'll add some debugging code to the old code to print out cases when
p->tty == tty but p->session != tty->session and start up X, that should
prove or disprove this theory, right?

(i cant remember any other place where the code transformation was not
identity, but will double-check this again.)

William, you did the original transformation, was this optimization done
intentionally?

	Ingo

