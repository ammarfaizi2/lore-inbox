Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130230AbRBSN0u>; Mon, 19 Feb 2001 08:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130254AbRBSN0k>; Mon, 19 Feb 2001 08:26:40 -0500
Received: from ns.caldera.de ([212.34.180.1]:34058 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130230AbRBSN0e>;
	Mon, 19 Feb 2001 08:26:34 -0500
Date: Mon, 19 Feb 2001 14:25:39 +0100
Message-Id: <200102191325.OAA12026@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: kaos@ocs.com.au (Keith Owens)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Philipp Rumpf <prumpf@mandrakesoft.com>
Subject: Re: Linux 2.4.1-ac15
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <30512.982588558@ocs3.ocs-net>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <30512.982588558@ocs3.ocs-net> you wrote:
> No need for a callin routine, you can get this for free as part of
> normal scheduling.  The sequence goes :-
>
> if (use_count == 0) {
>   module_unregister();
>   wait_for_at_least_one_schedule_on_every_cpu();
>   if (use_count != 0) {
>     module_register();	/* lost the unregister race */
>   }
>   else {
>     /* nobody can enter the module now */
>     module_release_resources();
>     unlink_module_from_list();
>     wait_for_at_least_one_schedule_on_every_cpu();
>     free_module_storage();
>   }
> }
>
> wait_for_at_least_one_schedule_on_every_cpu() prevents the next
> operation until at least one schedule has been executed on every cpu.
> Whether this is done as a call back or a separate kernel thread that
> schedules itself on every cpu or the current process scheduling itself
> on every cpu is an implementation detail.  All that matters is that any
> other cpu that might have been accessing the module has gone through
> schedule and therefore is no longer accessing the module's data or
> code.

You just reinvented the read-copy-update model
(http://www.rdrop.com/users/paulmck/rclock/intro/rclock_intro.html)...

The mail proposing that locking model for module unloading is not yet
in the arvhices, sorry.

	Christoph

P.S. Weren't you Cc:'ed on that mail?
-- 
Of course it doesn't work. We've performed a software upgrade.
