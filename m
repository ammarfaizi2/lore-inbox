Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262625AbUE1McT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUE1McT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 08:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUE1M3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 08:29:46 -0400
Received: from nef.ens.fr ([129.199.96.32]:29701 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S262605AbUE1M24 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 08:28:56 -0400
Date: Fri, 28 May 2004 14:28:54 +0200
From: David Madore <david.madore@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: filesystem corruption (ReiserFS, 2.6.6): regions replaced by \000 bytes
Message-ID: <20040528122854.GA23491@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.3.3 (nef.ens.fr [129.199.96.32]); Fri, 28 May 2004 14:28:56 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.

I'm afraid this bug-report will be rather worthless as it is, because
the bug has proven remarkable elusive and has defeated all my attempts
to track it down to a precise test case or set of circumstances.  But
since it seems important, I thought it might be worth a post anyway.
Any help is appreciated in clarifying the circumstances which trigger
the problem, or generally in making this report more useful.

The bottom line: I've experienced file corruption, of the following
nature: consecutive regions (all, it seems, aligned on 256-byte
boundaries, and typically around 1kb or 2kb in length) of seemingly
random files are replaced by null bytes.  The filesystem is ReiserFS
(but as nearly all my filesystems are ReiserFS anyway, I cannot
conclusively say that the bug is indeed in ReiserFS).  The problem has
occurred with kernel versions Debian-packaged 2.6.6-1-686-smp and
home-compiled 2.6.6-mm2 (SMP also).  The hardware is an Intel
bi-PII450 (with 256MB RAM) using aic7xxx as low-level disk driver; and
I have good reasons to think that the hardware is sound (and the
memory banks in particular).  Distribution is Debian Sarge (with a few
unstable packages as well).  System load is moderate.  The affected
files were typically corrupted during operation of Debian "apt-get":
either while updating the apt-cache (which became corrupted) or while
extracting packages (which randomly corrupted newly extracted files).

That's about all I can say for sure.  I have tried to reproduce the
problem by stress-testing the filesystem (creating large numbers of
small files, or small numbers of large files, containing ARC4 streams
produced by <URL: ftp://quatramaran.ens.fr/pub/madore/misc/arc4gen.c >
and checking them afterward against the same procedural generator) --
but to no avail: even by trying heavily concurrent access I have not
been able to reproduce a single occurrence of the bug).  Maybe apt-get
has a specific way of writing files (but I can't really think how;
might it use mmap() in some way? that doesn't sound plausible) which
makes it trigger the bug.

I also have a UP box (Intel PIII600 with 384MB RAM and IDE disks)
which, even though it has a nearly identical setup and is used in a
roughly equal way, has not experienced any kind of corruption; so
maybe the bug is SMP-specific (which would explain it going more or
less unnoticed) -- on the other hand, a friend of mine has mentioned
having observed similar problems on a UP box with 2.6.5 installed
under very heavy load on ReiserFS, but I can't say more here.  I'm
really sorry that all this is very fuzzy.

Any suggestions (either on how to fix the problem or to work around
it, or on how to reproduce it experimentally) are welcome.  A friendly
pat on the back would also be welcome. :-)

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
