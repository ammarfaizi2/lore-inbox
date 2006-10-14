Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWJNDSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWJNDSj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 23:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbWJNDSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 23:18:38 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:34260 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1752041AbWJNDSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 23:18:38 -0400
Message-ID: <4530570B.7030500@comcast.net>
Date: Fri, 13 Oct 2006 23:18:35 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Driver model.. expel legacy drivers?
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's a silly thought I had a while ago.  Linux has no static ABI for
device drivers, I think the general argument was between "it's slower"
and "different hardware will have different requirements."  Putting
aside design difficulties, I've come up with an example case of a useful
hardware driver ABI.

As kernel development goes on, some infrastructure changes require
drivers to be updated.  Eventually some drivers become buggy and
ill-maintained, even when they used to be legitimately working ones; and
then developers have to take some of their time to fix them, or eject
them from the tree.

  (I can't think of any specific cases where a driver has actually
become buggy enough that it became a notable hazard.  OSS eventually was
deprecated and pulled out of the tree because its architecture was old
and it wasn't worth keeping since we have ALSA now.)

The drivers have to be shipped in the main tree as well, and the kernel
tarballs are getting bigger.  2.6.14 was in a 37M .tar.bz2; .15 was in a
38M; .16 and .17 in a 39M; .18 is in a 40M tarball.  The size keeps
piling up, that's more and more code that's got to be maintained and
shipped.

Writing Linux into a microkernel isn't going to happen.  Linus isn't hot
on the idea; and besides, what would the developers DO with that kind of
disruption?  Tons of projects would drop off because basement coders
can't all rewrite their code for a new architecture (hey why not port
your new Linux memory management patch to FreeBSD while you're at it?).
 So the only other way to isolate parts of the kernel off the main tree
is, obviously, by making a way to move drivers out of it.

This brings up a few potential questions:

  - Will this eventually be necessary to an absolute?  Will 100M
    tarballs and hundreds of thousands of drivers be unmanageable in a
    tight, ABI-unstable monolith 10 years from now?

  - Would it ACTUALLY be worthwhile, given such a scenario, to expel
    drivers out of the tree to glue on by a static, somewhat slower but
    workable ABI so nobody has to touch the code ever?

  - Is there actually a benefit -now- to ejecting drivers from the tree,
    or are the developers pretty much comfortable polishing the stuff
    nobody normally touches here and there?

Just curious.


- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRTBXCQs1xW0HCTEFAQKQyA/+Psr/NMmyrGGKBxeRw4AchHS2danZlS87
Mps20R8tm9CJMWUuPw0xZneBWz5kzG9MPJ4HvcAB4BZK1mp7a/ojFePIu1ZMW2qr
Xqn+yqk4vBr3ayh0Z8OFicxdDoJ/i47ON1h3QYfi3X9N/aLG/nMgFVbXJZ6CnImt
HQqj2YHGhvzu2CEQqYh3BzVOZkBJJ7AMgmIVUzajIrbGtR2/0XTyLvGfPYr9hzi0
N1YS+Rrgo7UoHU54qOjXoFWrrmvRc27vZydPTyU7DPDnruNNljS9QnfuT1XQbzyq
wM1+nFr6gHKPHI3MiZ3IktQnDSy0FQV08TRrTkFq88kE5zT79NkZIH7L4rQtN/VN
+dUV1JIQ1FvEnCATUpYueyb01BOIFK1xMIS2UMOFaghF09GmWhd+eIk80TT8PVaK
PvjEJ8FqQjSBqBPKzHVD8e1q86pfjZmLrQH+djLkkmfGXnqKG3BUWBfX+h4pQii5
iEpo0eznfxCvejvnyrWgl2jsKYW0dff7R4MQoPP99MgHXK7/hV4jmJTjNsh5z13j
vy+na5HR99IsGzBfwDgJIu6UPxq0Zf6JlP33dzeFgYyc3zAlAJMrrAZYDe+3xJsA
LJ7kNAdv51UhPQwAW45q+fWsn4iVOe9RgyNL5fBl4D8TkYdaHdsx2UVEoY54QEAZ
1O4ALzjdnVY=
=owQK
-----END PGP SIGNATURE-----
