Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965361AbWJBTJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965361AbWJBTJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965357AbWJBTJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:09:01 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:48085 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S965355AbWJBTI7 (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:08:59 -0400
Message-Id: <200610021908.k92J8J8c012853@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: john stultz <johnstul@us.ibm.com>
Cc: tglx@linutronix.de, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/21] high resolution timers / dynamic ticks - V2
In-Reply-To: Your message of "Mon, 02 Oct 2006 11:38:36 PDT."
             <1159814317.5873.14.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <200610021302.k92D23W1003320@turing-police.cc.vt.edu> <1159796582.1386.9.camel@localhost.localdomain> <200610021825.k92IPSnd008215@turing-police.cc.vt.edu>
            <1159814317.5873.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159816099_5418P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Oct 2006 15:08:19 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159816099_5418P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <12843.1159816099.1@turing-police.cc.vt.edu>

On Mon, 02 Oct 2006 11:38:36 PDT, john stultz said:

> Hmmm. So w/ -mm2 we're seeing the TSC get detected as running too slowly
> (and its replaced w/ the ACPI PM), but for some reason that doesn't
> happen w/ the dynticks patch.

It's been switching to ACPI PM for somewhere near forever, I never bothered
to check into that because the PM timer provides a reasonably stable clock
source (it drifts at about 24 ppm and NTP is happy with it, and I haven't
gotten annoyed at the fact the PM timer is slow to read...)

I wonder if the TSC has been broken for forever on this box, and I'm just
seeing it because dynticks doesn't fall over to PM timer..

> Now, how is cpuspeed changing the cpufreq? Is it using the /sys
> interface? I've got hooks in so when the cpufreq changes we should mark
> it unstable and fall back to ACPI PM, but maybe I missed whatever hook
> cpuspeed is using.

Looking at the source, it appears to do this:

const char SYSFS_CURRENT_SPEED_FILE[] =
     "/sys/devices/system/cpu/cpu%u/cpufreq/scaling_setspeed";

// set the current CPU speed
void set_speed(unsigned value)
{
#ifdef DEBUG
    fprintf(stderr, "[cpu%u] Setting speed to: %uKHz\n", cpu, value);
#endif
    write_line(CURRENT_SPEED_FILE, "%u\n", value);
    // give CPU / chipset voltage time to settle down
    usleep(10000);
}


--==_Exmh_1159816099_5418P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFIWOjcC3lWbTT17ARAtNXAKC1YfQMlnnHDeu4sGqmzb1fXL5BkwCfd1lu
tdtkqfavf307iGWui3gv7aI=
=I3Zo
-----END PGP SIGNATURE-----

--==_Exmh_1159816099_5418P--
