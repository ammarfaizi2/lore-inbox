Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271704AbRH0SOB>; Mon, 27 Aug 2001 14:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271724AbRH0SNw>; Mon, 27 Aug 2001 14:13:52 -0400
Received: from tank.panorama.sth.ac.at ([193.170.53.11]:22535 "EHLO
	tank.panorama.sth.ac.at") by vger.kernel.org with ESMTP
	id <S271704AbRH0SNm>; Mon, 27 Aug 2001 14:13:42 -0400
Date: Mon, 27 Aug 2001 20:13:51 +0200
From: Peter Surda <shurdeek@panorama.sth.ac.at>
To: linux-kernel@vger.kernel.org
Subject: memcpy to videoram eats too much CPU on ATI cards (cache trashing?)
Message-ID: <20010827201351.H17545@shurdeek.cb.ac.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXr400anF0jyguTS"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
X-Operating-System: Linux shurdeek 2.4.3-20mdk
X-Editor: VIM - Vi IMproved 6.0z ALPHA (2001 Mar 24, compiled Mar 26 2001 12:25:08)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXr400anF0jyguTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear kernel gurus,

First of all I want to apologise for writing here, but I think this is the
place with the greatest chance of getting some help. I have done extensive
research on the problem and talked to many people including driver developers
and was unable to find any solutions yet.

So, fist a little intro: when watching videos with Xv under XFree86, a certain
function is called to transfer the data from system RAM to video RAM. This
function is driver specific, but for all the drivers I checked (mga, tdfx,
mach64, r128) it has the same contents, looks like pasted. It basically does a
for (h--) memcpy (blah, blah, blah).

The point is that with mga, tdfx and what I heard nvidia too, this doesn't
cause any CPU load (or more precisely, non-measurable load). However, with
mach64 and r128, it DOES. I did some more research.

memcpy-ing 380kB at 25fps takes about 5ms per frame and causes X to eat 1% cpu
time (time measurements were done by tsc)
memcpy-ing 760kB at 25fps takes about 11ms per frame, but instead of eating
2% CPU time, it eats 35% (yes, that's 35 times more)

The speed isn't the real problem (when you multiply it you get about 70MB/s
and that's definitely enough). The problem is that this eats CPU time, and
that shouldn't (or at least not so much).

This happens on both of my systems, one with PIIMobile/366 and mach64, and one
with Duron 650 with r128. I had a voodoo before for tests, and CPU load wasn't
measurable, from what I heard mga and nvidia as well, so it is something
ATI-specific. Some other people having ATI cards have the same problem (from
what I read on gatos-devel list), but I have never heard someone explicitely
say "the problem doesn't exist on my ATI".

MTRR is enabled correctly, disabling it only worsens the problem.

I have been in close contact with the driver developer and XFree86 maintainer,
but none of them seem to know exactly how to solve it. Current theory is that
this is caused by some cache being trashed, but I have no idea how to fix it.

Oh yes, I already tried using a memcpy written in assembly utilizing MMX, but
it didn't show any change.

I would be very grateful for ideas.

Please CC me, I'm not on the list.

Bye,

Peter Surda (Shurdeek) <shurdeek@panorama.sth.ac.at>, ICQ 10236103, +436505122023

--
Failure is not an option. It comes bundled with your Microsoft product.

--BXr400anF0jyguTS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7io3fzogxsPZwLzcRArQ5AJ0Wi4C/tOeNX+Ny5koatHphcydOFQCeMfTI
+Q76K+RNwxmE5bEuYmo1pw0=
=DXR3
-----END PGP SIGNATURE-----

--BXr400anF0jyguTS--
