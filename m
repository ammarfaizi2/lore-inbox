Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbTGQBOU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 21:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271301AbTGQBOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 21:14:20 -0400
Received: from niobium.golden.net ([199.166.210.90]:24010 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP id S267520AbTGQBOS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 21:14:18 -0400
Date: Wed, 16 Jul 2003 21:28:58 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Miguel Sousa Filipe <m3thos@netcabo.pt>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1  doesn't compile on PPC iBook2.2
Message-ID: <20030717012858.GA11672@linux-sh.org>
Mail-Followup-To: Miguel Sousa Filipe <m3thos@netcabo.pt>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200307170015.h6H0FRBX019953@harpo.it.uu.se> <3F15EEB7.2060008@netcabo.pt> <3F15F471.3000004@netcabo.pt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <3F15F471.3000004@netcabo.pt>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2003 at 01:57:21AM +0100, Miguel Sousa Filipe wrote:
> >  CC      arch/ppc/platforms/pmac_nvram.o
> >  CC      arch/ppc/platforms/pmac_cpufreq.o
> >arch/ppc/platforms/pmac_cpufreq.c: In function `do_set_cpu_speed':
> >arch/ppc/platforms/pmac_cpufreq.c:179: `CPUFREQ_ALL_CPUS' undeclared=20
> >(first use in this function)
> >arch/ppc/platforms/pmac_cpufreq.c:179: (Each undeclared identifier is=20
> >reported only once
> >arch/ppc/platforms/pmac_cpufreq.c:179: for each function it appears in.)
> >make[1]: *** [arch/ppc/platforms/pmac_cpufreq.o] Error 1
> >make: *** [arch/ppc/platforms] Error 2
> >

This means that the driver hasn't been updated for the new cpufreq API chan=
ges.

CPUFREQ_ALL_CPUS is deprecated, as is the /proc interface (which is what
proc_intf.c references), since now the sysfs interface is preferred.

The pmac_cpufreq.c driver will likely need to be updated a bit (which may
already be done in the LinuxPPC trees) in order to build or function.

Notably, the verify stuff needs to be changed around quite a bit, since ins=
tead
of doing the range validation and wrapping to cpufreq_verify_within_limits(=
), a
frequency table is built up instead and subsequently passed through
cpufreq_frequency_table_verify(). Take a look at some of the existing cpufr=
eq
drivers that are up-to-date for ideas on how to do this (most of the i386 o=
nes,
the SuperH one, and probably others).

As such, you can either look at updating the driver (if this hasn't already
been done by the LinuxPPC folk), or you can just not build it in. Probably =
no
good things will happen if you hack it to the point of building and then
attempt to use it.


--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/FfvZ1K+teJFxZ9wRAiFwAJ9QTQNgB+eZqTpjMGP6WRC1e/WfCACdFtek
LxpjHtlAYV5z9d5vxiZTBlk=
=dTVV
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
