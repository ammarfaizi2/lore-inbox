Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUKIOzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUKIOzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 09:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUKIOzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 09:55:24 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:15234 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261548AbUKIOzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 09:55:15 -0500
Date: Tue, 09 Nov 2004 09:54:56 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: problem with printk on SMP-- somebody please help
In-reply-to: <BAY10-F26KktkpgnkTl0003031e@hotmail.com>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <4190DA40.9030407@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <BAY10-F26KktkpgnkTl0003031e@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arun Srinivas wrote:
> hi
> 
> I really appreciate your suggestions and as a newcomer eager to learn
> more from you people.
> 
> As I said I was able to do printk anywhere in the sched.c (including
> _activate_task ) on a non-smp kernel and on a smp-kernel I can do it
> only on the main schedule() function.
> Also, I would like to add that I am not able to do the macro rdtsc() for
> reading the timestamp counter in the same function.When I compile the
> kernel it dosent show any error, but just the printk's and rdtsc()'s get
> subdued!
> 
> Well,  with reference to your reply, I have some basic questions:
> 1) on a non-smp kernel will the _activate_task not lock the given runqueue?

The locking is done in schedule().  Read include/linux/spinlock.h to see
how spinlocks differ in the SMP vs non-SMP case.  In the latter case
with spinlock debugging enabled, there is no lock bit and recursively
grabbing a lock is possible (though still not allowed!).

> 2) where is the best place I can do the rdtsc() and printk to read the
> value as to when a task is being scheduled for execution, on a SMP kernel?
> 

No idea wrt to rdtsc.

HTH,

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBkNpAdQs4kOxk3/MRAkCCAJ9IoN7VfyymTBuYn7R8//dbxLGwkACfUTQu
l1BiHVTfZf6IvIT2+nqsiPE=
=loXh
-----END PGP SIGNATURE-----
