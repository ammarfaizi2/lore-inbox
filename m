Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268288AbTBMUsP>; Thu, 13 Feb 2003 15:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268289AbTBMUsP>; Thu, 13 Feb 2003 15:48:15 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:900 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S268288AbTBMUsO>; Thu, 13 Feb 2003 15:48:14 -0500
Message-Id: <200302132057.h1DKvxFT010317@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6 02/09/2003 with nmh-1.0.4+dev
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 352] New: Unneccessary includes of linux/version.h 
In-Reply-To: Your message of "Thu, 13 Feb 2003 12:13:08 PST."
             <23800000.1045167188@[10.10.2.4]> 
From: Valdis.Kletnieks@vt.edu
References: <23800000.1045167188@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1875858588P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 13 Feb 2003 15:57:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1875858588P
Content-Type: text/plain; charset=us-ascii

On Thu, 13 Feb 2003 12:13:08 PST, "Martin J. Bligh" <mbligh@aracnet.com>  said:

> There appears to be a large number of kernel files (267) that #include 
> <linux/version.h>, but do not use any of the three things defined in it.
> This  causes these files to be needlessly(I think) recompiled during a
> kernel rebuild  if only the version.h file changes. Would a patch to remove
> these extra  includes be accepted? 
> 
> Here is the list (generated with a script, so it could be wrong..)

Did your script include tracing of second-order effects?

The following reference one of the 3 version.h variables but don't include
linux/version.h themselves:

include/linux/coda.h
include/linux/compile.h
include/linux/cyclomx.h
include/linux/istallion.h
include/linux/mtd/cfi.h
include/linux/netfilter_ipv4/ipchains_core.h
include/linux/serialP.h
include/linux/stallion.h
include/linux/videodev2.h
include/net/irda/vlsi_ir.h


So for instance, the ipchains_core.h may explain these files in your list:

/net/ipv4/netfilter/ip_conntrack_core.c
/net/ipv4/netfilter/ip_nat_core.c
/net/ipv4/netfilter/ip_nat_helper.c
/net/ipv4/netfilter/ipt_ULOG.c
/net/ipv4/netfilter/ip_nat_rule.c
/net/ipv4/netfilter/ip_conntrack_standalone.c
/net/ipv4/netfilter/ip_nat_standalone.c
/net/ipv4/netfilter/ip_fw_compat_masq.c

because *somebody* needs to include version.h.

So a patch may be needed, but it should add the #include to the .h file while
cleaning up the .c files.  On the other hand, I'll let somebody who understands
the kernel build system better than I comment on what happens to dependencies
and whether the files that *appear* to be gratuitously rebuilt in fact do need
to be rebuilt....

--==_Exmh_1875858588P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+TAbWcC3lWbTT17ARAtGtAJ4sUIoHoAl9LJu6lyWQrcDP6E4BVgCeIoDS
eTcF752DWSN/OUxL30oxsRs=
=UgVw
-----END PGP SIGNATURE-----

--==_Exmh_1875858588P--
