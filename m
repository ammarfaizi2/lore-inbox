Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSFULQf>; Fri, 21 Jun 2002 07:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSFULQf>; Fri, 21 Jun 2002 07:16:35 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:35851 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S316545AbSFULQd>;
	Fri, 21 Jun 2002 07:16:33 -0400
Date: Fri, 21 Jun 2002 15:14:40 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] SGI VISWS support for 2.5
Message-ID: <20020621111440.GA3613@pazke.ipt>
Mail-Followup-To: Jesse Barnes <jbarnes@sgi.com>,
	linux-kernel@vger.kernel.org
References: <20020620112608.GA303@pazke.ipt> <20020620213743.GA67049@sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20020620213743.GA67049@sgi.com>
User-Agent: Mutt/1.4i
X-Uname: Linux pazke 2.5.23
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On =D0=A7=D1=82=D0=B2, =D0=98=D1=8E=D0=BD 20, 2002 at 02:37:43 -0700, Jesse=
 Barnes wrote:
> I gave it a go on a 320 that I have here and it gets into start_kernel
> somewhere, but I don't get any output on the serial console.  If you'd
> like to get it into 2.5, maybe we should clean it up a little first
> (as well as get it working)?

We definetely need to make it working and cleanup is a good thing too,
but i dont have a VISWS (right now) so i'm limited to trivial mergework.

> When I ported the last patch forward to 2.4.17, I noticed that there
> were quite a few parts that could use some work.  Looking through the
> patch, it seems like the head.S stuff could be done in a better way,

As far as i understand VISWS fragment in the head.S does 3 thing:
	1) fills page tables;
	2) twiddle some bits in cr3.
	3) loads gdt and idt;
My small brain can't understand why we must do 1 and 3 so early.
BTW looks like we are filling page tables many times (for every CPU).
And why we move stext and _stext for VISWS ?
These are great mysteries ...

> maybe a seperate head.S for machines that start in protected mode?
I'm doubtfull, does it worth the effort ?

> Then again, maybe the boot loader should just be changed? The
> interrupt handler code also needs to be fixed up.
> I haven't looked at the patch to seperate out i386 subarches yet, but
> maybe that would be a good first step to abstracting away some of the
> visws setup code?

2.5 with James's arch-split patch has most of VISWS code separated already.
The only big trouble that remains is VISWS hacks in parse_mem_cmdline()=20
function.

Also when 2.5 will realy use platform driver to support reboot, halt
and power off, it will be possible to split VISWS code from process.c.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9EwqgBm4rlNOo3YgRAn2lAJsE4kPn44XeztLU+U0hAhm5MGw9dgCfannF
AaN6EXCuc6nPkOMFWwz05SA=
=ZIgB
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
