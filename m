Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318793AbSH1Lta>; Wed, 28 Aug 2002 07:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318796AbSH1Lsg>; Wed, 28 Aug 2002 07:48:36 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:47441 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318793AbSH1Lq2>; Wed, 28 Aug 2002 07:46:28 -0400
Date: Wed, 28 Aug 2002 13:46:00 +0200
From: Dominik Brodowski <devel@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020828134600.A19189@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus, lkml,

The following patches add CPU frequency and volatage scaling
support (Intel SpeedStep, AMD PowerNow, etc.) to kernel 2.5.32


Patch 1/4: cpufreq-core
-----------------------
The cpufreq core offers a common interface to the CPU clock=20
speed features of ARM, PPC and x86 CPUs. =20

For communication with user space, sysctl entries are placed in
/proc/sys/cpu/{0,1,...,NR_CPUS-1}/ .  Entries provided are:

	speed-min  (readonly)
	speed-max  (readonly)
	speed-sync (readonly - all CPUs need the same frequency,
	                       changes affect all CPUs)
	speed      (read/write)

In order for this code to be built, an architecture must define the
CONFIG_CPU_FREQ configuration symbol.  The merged ARM code already
has the necessary configuration in place, the i386 code follows in
parts 2 and 3.

Specifically on ARM CPUs, the core is especially important, since
various ARM system on a chip implementations derive peripheral clocks
from the CPU clock (eg, LCD controllers, SDRAM controllers, etc).
The core allows these peripherals to take action either prior and/or
after the actual CPU clock adjustment so we don't go out of tolerance.


Patch 2/4: cpufreq-i386-core
----------------------------
The main part of this patch is a CPUFreq notifier in arch/i386/kernel/time.=
c.
It updates the i386-specific cpu_khz, cpu_data[].loops_per_jiffy and
fast_gettimeoffset_quotient on each frequency change.

Additionally, this patch allows "cpu_khz" to be exported (it is needed=20
for some cpufreq drivers) and adds some MSR #defines to asm-i386/msr.h


Patch 3/4: cpufreq-i386-drivers
-------------------------------
Four i386 CPUFreq drivers are ready to be merged this time. These are:
elanfreq.c:	  The AMD Elan CPU family offers extensive clock scaling
longhaul.c:	  VIA Longhaul processor clock + voltage scaling
powernow-k6.c:	  mobile AMD K6-2+ / mobile AMD K6-3+ clock scaling
speedstep.c:	  clock and voltage scaling on mobile Intel Pentium 3 and 4s,
		  but (unfortunately) only on ICH2-M or ICH3-M based
                  chipsets.

Support for mobile AMD K7 processors is still in development.


Patch 4/4: cpufreq-doc
----------------------
an entry to the CREDITS and the MAINTAINERS file, Config.help texts, and
extensive documentation in linux/Documentation/cpufreq


Comments welcome; however please ensure that the cpufreq development
list at cpufreq@www.linux.org.uk receives a copy of all comments.

	Dominik

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9bLf2Z8MDCHJbN8YRAsnKAJ9rSSwPj8SSaOjad8bfJRzjX1c+EQCgnwsa
9xaM7r/j48L336B7krSQbbc=
=Kuqv
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
