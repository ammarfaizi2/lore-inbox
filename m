Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbUCVXSP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 18:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUCVXSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 18:18:15 -0500
Received: from gprs214-233.eurotel.cz ([160.218.214.233]:9856 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261491AbUCVXSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 18:18:05 -0500
Date: Tue, 23 Mar 2004 00:17:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040322231737.GA9125@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040318193703.4c02f7f5.akpm@osdl.org> <1079661410.15557.38.camel@calvin.wpcb.org.au> <20040318200513.287ebcf0.akpm@osdl.org> <1079664318.15559.41.camel@calvin.wpcb.org.au> <20040321220050.GA14433@elf.ucw.cz> <1079988938.2779.18.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079988938.2779.18.camel@calvin.wpcb.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Now I have _proof_ that eye-candy is harmfull. What is see on screen is:
> 
> No, that's not proof; just a bug in the code. It's not using the right
> code to display the error message. I'll fix it asap.

:-)

I'd really like eye-candy code to be gone. Its long, and its not worth
the trouble.

> >                                                               N
> > umber of free pages a[                              ]h! (285723 != 285754)
> >  (Press SPACE to continue)
> 
> By thw way, to get this message, you probably removed the memory pool
> hooks. I'm getting the picture more and more clearly. I need to write a
> series of emails explaining why each part of the changes exists. I'll
> try to do that shortly.

No, this was actually with unmodified swsusp2. [I'm not sure if
highmem was enabled at that point. I do not think it was.]

> > Was it really neccessary to rename IOTHREAD to NOFREEZE? This way you
> 
> Not really, but I felt that IOTHREAD wasn't a good description of the
> way the flag is used. The name implies that it is intended for threads
> used for doing I/O, but it is also used for some threads that aren't I/O
> related but cannot/should not be refrigerated.

I agree that NOFREEZE is better name. Try submitting separate patch to
rename it; if it gets rejected, modify swsusp2 to use IOTHREAD name...

> >         if (likely(!(current->state & (TASK_DEAD | TASK_ZOMBIE)))) {
> >                 if (unlikely(in_atomic())) {
> > -                       printk(KERN_ERR "bad: scheduling while
> > atomic!\n");
> > -                       dump_stack();
> > +                       if (likely(!(software_suspend_state &
> > SOFTWARE_SUSPEND_RUNNING))) {
> > +                               printk(KERN_ERR "bad: scheduling while
> > atomic!\n");
> > +                               dump_stack();
> > +                       }
> >                 }
> >         }
> > 
> > Were you lazy or is there some reason why scheduling while atomic is
> > not bad for swsusp2?
> 
> I like the way you're forcing me to remember why I've done things the
> way I have :>. I'll need to get look at this again and get back to you.
> There is a good reason and I did try to avoid doing this. I just don't
> remember the logic right now.

Not enough comments, then :-). [I wish I had followed swsusp2
development more closely, but I guess its too late for that by now.]

> Thanks for the comments. I really appreciate them.

I'm looking forward to better swsusp2.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
