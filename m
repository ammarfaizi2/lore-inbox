Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbSJDIYz>; Fri, 4 Oct 2002 04:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261528AbSJDIYz>; Fri, 4 Oct 2002 04:24:55 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:660 "EHLO
	myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S261527AbSJDIYx>; Fri, 4 Oct 2002 04:24:53 -0400
Message-ID: <3D9D51A3.3050906@redhat.com>
Date: Fri, 04 Oct 2002 01:30:27 -0700
From: Ulrich Drepper <drepper@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020812
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] nptl 0.2
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Now that the Linux kernel is once again able to run all the tests we
have and since glibc 2.3 was released it was time for a new code drop.
I've uploaded the second code drop for the Native POSIX Thread
Library:

  ftp://people.redhat.com/drepper/nptl/nptl-0.2.tar.bz2

You need

- - the latest of Linus' kernel from BitKeeper (or 2.5.41 when it
  is released);

- - glibc 2.3

- - the very latest in tools such as

  + gcc either from the current development branch or the gcc 3.2
    from Red Hat Linux 8;

  + binutils preferrably from CVS, from H.J. Lu's latest release for
    Linux, or from RHL 8.


Compiling glibc should proceed smoothly.  But there are a number of
tests which fail, mostly because some functionality is missing in
glibc.  Ignore those errors.  It is only important that all tests in
nptl/ are passing.  Run

  make subdirs=nptl check

to run all thread tests.


This version features several improvements:

- - all APIs are now implemented;

- - fork handling has been improved; stacks in the child are freed;
  atfork handlers are removed if they were registered from a module
  which gets unloaded.

- - pthread_tryjoin_np and pthread_timedjoin_np are implemented

- - TSD handling corrected and optimized.

- - many more tests which also test the underlying kernel implementation.

- - the build infrastructure has been implemented so that the DSO and
  archives are built in usable form and with correct named.

- - libthread_db has been implemented.  This is the library which is
  needed by all program which need to get access to internals of
  libpthread (mainly debuggers).

- - the CPU clock functions are implemented



The white paper hasn't yet been updated.  It's still available at

  http://people.redhat.com/drepper/nptl-design.pdf


This release should be ready for some serious testing.  I know it is
hard to compile which I why I'm looking into providing binary RPMs.
They can be used on non-critical systems.  I'll only be able to
provide binaries for RHL8 based systems, though, and the kernel still
must be installed separately.


The next steps will include:

- - write more tests and fix the bugs which are discovered this way

- - update the white paper

- - write and run more performance tests

- - port to IA-64


Interested parties are once again invited to join the mailing we
created:


  phil-list@redhat.com

Go to

  https://listman.redhat.com/mailman/listinfo/phil-list

to subscribe, unsubscribe, or review the archive.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE9nVGj2ijCOnn/RHQRAqhJAJ45TBsM9wbUgiexxQzumVeIhxVhjQCfcf2N
yUt+9E2F9gsz9xcBiVau9SY=
=AKML
-----END PGP SIGNATURE-----

