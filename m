Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTETBfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 21:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTETBfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 21:35:38 -0400
Received: from dp.samba.org ([66.70.73.150]:40601 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263451AbTETBfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 21:35:37 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Mon, 19 May 2003 17:40:54 MST."
             <3EC97996.1080800@redhat.com> 
Date: Tue, 20 May 2003 11:46:45 +1000
Message-Id: <20030520014836.C7BDE2C069@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3EC97996.1080800@redhat.com> you write:
> Rusty Russell wrote:
> 
> > 1) Overload the last futex arg (change from timeval * to void *),
> >    don't add YA arg at the end.
> 
> It wasn't Ingo's idea.  I suggested it.  Overloading parameter types is
> evil.  This isn't an issue anymore if the extension is implemented as a
> new syscall which certainly is better.

People are using the interface, so I don't think changing it because
"it's nicer this way" is worthwhile: Ingo's "new syscall" patch has
backwards compat code for the old syscalls.  That's fugly 8(

So I'd say if we're going to multiplex, then overloading is easiest,
and in fact already done for FUTEX_FD.

But it's an issue over which sane people can disagree, IMHO.

> > 2) Use __alignof__(u32) not sizeof(u32).  Sure, they're the same, but
> >    you really mean __alignof__ here.
> 
> I would always use sizeof() in this situation.

Comment says: /* Must be "naturally" aligned */.  This used to be true
in a much earlier version of the code, now AFAICT the requirement test
should be:

	/* Handling futexes on multiple pages?  -ETOOHARD */
	if (pos_in_page + sizeof(u32) > PAGE_SIZE)
		return -EINVAL;

Ingo?

Thanks for the comments!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
