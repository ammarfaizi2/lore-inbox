Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWAWK4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWAWK4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWAWK4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:56:40 -0500
Received: from mail.gmx.net ([213.165.64.21]:6791 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750755AbWAWK4j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:56:39 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 11:56:34 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060123105634.GA17439@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

debugging an application problem that used to mlockall(...FUTURE) and
failed with a subsequent mmap(), I came across the manual page for
setrlimit (see below for the relevant excerpt). I have several questions
concerning the rationale:

1. What is the reason we're having special treatment
   for the super-user here?

2. Why is it the opposite of what 2.6.8.1 and earlier did?

3. Why is this inconsistent with all other RLIMIT_*?
   Neither of which cares if a process is privileged or not.

4. Is the default hard limit of 32 kB initialized by the kernel or
   by some script in SUSE 10.0? If it's the kernel: why is the limit so
   low, and why isn't just the soft limit set?

   "[...]
    RLIMIT_MEMLOCK
      The maximum number of bytes of memory that may  be  locked  into
      RAM.  In effect this limit is rounded down to the nearest multi-
      ple of the system page size.  This limit  affects  mlock(2)  and
      mlockall(2)  and  the mmap(2) MAP_LOCKED operation.  Since Linux
      2.6.9 it also affects the shmctl(2) SHM_LOCK operation, where it
      sets a maximum on the total bytes in shared memory segments (see
      shmget(2)) that may be locked by the real user ID of the calling
      process.   The  shmctl(2) SHM_LOCK locks are accounted for sepa-
      rately  from  the  per-process  memory  locks   established   by
      mlock(2),  mlockall(2),  and  mmap(2)  MAP_LOCKED; a process can
      lock bytes up to this limit in each of these two categories.  In
      Linux  kernels before 2.6.9, this limit controlled the amount of
      memory that could be locked  by  a  privileged  process.   Since
      Linux 2.6.9, no limits are placed on the amount of memory that a
      privileged process may lock, and this limit instead governs  the
      amount of memory that an unprivileged process may lock. [...]"
   (getrlimit(2), man-pages-2.07)

-- 
Matthias Andree
