Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTKDXtQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 18:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTKDXtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 18:49:16 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:24268
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262099AbTKDXtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 18:49:14 -0500
Message-ID: <3FA83ACC.5060700@redhat.com>
Date: Tue, 04 Nov 2003 15:48:28 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
References: <Pine.LNX.4.44.0311041422580.20373-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0311041422580.20373-100000@home.osdl.org>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:

> Is the TLS stuff done through an extra dynamically loaded indirection or
> something?

This has nothing to do with TLS.  The code currently used got to use the
general libpthread locking code.  This was, I think, the result of one
of the last changes in the locking code where the libc side wasn't
updated correctly.  I've done this and this is what I see:

drepper@ht 20031104-2$ time ./u > /dev/null
real    0m1.272s
user    0m1.270s
sys     0m0.000s

drepper@ht 20031104-2$ time LD_ASSUME_KERNEL=2.4.1 ./u > /dev/null
real    0m0.316s
user    0m0.320s
sys     0m0.000s

drepper@ht 20031104-2$ time LD_LIBRARY_PATH=. ./u > /dev/null
real    0m0.207s
user    0m0.210s
sys     0m0.000s



The first is the old nptl code, the second LinuxThreads, the third the
current nptl code.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/qDrM2ijCOnn/RHQRAnAyAJ48OxeRGWefxHMVImZMiuZ2YaueOwCgk+8A
9k3SC5sMLghNmlMmzKwWv/E=
=UT6g
-----END PGP SIGNATURE-----

