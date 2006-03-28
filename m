Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWC1Vik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWC1Vik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWC1Vik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:38:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932230AbWC1Vij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:38:39 -0500
Message-ID: <4429ACBE.2060502@redhat.com>
Date: Tue, 28 Mar 2006 15:38:06 -0600
From: Clark Williams <williams@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: boot hang in 2.6.16-rt[7-10]
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm seeing a boot hang in the latest -rt series (from -rt7 to current
- -rt10), on an Athlon64x2 (3800+). The kernel loads and boots up to
calibrate_migration_costs then hangs. I'd give some console output,
except that in their infinite wisdom, Gateway decided that this system
didn't need a serial port. Gah...

I've prink'ed my way down into where measure_one tries to migrate a
thread from cpu0 to cpu1 and calls set_cpus_allowed, where it then
tries to wake the migration thread by calling wake_up_process, which
just calls try_to_wake_up. Strangely, I see multiple printks from
try_to_wake_up (like it's running multiple times) and the last print I
see is that I'm returning a 1 from wake_up_process. Nothing after that.

I'd really like to see the boot messages before all those printk's
I've scattered in sched.c, so I'm investigating using the parallel
port as a console and just spewing that output into an xterm on the
other end. Never done it before so I'm bumping my head against the
wall a bit. Any advice would be appreciated.

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEKay+Hyuj/+TTEp0RAi8YAJ92U1KHM0BW5nWZWl7lCBBQAZWCQQCg1FWy
8dGHlzkPQBn22Y1pK6lOen8=
=Hr9n
-----END PGP SIGNATURE-----

