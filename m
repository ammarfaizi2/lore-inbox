Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130113AbQJaE5l>; Mon, 30 Oct 2000 23:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130132AbQJaE5c>; Mon, 30 Oct 2000 23:57:32 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:49404 "HELO
	halfway.linuxcare.com.au") by vger.kernel.org with SMTP
	id <S130113AbQJaE5Y>; Mon, 30 Oct 2000 23:57:24 -0500
From: Rusty Russell <rusty@linuxcare.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: test10-pre7 
In-Reply-To: Your message of "Tue, 31 Oct 2000 12:49:12 +1100."
             <13675.972956952@ocs3.ocs-net> 
Date: Tue, 31 Oct 2000 15:57:11 +1100
Message-Id: <20001031045711.3886A81FA@halfway.linuxcare.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <13675.972956952@ocs3.ocs-net> you write:
> On Mon, 30 Oct 2000 16:47:15 -0800 (PST), 
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >Actually, I think I have an even simpler solution, which is to change the
> >newstyle rule to something very simple:
> >
> >	# Translate to Rules.make lists.
> >
> >	O_OBJS          := $(obj-y)
> >	M_OBJS          := $(obj-m)
> >	MIX_OBJS        := $(export-objs)
> 
> make modules depends on MIX_OBJS, with the above change make modules
> now depends on kernel objects.  Can be fixed in Rules.make, but only if
> every Makefile is changed (code freeze, what code freeze?).

Quiet suggestion:

Maybe better is to get rid of the X version variables?  Append -EXPORTS
to everything that exports, and generate the genksyms food from:

	$(patsubst %.o-EXPORTS,%.c, $(filter %-EXPORTS, $(OBJS))

And the link line from:

	$(patsubst %-EXPORTS, %, $(OBJS))

This allows complete control over the link order.
Rusty.
--
Hacking time.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
