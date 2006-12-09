Return-Path: <linux-kernel-owner+w=401wt.eu-S1761847AbWLITev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761847AbWLITev (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 14:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761851AbWLITev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 14:34:51 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:60995 "EHLO
	rwcrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761847AbWLITeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 14:34:50 -0500
Message-ID: <457B0FD7.2030804@comcast.net>
Date: Sat, 09 Dec 2006 14:34:47 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: noexec=on doesn't work
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm running on an Athlon 64 in 32-bit mode, running 32-bit Ubuntu with
kernel 2.6.19 (Ubuntu version 2.6.19-7-generic for the curious;
compiled for 586).  Apparently, 'noexec=on' on the kernel command line
does nothing; the NX bit seems to not work.

Chunk of my /proc/cpuinfo:

flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm
3dnowext 3dnow up ts fid vid ttp

Attached to the relevant Ubuntu bug is a test program that attempts to
disable PROT_EXEC for a page of memory containing (I believe) the entry
point of a function.  It's compiled as such:


$ gcc -O2 -shared -fpic test_so.c -o test_so.so
$ gcc -O2 test.c -o test -ldl


Running it on AMD64-ubuntu gives the following output:

$ ./test
Test function run successfully!
Segmentation fault

This is good; I tried to execute non-executable memory, it segfaulted.
However, 32-bit Ubuntu on the Athlon64 gives the following:

$ ./test
Test function run successfully!
Test function run successfully!

Apparently noexec is not being honored.

I have filed this as a distro bug with Ubuntu; it may be their issue, I
haven't dug deep enough to find out.  I am posting this here to disperse
the information breadth-first instead of depth-first, which will shorten
the bug's life cycle if it turns out to be an upstream bug.

This also appears to happen on 2.6.15.

Ubuntu bug:
https://bugs.launchpad.net/distros/ubuntu/+source/linux-source-2.6.19/+bug/75157


- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRXsP1gs1xW0HCTEFAQLAsQ//XUdfVAK6Fp225mUXv+ApLUqnZFyfca4z
n0e1WFVYGQcplKQpdn+MGxzoEXc4xo4GnC2n0qfbyp6l7GN9uLvZS3myLOB6nfMH
AFUeDmpc44Q40Nq94UKxrMmMvyfs0lEOBIRjQzvzWonYjNXFQuIAWS8xsFducjaF
IK7E79cvC9d/mlSOQMgcFSt8hW35MqAI0/Au3iViReE+Qm/qUw2PWw9lUpRTgVZf
SrKqQq8HNM5SCJDFyu/zVltEwAPqTvn6g0p9BlCMZhugiBIaoaeAvO8ZYhxr+0JG
DxIEoaA4Ij/AnL7u2LT1lz/oDKhH4RImko+z2NubmFNiBJiODmX6RLsciWy3mgtx
ulYuESmIRjb1hOwTlFqvpOMNncCyCGjZwCw8/O7SxosDFx4Gvd9IqPFJ6dKoj2fp
oXESE5uIWbJGtbPyB2jsaz5t3PZ9DGrzX/P9ykPLhGmwiM23Nrc36DW/BH9/+ESZ
Uv1SbIgIWV8tz2cO+YJgbrrSD+wuvizkzv4Va31tyPyPx3QfkFeLxOm7nxK1Yo6M
XmckCqXMNOUAMnENMf5N5tnYkIZSnEYrNTTWuIPRS8Xzo37HOfDJL1uyEJPPmxoR
K3/wH+LkecVIaWaP3+UH9VlieKnrC4+guFj4QdnXFzAqNQ55vEpDQs/sbFvjO0n9
IKTdKQKnsgs=
=0wST
-----END PGP SIGNATURE-----
