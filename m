Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUGQTTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUGQTTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 15:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUGQTTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 15:19:14 -0400
Received: from dhcp160179209.columbus.rr.com ([24.160.179.209]:2315 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S261169AbUGQTTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 15:19:08 -0400
Date: Sat, 17 Jul 2004 15:19:03 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Joseph Fannin <jhf@rivenstone.net>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6.7-mm7
Message-ID: <20040717191903.GA1801@zion.rivenstone.net>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@osdl.org>, Joseph Fannin <jhf@rivenstone.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
References: <20040708235025.5f8436b7.akpm@osdl.org> <20040709203852.GA1997@samarkand.rivenstone.net> <20040709141103.592c4655.akpm@osdl.org> <16633.20767.128875.570852@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <16633.20767.128875.570852@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040523i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 18, 2004 at 02:17:35AM +1000, Paul Mackerras wrote:
> Andrew Morton writes:
>=20
> > hm, OK.  It could be that the debug patch is a bit too aggressive, or t=
hat
> > ppc got lucky and happens to always be in state TASK_RUNNING when these
> > calls to schedule() occur.
> >=20
> > Maybe this task incorrectly has _TIF_NEED_RESCHED set?
>=20
> Is CONFIG_PREEMPT enabled?

    These traces are with preempt enabled, but I tried turning it off
and the messages are still there (there seem to be a lot less of them,
though.)

    I would be glad to produce a dmesg with preempt off if it makes
things clearer (tonight, or tommorrow, or I'd just do it now.)
=20
> > Anyway, ppc guys: please take a look at the results from
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6=
=2E7-mm7/broken-out/detect-too-early-schedule-attempts.patch
> > and check that the kernel really should be calling schedule() at this t=
ime
> > and place, let us know?
> >=20
> > Thanks.
> >=20
> > >  The first one looks like:
> > >
> > > Calibrating delay loop... 1064.96 BogoMIPS
> > > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > > Badness in schedule at kernel/sched.c:2153
> > > Call trace:
> > >  [c00099e4] dump_stack+0x18/0x28
> > >  [c0006bac] check_bug_trap+0x84/0xac
> > >  [c0006d38] ProgramCheckException+0x164/0x1a4
> > >  [c0006240] ret_from_except_full+0x0/0x4c
> > >  [c02021bc] schedule+0x24/0x684
> > >  [c0005e80] syscall_exit_work+0x108/0x10c
> > >  [c02e0ad0] proc_root_init+0x14c/0x158
> > >  [00000000] 0x0
> > >  [c02ce5a0] start_kernel+0x158/0x184
> > >  [000035fc] 0x35fc
>=20
> This looks like CONFIG_PREEMPT is enabled and _TIF_NEED_RESCHED is set
> at the end of handling a system call.  AFAICS i386 will also call
> schedule in these circumstances.  Does this mean we shouldn't do
> system calls until the scheduler is running?
>=20
> Paul.
>=20

--=20
Joseph Fannin
jhf@rivenstone.net

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+XunWv4KsgKfSVgRAsk9AJ9APxj1f0n5afbmDw6//qcprTpx+ACeO+7m
23KwkPYVQ2U/WCRYCSYePoM=
=n2+2
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
