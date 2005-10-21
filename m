Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVJUOlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVJUOlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 10:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbVJUOlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 10:41:06 -0400
Received: from xproxy.gmail.com ([66.249.82.193]:24888 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964961AbVJUOlF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 10:41:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dum1ubhHq4xEX5dPibgZgzRzCqqdi31v3vUFrQOPkXy8OCK7mIYJIcRRWKzEEvlfpKeNBBUQYwfQyQaIXiGfhU5g2AoB0iWpEJd+c3lIQWU+S1PsdU6ETR2tpyAs09fbbJ38cUIeVxJMfDxkR2SIzT+Vc+rwJh1p+5cZ0hL2W14=
Message-ID: <e7aeb7c60510210741r44292294yaa2ab0998dbde6cc@mail.gmail.com>
Date: Fri, 21 Oct 2005 16:41:04 +0200
From: Yitzchak Eidus <ieidus@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: question about code from the linux kernel development ( se ) book
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510210848030.3903@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e7aeb7c60510210422s33c0240ex4eab1d90d94111fe@mail.gmail.com>
	 <Pine.LNX.4.58.0510210848030.3903@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First Steve I want to thanks you for answering me
your answered all the questions that i had
I can understand your complains , and i will try to make it better
next time ( i almost never used mailing lists... , so sorry about the
white space striping , and the spelling... )

Jesper - yes it was a typo

Nick - thanks :)

On 10/21/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Oh God, please indent code examples, and if your email client strips white
> space, change your email client.
>
> On Fri, 21 Oct 2005, Yitzchak Eidus wrote:
>
> > first i am very sorry if it isnt the place to ask questions like this
> > but i didnt know where else to ask ( i tryed irc channels and i was
> > send from there to this list )
> > anyway:
> > does this following code look buggy? :
>
> [ Indention added ]
>
> > DECLARE_WAITQUEUE ( wait , current );
> > add_wait_queue ( q , &wait );
> > while ( !condition ) {
> >         set_current_stat ( TASK_INTERRUPTABLE ); i
> >         if ( signal_pending ( current ) )
> >                 /* handle signal */
>
> I assume that the signal_pending is the if result and not the schedule.
> Since there was no indentation I couldn't tell.
>
> >         schedule ( );
> /* Moved brace down added */
>  }
> > set_current_state ( TASK_RUNNING );
> > remove_wait_queue ( q , &wait );
>
> Before I go to your questions, I'll first answer that this _is_ buggy
> code.  If the condition is checked and you are woken up between the
> while (!condition) and the set_current_state, then you will end up
> sleeping forever or until someone sends you a signal.
>
> > first:doesnt in the way from checking the !condition to
> > set_current_state  the condition can be changed no?
>
> Yes, and then put it again after schedule.
>
> >
> > second:why not putting the schedule ( ); right after the
> > set_current_state ( ) , what the point in checking the if (
> > signal_pending ( ) first, if the proccess doesnt started to sleep yet?
>
> Yes, I would put the signal_pending check after the schedule (as most of
> the kernel does this).
>
> > third: in the cleaning in the way from putting the set_current_state (
> > TASK_RUNNING ) into remove_wait_queue , cant the queue wait list ( q )
> > wake up again the wait procsess?
>
> Yeah, so?  There's no harm in that, except for an extra cpu cycles that
> are done to wake it up.  That, I wouldn't change.
>
> > ( thnks for the help , please if it can be done answer quickly i am
> > tanker in the idf and need to come back to the army soon , ( no
> > internet there... ) )
>
> BTW, this is not an IRC, we use normal capitalization and normal spelling
> (when we know how to spell a word ;-).  So the next time you send to the
> list, send it as if you were writing a serious letter, or you may just be
> ignored. (as you might have been if I didn't respond).
>
> -- Steve
>
