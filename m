Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbUKITy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbUKITy3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKITyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:54:10 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:13304 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S261649AbUKITwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:52:09 -0500
Date: Tue, 09 Nov 2004 14:51:48 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: More linux-2.6.9 module problems
In-reply-to: <Pine.LNX.4.61.0411081148520.5510@chaos.analogic.com>
To: linux-os@analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Message-id: <41911FD4.2060902@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.61.0411081148520.5510@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

linux-os wrote:
> 
> I have a memory-test procedure that tests
> memory on a board, accessed via the PCI bus.
> There is a lot of RAM and it's bank-switched
> into some 64k windows so it takes a lot of
> time to test, about 60 seconds.
> 
> This is in a module, therefore inside the kernel.
> When it is invoked via an ioctl() call, the
> kernel is frozen for the whole test-time. The
> test procedure does not use any spin-locks nor
> does it even use any semaphores. It just does a
> bunch of read/write operations over the PCI/Bus.
> 
> I thought that I could enable the preemptible-
> kernel option and the machine would then respond
> normally. Not so. Even with 4 CPUs, when one
> ioctl() is busy in the kernel, nothing else
> happens until its done. Even keyboard activity
> is gone, no Caps Lock and no Num Lock, no `ping`
> response over the network. However, the machine
> comes back to life when the memory-test is done.
> 
> This is kernel version 2.6.9. Is it possible that
> somebody left on the BKL when calling a module
> ioctl() on this version? If not, what do I do
> to be able to execute a time-consuming procedure
> from inside the kernel? Do I break it up into
> sections and execute schedule() periodically
> (temporary work-around --works)??
> 

The BKL has always been grabbed across ioctls.  Drop the lock when you
enter your f_op->ioctl call and grab it again open completion.

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

iD8DBQFBkR/UdQs4kOxk3/MRAqYmAJwM4wQFhGis831m50lzqOKnCY0BEgCeOtXY
4TmvEX9mmXfsT2L9EinlwiM=
=fiO5
-----END PGP SIGNATURE-----
