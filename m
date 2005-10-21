Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbVJUNDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVJUNDh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 09:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbVJUNDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 09:03:36 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:45311 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964936AbVJUNDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 09:03:36 -0400
Date: Fri, 21 Oct 2005 09:03:18 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Yitzchak Eidus <ieidus@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about code from the linux kernel development ( se )
 book
In-Reply-To: <e7aeb7c60510210422s33c0240ex4eab1d90d94111fe@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0510210848030.3903@localhost.localdomain>
References: <e7aeb7c60510210422s33c0240ex4eab1d90d94111fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh God, please indent code examples, and if your email client strips white
space, change your email client.

On Fri, 21 Oct 2005, Yitzchak Eidus wrote:

> first i am very sorry if it isnt the place to ask questions like this
> but i didnt know where else to ask ( i tryed irc channels and i was
> send from there to this list )
> anyway:
> does this following code look buggy? :

[ Indention added ]

> DECLARE_WAITQUEUE ( wait , current );
> add_wait_queue ( q , &wait );
> while ( !condition ) {
>         set_current_stat ( TASK_INTERRUPTABLE ); i
>         if ( signal_pending ( current ) )
>                 /* handle signal */

I assume that the signal_pending is the if result and not the schedule.
Since there was no indentation I couldn't tell.

>         schedule ( );
/* Moved brace down added */
 }
> set_current_state ( TASK_RUNNING );
> remove_wait_queue ( q , &wait );

Before I go to your questions, I'll first answer that this _is_ buggy
code.  If the condition is checked and you are woken up between the
while (!condition) and the set_current_state, then you will end up
sleeping forever or until someone sends you a signal.

> first:doesnt in the way from checking the !condition to
> set_current_state  the condition can be changed no?

Yes, and then put it again after schedule.

>
> second:why not putting the schedule ( ); right after the
> set_current_state ( ) , what the point in checking the if (
> signal_pending ( ) first, if the proccess doesnt started to sleep yet?

Yes, I would put the signal_pending check after the schedule (as most of
the kernel does this).

> third: in the cleaning in the way from putting the set_current_state (
> TASK_RUNNING ) into remove_wait_queue , cant the queue wait list ( q )
> wake up again the wait procsess?

Yeah, so?  There's no harm in that, except for an extra cpu cycles that
are done to wake it up.  That, I wouldn't change.

> ( thnks for the help , please if it can be done answer quickly i am
> tanker in the idf and need to come back to the army soon , ( no
> internet there... ) )

BTW, this is not an IRC, we use normal capitalization and normal spelling
(when we know how to spell a word ;-).  So the next time you send to the
list, send it as if you were writing a serious letter, or you may just be
ignored. (as you might have been if I didn't respond).

-- Steve
