Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266867AbUGLPK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266867AbUGLPK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 11:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266864AbUGLPK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 11:10:28 -0400
Received: from mail014.syd.optusnet.com.au ([211.29.132.160]:59867 "EHLO
	mail014.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266867AbUGLPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 11:10:08 -0400
Message-ID: <40F2A9C9.2040107@kolivas.org>
Date: Tue, 13 Jul 2004 01:10:01 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ck kernel mailing list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc1 -ck snapshot
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC0E78BE9E892272BDA4E55B6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC0E78BE9E892272BDA4E55B6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've posted a snapshot of the current -ck development against 2.6.8-rc1

website: http://kernel.kolivas.org
rc1 patches: http://ck.kolivas.org/patches/2.6/2.6.7/2.6.8-rc1/

The staircase scheduler has been basically unchanged for a couple of 
weeks now with no bugs showing up (woohoo). I've resynced with the 
current versions of the vm hacks, added Ingo's voluntary preempt patch, 
added Zwane's low latency irq locks, the suse writeback latency patch, 
badram, lufs and the fixed version of William Lee Irwin III's preempt 
test. Bootsplash is currently on the backburner.

To preempt test is a debugging tool for latency and not intended for 
regular usage. Enable it in the config and set the bootparam
preempt_thresh=1
for checking for when there are parts of kernel code that are not 
preemptible for >1ms (set it to any desired number or dont set it to 
disable it).

It outputs to the syslog something like this:
4ms non-preemptible critical section violated 1 ms preempt threshold 
starting at exit_mmap+0x1c/0x188 and ending at exit_mmap+0x118/0x188
  [<c011d769>] dec_preempt_count+0x14f/0x151
  [<c014d0d4>] exit_mmap+0x118/0x188
etc.

I'm running this kernel currently without problems. The badram and lufs 
features are compile tested only.

Full patches:
from_2.6.7_to_staircase7.A
schedrange.diff
schedbatch2.3.diff
schediso2.3.diff
autotune_swappiness.diff
autotune_inactivation.diff
supermount-ng204.diff
defaultcfq.diff
config_hz.diff
voluntary-preempt-2.6.7-bk20-H3
patch-i386-irq_enable_spinlocks2
patch-ool-spinlocks
9000_SuSE-117-writeback-lat.patch
wli_preempttest2
wli_preempttest2.1
BadRAM-2.6.5.2.patch.bz2
lufs-0.9.7-2.6.0-test9.patch.bz2
ck5version.diff


Cheers,
Con

--------------enigC0E78BE9E892272BDA4E55B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA8qnJZUg7+tp6mRURAiZ7AJ99R5q48gwKvMGpnkkPyaJGgb2K1QCeIXXT
q9xaHpcT/XMGTsd/EjaDSW8=
=u2Li
-----END PGP SIGNATURE-----

--------------enigC0E78BE9E892272BDA4E55B6--
