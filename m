Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267762AbTBVAzl>; Fri, 21 Feb 2003 19:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267765AbTBVAzl>; Fri, 21 Feb 2003 19:55:41 -0500
Received: from burn.victim.com ([66.92.179.156]:17168 "EHLO burn.victim.com")
	by vger.kernel.org with ESMTP id <S267762AbTBVAzk>;
	Fri, 21 Feb 2003 19:55:40 -0500
Date: Fri, 21 Feb 2003 17:05:40 -0800 (PST)
From: Dave Pifke <dave@pifke.org>
X-X-Sender: dave@burn.victim.com
To: linux-kernel@vger.kernel.org
Subject: CLONE_THREAD with old (glibc 2.2.5) linuxthreads
Message-ID: <Pine.LNX.4.50.0302211649300.19257-100000@burn.victim.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

I'm attempting to add ps-like code to an application, and am running into
a problem calculating the memory usage of multithreaded processes.  The
memory usage numbers in /proc/PID/statm don't give any indication as to
whether or not the process shares its VM with another, thus a
multithreaded application appears to be using (actual usage * number of
threads).

It looks like this could be easilly solved by looking at Tgid in
/proc/PID/status and calculating memory usage per-thread-group instead of
per-process.  The problem, however, is that glibc 2.2.5 does not set
CLONE_THREAD and so Tgid == Pid in every case.

Would it break anything if I patch my glibc to set this flag?  Is
task_struct->tgid just informational in 2.4, or does it modify the
behavior of the task somehow?

Or, is there perhaps another way to see if CLONE_VM was set when the
process was cloned?  (Thus avoiding the need to change anything in glibc.)

Upgrading to 2.5 and using NGPT is not an option at this point.

Other suggestions?


- --
Dave Pifke, dave@pifke.org

-----BEGIN PGP SIGNATURE-----
Version: 2.6.2

iQCVAwUBPlbM5juW2fOIQC3pAQFl8wQAgTTIFIXjIS3VTV7sRqYQe5EcV2AOeM9K
tcGtUcxaoks08vhTyK/x7kKqauM+ZE5KCRQTYy0Z2vZXNTcuVWB47a/vGK0eKk9P
r9WCeI4k0hTMVmfK09guZeMW9TJeP26SWyhNU2jQR+j8rv6ohFAmujvzZtlEA8Oz
L71LeorLqr0=
=r4z2
-----END PGP SIGNATURE-----
