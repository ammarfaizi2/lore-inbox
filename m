Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVC2Iv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVC2Iv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVC2Iss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:48:48 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:48542 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262188AbVC2IpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:45:21 -0500
Message-ID: <424915A2.8090401@comcast.net>
Date: Tue, 29 Mar 2005 03:45:22 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: Arjan van de Ven <arjan@infradead.org>,
       Brandon Hale <brandon@smarterits.com>, ubuntu-hardened@lists.ubuntu.com,
       linux-kernel@vger.kernel.org
Subject: Re: [ubuntu-hardened] Re: Collecting NX information
References: <42484B13.4060408@comcast.net>	 <1112035059.6003.44.camel@laptopd505.fenrus.org>	 <4248520E.1070602@comcast.net>	 <1112036121.6003.46.camel@laptopd505.fenrus.org>	 <424857B0.4030302@comcast.net>	 <1112043246.10117.5.camel@localhost.localdomain>	 <4248828B.20708@comcast.net> <1112080581.6282.1.camel@laptopd505.fenrus.org> <4249096B.7020802@comcast.net>
In-Reply-To: <4249096B.7020802@comcast.net>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



John Richard Moser wrote:
> 
> 
> Arjan van de Ven wrote:
> 
[...]

Three more notes, then I'll sleep.  These notes won't include the two
paragraph long explaination of falling back to PT_GNU_STACK if
PT_PAX_FLAGS isn't there; compatibility has been touched what, 5 times?

1.  I don't want to continue using PT_GNU_STACK for three reasons.  The
first being that PaX uses a tristate in PT_PAX_FLAGS; the second being
that PT_GNU_STACK is a whole ELF field and I'm inclined to take the more
space-efficient method; and the third being that PT_GNU_STACK is not a
tristate.

The last is particularly an important consideration to me:  a tristate
would allow for a compatibility/soft mode, but changing PT_GNU_STACK's
logic would change the current expected behavior and thus could be
unpredictable (break things).  I have no interest in breaking Fedora
horribly, nor wasting space with a full field where sharing with the
other parts of PT_PAX_FLAGS would do just fine.

2.  Although binutils can emit PT_GNU_STACK, the paxctl utility could
also be modified to detect PT_GNU_STACK in a binary without PT_PAX_FLAGS
and change it to PT_PAX_FLAGS, then nuke it.  This would allow the flags
to be changed without relinking (remember PT_GNU_STACK is to be ignored
if PT_PAX_FLAGS exists at all).  This is only of interest to
distributions which will use PT_PAX_FLAGS.

Note also that execstack would probably be wisely modified to set
PF_PAGEEXEC and PT_GNU_STACK both, just for future compatibility.  This
is of course a lot of work (I tried to make paxctl hack EI_PAX too, and
. . .well, it didn't work).

3.  PaX won't pay any attention to markings on libraries.  Exec Shield
and Mainline may, though I have no idea how.  If it can be done with
PT_GNU_STACK, it can be done with PT_PAX_FLAGS.  Such behavior is
acceptable, though libraries should be coded with the utmost care to
avoid this simply because the weakening of security around a library
weakens any and all programs using that library.


- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCSRWghDd4aOud5P8RAhRFAJ9Ezr6mMIEvk9R+4XpXq7+lZxgd0gCfYhBa
IuUU7Zeuk1J9kSJXCSqZlKU=
=m0YW
-----END PGP SIGNATURE-----
