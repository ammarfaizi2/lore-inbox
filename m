Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268566AbTGSKo6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 06:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268620AbTGSKo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 06:44:58 -0400
Received: from mx02.qsc.de ([213.148.130.14]:40412 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S268566AbTGSKoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 06:44:55 -0400
Date: Sat, 19 Jul 2003 12:59:33 +0200
From: Wiktor Wodecki <wodecki@gmx.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] O6int for interactivity
Message-ID: <20030719105933.GA643@gmx.de>
Reply-To: Johoho <johoho@hojo-net.de>
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net> <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net> <20030718103105.GE622@gmx.de> <200307182043.06029.kernel@kolivas.org> <20030718113436.GA627@gmx.de> <3F17DC22.2070605@cyberone.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <3F17DC22.2070605@cyberone.com.au>
X-message-flag: Linux - choice of the GNU generation
X-Operating-System: Linux 2.6.0-test1-mm1-O6 i686
X-PGP-KeyID: 182C9783
X-Info: X-PGP-KeyID, send an email with the subject 'public key request' to wodecki@gmx.de
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2003 at 09:38:10PM +1000, Nick Piggin wrote:
>=20
>=20
> Wiktor Wodecki wrote:
>=20
> >On Fri, Jul 18, 2003 at 08:43:05PM +1000, Con Kolivas wrote:
> >
> >>On Fri, 18 Jul 2003 20:31, Wiktor Wodecki wrote:
> >>
> >>>On Fri, Jul 18, 2003 at 12:18:33PM +0200, Mike Galbraith wrote:
> >>>
> >>>>That _might_ (add salt) be priorities of kernel threads dropping too=
=20
> >>>>low.
> >>>>
> >>>>I'm also seeing occasional total stalls under heavy I/O in the order =
of
> >>>>10-12 seconds (even the disk stops).  I have no idea if that's someth=
ing
> >>>>in mm or the scheduler changes though, as I've yet to do any isolation
> >>>>and/or tinkering.  All I know at this point is that I haven't seen it=
 in
> >>>>stock yet.
> >>>>
> >>>I've seen this too while doing a huge nfs transfer from a 2.6 machine =
to
> >>>a 2.4 machine (sparc32). Thought it'd be something with the nfs changes
> >>>which were recently, might be the scheduler, tho. Ah, and it is fully
> >>>reproducable.
> >>>
> >>Well I didn't want to post this yet because I'm not sure if it's a good=
=20
> >>workaround yet but it looks like a reasonable compromise, and since you=
=20
> >>have a testcase it will be interesting to see if it addresses it. It's=
=20
> >>possible that a task is being requeued every millisecond, and this is a=
=20
> >>little smarter. It allows cpu hogs to run for 100ms before being round=
=20
> >>robinned, but shorter for interactive tasks. Can you try this O7 which=
=20
> >>applies on top of O6.1 please:
> >>
> >>available here:
> >>http://kernel.kolivas.org/2.5
> >>
> >
> >sorry, the problem still persists. Aborting the cp takes less time, tho
> >(about 10 seconds now, before it was about 30 secs). I'm aborting during
> >a big file, FYI.
> >
>=20
> OK if the IO actually stops then it shouldn't be an IO scheduler or
> request allocation problem, but could you try to capture a sysrq T
> trace for me during the freeze.

okay, here it is. I only paste the output for cp, if you need the whole
thing, tell me please.

Jul 19 12:54:16 kakerlak kernel: cp            D C0140F7B  6164   6160
(NOTLB)
Jul 19 12:54:16 kakerlak kernel: c2c6fec8 00200082 d3de680c c0140f7b
d3de6800 c72ef000 c0477cc0 d3de681c=20
Jul 19 12:54:16 kakerlak kernel:        d139ad60 c2c6e000 ce8dc3c0
ce8dc3dc 00000000 c01aba07 00000000 00000001=20
Jul 19 12:54:16 kakerlak kernel:        00000000 00000001 ce8153e4
00000000 c26706d0 c011cdb0 ce8dc3dc ce8dc3dc=20
Jul 19 12:54:16 kakerlak kernel: Call Trace:
Jul 19 12:54:16 kakerlak kernel:  [free_block+203/256]
free_block+0xcb/0x100
Jul 19 12:54:16 kakerlak kernel:  [nfs_wait_on_request+151/336]
nfs_wait_on_request+0x97/0x150
Jul 19 12:54:16 kakerlak kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Jul 19 12:54:16 kakerlak kernel:  [nfs_wait_on_requests+169/256]
nfs_wait_on_requests+0xa9/0x100
Jul 19 12:54:16 kakerlak kernel:  [nfs_sync_file+150/192]
nfs_sync_file+0x96/0xc0
Jul 19 12:54:16 kakerlak kernel:  [nfs_file_flush+88/208]
nfs_file_flush+0x58/0xd0
Jul 19 12:54:16 kakerlak kernel:  [filp_close+101/128]
filp_close+0x65/0x80
Jul 19 12:54:16 kakerlak kernel:  [sys_close+97/160] sys_close+0x61/0xa0
Jul 19 12:54:16 kakerlak kernel:  [syscall_call+7/11]
syscall_call+0x7/0xb
Jul 19 12:54:16 kakerlak kernel:=20


--=20
Regards,

Wiktor Wodecki

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/GSSV6SNaNRgsl4MRAlENAKCZvXrAkNnFJsp/xgrlff0OhQosBgCeKfve
xNlsSMwUFdgQjqVxQdWJaEY=
=IheW
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
