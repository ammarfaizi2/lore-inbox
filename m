Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266648AbUHVLRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266648AbUHVLRj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 07:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266650AbUHVLRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 07:17:39 -0400
Received: from mail006.syd.optusnet.com.au ([211.29.132.63]:51852 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266648AbUHVLRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 07:17:33 -0400
Message-ID: <412880BF.6050503@kolivas.org>
Date: Sun, 22 Aug 2004 21:17:19 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.8.1-ck4
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96DAAEFFF0C74516F8223FA3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96DAAEFFF0C74516F8223FA3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patchset update. These are patches designed to improve system 
responsiveness with specific emphasis on the desktop, but configurable 
to any workload.

The short time between ck3 and ck4 is for two reasons. First Ingo 
discovered a nasty bug affecting X performance and I believe I made a 
reasonable breakthrough on the never ending desktop vm swappiness saga.

Web site with faq:
http://kernel.kolivas.org
Patches (with split-out also):
http://ck.kolivas.org/patches/2.6/2.6.8.1/2.6.8.1-ck4/


Added since 2.6.8.1-ck3:
+mapped_watermark.diff

This readjusts the way memory is evicted by lightly removing cached ram 
once the ram is more than 2/3 full, if less than the "mapped watermark" 
percent of ram is mapped ram (ie applications). The normal system is to 
aggresively start scanning ram once it is completely full. The benefits 
of this are:
1. Allocating memory while ram is being lightly scanned is faster and 
cheaper than when it is being heavily scanned.
2. There is usually some free ram which tends to speed up application 
startup times.
3. Swapping is an unusual event instead of a common one if you have 
enough ram for your workload.
4. It is rare for your applications to be swapped out by file cache 
pressure.
Disadvantage: Less file cache - but can be offset with the tunable

The mapped watermark is configurable so a server for example might be 
happy to have a lower mapped percentage. The default is 66 and a server 
might like 33 (0 is also fine)

echo 33 > /proc/sys/vm/mapped

This patch removes the swappiness knob entirely and deprecates all my 
previous vm hacks (autoregulated swappiness, hard swappiness, kiflush).

+ioport-latency-fix-2.6.8.1.patch
A nasty bug Ingo tracked down that caused high latencies and cache 
trashing with X.


Changed:
~Staircase8.0
Backed out a tweak designed to improve behaviour under filesystem load - 
I am avoiding all "tweaks" in the design, and it's effectiveness was 
questionable.
Added a tiny check to recalc_task_prio which should make it safe when 
the Hz value is set below 500.

~1g_lowmem_i386
Made the 1Gb of lowmem configurable if highmem is disabled.


Removed:
-hard_swappiness1.diff
-kiflush3.diff
Deprected in favour of mapped_watermark


Full patchlist:
from_2.6.8.1_to_staircase8.0.bz2
schedrange.diff
schedbatch2.4.diff
schediso2.5.diff
sched-adjust-p4gain
mapped_watermark.diff
defaultcfq.diff
config_hz.diff
1g_lowmem_i386.diff
akpm-latency-fix.patch
9000-SuSE-117-writeback-lat.patch
cddvd-cmdfilter-drop.patch
cool-spinlocks-i386.diff
bio_uncopy_user-mem-leak.patch
bio_uncopy_user2.diff
ioport-latency-fix-2.6.8.1.patch
supermount-ng204.diff.bz2
fbsplash-0.9-r5-2.6.8-rc3.patch.bz2
make-tree_lock-an-rwlock.patch.bz2
invalidate_inodes-speedup.patch
2.6.8.1-mm2-reiser4.diff.bz2
2.6.8.1-ck4-version.diff


Cheers,
Con

--------------enig96DAAEFFF0C74516F8223FA3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBKIDCZUg7+tp6mRURAnt7AJ0f/O3ur9EugLqSL62wak6NOt1SjwCfWVio
uKdTcw4bLY6FK+qAcGwB9gc=
=xNar
-----END PGP SIGNATURE-----

--------------enig96DAAEFFF0C74516F8223FA3--
