Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTEIHXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 03:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbTEIHXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 03:23:09 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:18321
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262324AbTEIHXH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 03:23:07 -0400
Message-ID: <3EBB5A44.7070704@redhat.com>
Date: Fri, 09 May 2003 00:35:32 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030506
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>
Subject: hammer: MAP_32BIT
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

To allocate stacks for the threads in nptl we currently use MAP_32BIT to
make sure we get <4GB addresses for faster context switching time.  But
once the address space is allocated we have to resort to not using the
flag.  This means we have to make 2 mmap() calls, one with MAP_32BIT and
if it fails another one without.

It would be much better if there would also be a MAP_32PREFER flag with
the appropriate semantics.  The failing mmap() calls seems to be quite
expensive so programs with many threads are really punished a lot.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+u1pF2ijCOnn/RHQRAk2IAKDAzXZUOsxMPAKkK9ivOz8o6zAaHQCeMC24
ysih3QB/I1w5MNXEIxNs284=
=2cet
-----END PGP SIGNATURE-----

