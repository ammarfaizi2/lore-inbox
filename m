Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbUKIC1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbUKIC1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbUKIC1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:27:19 -0500
Received: from bay10-f26.bay10.hotmail.com ([64.4.37.26]:38831 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261351AbUKIC0O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:26:14 -0500
X-Originating-IP: [146.229.160.228]
X-Originating-Email: [getarunsri@hotmail.com]
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: Michael.Waychison@Sun.COM
Subject: Re: problem with printk on SMP-- somebody please help
Date: Tue, 09 Nov 2004 07:55:40 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY10-F26KktkpgnkTl0003031e@hotmail.com>
X-OriginalArrivalTime: 09 Nov 2004 02:26:09.0349 (UTC) FILETIME=[792E3750:01C4C603]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I really appreciate your suggestions and as a newcomer eager to learn more 
from you people.

As I said I was able to do printk anywhere in the sched.c (including 
_activate_task ) on a non-smp kernel and on a smp-kernel I can do it only on 
the main schedule() function.
Also, I would like to add that I am not able to do the macro rdtsc() for 
reading the timestamp counter in the same function.When I compile the kernel 
it dosent show any error, but just the printk's and rdtsc()'s get subdued!

Well,  with reference to your reply, I have some basic questions:
1) on a non-smp kernel will the _activate_task not lock the given runqueue?
2) where is the best place I can do the rdtsc() and printk to read the value 
as to when a task is being scheduled for execution, on a SMP kernel?

Please help.

Thanks
Arun

>From: Mike Waychison <Michael.Waychison@Sun.COM>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: linux-kernel@vger.kernel.org
>Subject: Re: problem with printk--  somebody please help
>Date: Mon, 08 Nov 2004 14:47:59 -0500
>
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>Arun Srinivas wrote:
> > hi
> >
> > I am new to the kernel world and would be very glad if somebody could
> > help me with this problem.
> >
> > I am unable to do printk or even a macro call like rdtsc()...(for
> > reading the time stamp counter) from within the "activate_task"
> > function on a kernel with smp support.But these work under the main
> > schedule() function.
> >
> > I was able to do all these i.e., inside "activate_task" on a kernel
> > without smp support.Can anybody suggest a solution as to what could be
> > the problem??
> >
> > somebody please help.
>
>I seem to recall that doing so would deadlock your machine.
>activate_task is called with the given cpu's runqueue locked.  printk
>eventually calls release_console_sem, which will wake_up_interruptible,
>which will eventually call try_to_wake_up which grabs the same lock.
>
>I don't think I've ever seen printk work while task_rq_lock'ed.
>
>Someone correct me if I'm wrong, this is the best I was able to figure
>out before giving up.
>
>- --
>Mike Waychison
>Sun Microsystems, Inc.
>1 (650) 352-5299 voice
>1 (416) 202-8336 voice
>
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>NOTICE:  The opinions expressed in this email are held by me,
>and may not represent the views of Sun Microsystems, Inc.
>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>-----BEGIN PGP SIGNATURE-----
>Version: GnuPG v1.2.5 (GNU/Linux)
>Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
>
>iD8DBQFBj81vdQs4kOxk3/MRAlJGAKCIYIgXCkaSXpwGLdsj/WK1BhPOlwCeK6s0
>1pc0XbERKlQKpLIBpObhwZA=
>=2DSX
>-----END PGP SIGNATURE-----

_________________________________________________________________
Mergers, takeovers, buyouts. Get all the latest biz bytes. 
http://www.msn.co.in/business/ Tune in to MSN Business!

