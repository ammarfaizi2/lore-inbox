Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWEQMw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWEQMw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 08:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWEQMw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 08:52:26 -0400
Received: from cernmx05.cern.ch ([137.138.166.161]:64602 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S932548AbWEQMwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 08:52:25 -0400
Keywords: CERN SpamKiller Note: -49 Charset: west-latin
X-Filter: CERNMX05 CERN MX v2.0 051012.1312 Release
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-27--88054423"
Message-Id: <52856E4D-6645-4FB1-A8E8-56CA62C9B9AC@e18.physik.tu-muenchen.de>
Content-Transfer-Encoding: 7bit
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Subject: crash below shrink_dcache_memory
Date: Wed, 17 May 2006 14:52:33 +0200
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
X-Pgp-Agent: GPGMail 1.1 (Tiger)
X-Mailer: Apple Mail (2.749.3)
X-OriginalArrivalTime: 17 May 2006 12:52:22.0019 (UTC) FILETIME=[BD162D30:01C679B0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-27--88054423
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hi!

We're having trouble here with our data acquisition systems when  
recording some 10MB/s from a PCI card to a file on NFS, using write 
()'s of about 8kB. I thought is was connected to running X at the  
same time, but without X it also happened and I got part of a backtrace:

[scrolled off]
kdb
die
vprintk
do_page_fault
do_page_fault
iput
load_balance_newidle
schedule
do_page_fault
error_code
nfs_dentry_iput
iput
nfs_dentry_iput
prune_dcache
shrink_dcache_memory
shrink_slab
balance_pgdat
prepare_to_wait
kswapd
[...]

The system is Scientific Linux CERN 4.3, based on RHEL4, kernel  
2.6.9-34.EL.cernsmp, running on a two-way Xeon. What I'd like to know  
is whether a page fault can legally happen while shrinking the  
dcache; this sounds a bit counterintuitive to me. If anyone has an  
idea where to look for the cause of the crash, you're welcome.

Ciao,
                     Roland

--
TU Muenchen, Physik-Department E18, James-Franck-Str., 85748 Garching
Telefon 089/289-12575; Telefax 089/289-12570
--
CERN office: 892-1-D23 phone: +41 22 7676540 mobile: +41 76 487 4482
--
UNIX was not designed to stop you from doing stupid things, because that
would also stop you from doing clever things.
	-Doug Gwyn
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/CS/M/MU d-(++) s:+ a-> C+++ UL++++ P+++ L+++ E(+) W+ !N K- w--- M 
+ !V Y+
PGP++ t+(++) 5 R+ tv-- b+ DI++ e+++>++++ h---- y+++
------END GEEK CODE BLOCK------





--Apple-Mail-27--88054423
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (Darwin)

iD8DBQFEaxycI4MWO8QIRP0RAo5bAJ9qHLgC0NDi5ENAl7D0YgW7mwBlzQCgsjsf
jq/pdIdsfL+290JnkA8P3l0=
=luPU
-----END PGP SIGNATURE-----

--Apple-Mail-27--88054423--
