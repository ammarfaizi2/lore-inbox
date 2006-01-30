Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWA3Ue3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWA3Ue3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWA3Ue3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:34:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964962AbWA3Ue2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:34:28 -0500
Subject: Re: 2.6.15-rt16
From: Clark Williams <williams@redhat.com>
To: chris perkins <cperkins@OCF.Berkeley.EDU>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
References: <Pine.SOL.4.63.0601300839050.8546@conquest.OCF.Berkeley.EDU>
	 <1138640592.12625.0.camel@localhost.localdomain>
	 <Pine.SOL.4.63.0601300917120.8546@conquest.OCF.Berkeley.EDU>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yAVvafVzngipkcixkORR"
Date: Mon, 30 Jan 2006 14:33:55 -0600
Message-Id: <1138653235.26657.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yAVvafVzngipkcixkORR
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-01-30 at 09:24 -0800, chris perkins wrote:
> >> i'm trying to use ingo's 2.6.15-rt16 patch on an x86_64 machine but it
> >> keeps crashing in kmem_cache_init during bootup. i've tried older
> >> 2.6.15-rtX patches and they all crash during startup but vanilla 2.6.1=
5
> >> works fine for me. anyone else seen this happen with realtime-preempt
> >> patches? here's the message:
> >
> > Can you please send me your .config file ?
> >

<snip>

> CONFIG_LATENCY_TIMING=3Dy

I'm betting this is the same thing I'm seeing. Are you running on a
uniprocessor x86_64? And if so are you seeing messages similar to the
following?

init[1]: segfault at ffffffff8010fadc rip ffffffff8010fadc rsp
00007fffffdacfc8=20

If so, then I suspect that you're getting a segfault in ld.so (at least
that's the furthest I've gotten so far). Something about how the kernel
sets up the memory map is upsetting dynamically loaded executables. I
can boot with init=3D/sbin/sash, but when I try and run a dynamically
linked program, I get segfaults.=20

You might try turning off LATENCY_TRACING and see if that allows you to
boot and run (works for me).

Meanwhile, I'm going to try and pin this down to something better than
"somewhere in ld.so..."

Clark
-=20
Clark Williams <williams@redhat.com>

--=-yAVvafVzngipkcixkORR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3ngzHyuj/+TTEp0RAlYfAJ0c3GzJXpNfmnP1laNVmcqhjSlGlgCfVXKP
jKsA3Mq5BvHS76zuuz+RjTI=
=mXWW
-----END PGP SIGNATURE-----

--=-yAVvafVzngipkcixkORR--

