Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbUKIS7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbUKIS7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUKIS7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:59:41 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:45153 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261620AbUKIS7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:59:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DfEMN3daohTqY9DF0+Yt49hapvUsa2BMOVT4/2IUXQvKZg2fym+/swkXnNWn+7nGxc2AWKGtAP84XpBZPxFsepvXmGE2TjePzizbi9wsvR9qjRk70E916R4yUlT1xLQ11pwbZIPwbJUzGEfnkbNxDPXbg9eZpqolZgkDG+iWc9M=
Message-ID: <e751f47b04110910592c1c9184@mail.gmail.com>
Date: Tue, 9 Nov 2004 12:59:28 -0600
From: arun srinivasan <getarunsri@gmail.com>
Reply-To: arun srinivasan <getarunsri@gmail.com>
To: Mike Waychison <michael.waychison@sun.com>
Subject: Re: problem with printk on SMP-- somebody please help
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4190DA40.9030407@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <BAY10-F26KktkpgnkTl0003031e@hotmail.com>
	 <4190DA40.9030407@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can I do a sched_clock() inside activate_task to record the time at
which a task is ready for execution and then can read it by a prink in
schedule()??
I think sched_clock() calls rdtsc() and converts it to nanosecond scale.
or is there any other better way of reading the time at which a task
is being executed?
 


On Tue, 09 Nov 2004 09:54:56 -0500, Mike Waychison
<michael.waychison@sun.com> wrote:
> 
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Arun Srinivas wrote:
> > hi
> >
> > I really appreciate your suggestions and as a newcomer eager to learn
> > more from you people.
> >
> > As I said I was able to do printk anywhere in the sched.c (including
> > _activate_task ) on a non-smp kernel and on a smp-kernel I can do it
> > only on the main schedule() function.
> > Also, I would like to add that I am not able to do the macro rdtsc() for
> > reading the timestamp counter in the same function.When I compile the
> > kernel it dosent show any error, but just the printk's and rdtsc()'s get
> > subdued!
> >
> > Well,  with reference to your reply, I have some basic questions:
> > 1) on a non-smp kernel will the _activate_task not lock the given runqueue?
> 
> The locking is done in schedule().  Read include/linux/spinlock.h to see
> how spinlocks differ in the SMP vs non-SMP case.  In the latter case
> with spinlock debugging enabled, there is no lock bit and recursively
> grabbing a lock is possible (though still not allowed!).
> 
> > 2) where is the best place I can do the rdtsc() and printk to read the
> > value as to when a task is being scheduled for execution, on a SMP kernel?
> >
> 
> No idea wrt to rdtsc.
> 
> HTH,
> 
> 
> 
> - --
> Mike Waychison
> Sun Microsystems, Inc.
> 1 (650) 352-5299 voice
> 1 (416) 202-8336 voice
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NOTICE:  The opinions expressed in this email are held by me,
> and may not represent the views of Sun Microsystems, Inc.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.5 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFBkNpAdQs4kOxk3/MRAkCCAJ9IoN7VfyymTBuYn7R8//dbxLGwkACfUTQu
> l1BiHVTfZf6IvIT2+nqsiPE=
> =loXh
> -----END PGP SIGNATURE-----
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
