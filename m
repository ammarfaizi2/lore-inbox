Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbUKHTss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbUKHTss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUKHTsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:48:47 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:58259 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S261200AbUKHTs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:48:29 -0500
Date: Mon, 08 Nov 2004 14:47:59 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: problem with printk--  somebody please help
In-reply-to: <BAY10-F469WbbjykeNX00014ef5@hotmail.com>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <418FCD6F.30100@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <BAY10-F469WbbjykeNX00014ef5@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Arun Srinivas wrote:
> hi
> 
> I am new to the kernel world and would be very glad if somebody could
> help me with this problem.
> 
> I am unable to do printk or even a macro call like rdtsc()...(for
> reading the time stamp counter) from within the "activate_task"
> function on a kernel with smp support.But these work under the main
> schedule() function.
> 
> I was able to do all these i.e., inside "activate_task" on a kernel
> without smp support.Can anybody suggest a solution as to what could be
> the problem??
> 
> somebody please help.

I seem to recall that doing so would deadlock your machine.
activate_task is called with the given cpu's runqueue locked.  printk
eventually calls release_console_sem, which will wake_up_interruptible,
which will eventually call try_to_wake_up which grabs the same lock.

I don't think I've ever seen printk work while task_rq_lock'ed.

Someone correct me if I'm wrong, this is the best I was able to figure
out before giving up.

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

iD8DBQFBj81vdQs4kOxk3/MRAlJGAKCIYIgXCkaSXpwGLdsj/WK1BhPOlwCeK6s0
1pc0XbERKlQKpLIBpObhwZA=
=2DSX
-----END PGP SIGNATURE-----
