Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUIPDAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUIPDAW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 23:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUIPDAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 23:00:22 -0400
Received: from dhcp160178161.columbus.rr.com ([24.160.178.161]:56072 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id S267291AbUIPDAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 23:00:01 -0400
Date: Wed, 15 Sep 2004 22:59:43 -0400
To: dri-devel@lists.sourceforge.net
Cc: arlied@linux.ie, linux-kernel@vger.kernel.org
Subject: DRM regression in Linux 2.6.9-rc1-bk12
Message-ID: <20040916025942.GA27261@samarkand.rivenstone.net>
Mail-Followup-To: dri-devel@lists.sourceforge.net, arlied@linux.ie,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: jhf@rivenstone.net (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

    Hi!

    [ I suspect dri-devel is going to bounce my mails, so I'm CC'ing
linux-kernel ]

    DRI stopped working on my setup in Linux 2.6.9-rc1-bk12.  I've
narrowed the problem down to this changeset (Drop __HAVE_CTX_BITMAP,
__HAVE_SG, __HAVE_PCI_DMA):

http://linux.bkbits.net:8080/linux-2.5/cset@413a5e3ecfrYcOqFo6JOgkPIU-qVmQ

    Backing this patch out makes DRI in -bk12 work again.

    I've verified this on two machines with PCI Radeon 7000 cards, so
there's PCIGART stuff involved; unfortunately I don't have any AGP
Radeons to test with.  (I originally suspected the __REALLY_HAVE_AGP
change, but that's fine, along with the DRIVER_FILE_FIELDS removal).

    For what it matters, I'm primarily testing on a ppc Macintosh, but
I've verified this on a PC too.

    Wow, there was no kidding about DRM being difficult to read.  :-)
I hope this is helpful, but I don't urgently need DRI working.  I'd be
glad to give any help tracking the problem down.

    On kernels with non-working DRM, I get this message from the kernel:

[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 2150 using kernel context 0

    While X says:

        [24] 0  0       0x000003c0 - 0x000003df (0x20) IS[B](OprU)
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: open result is -1, (Unknown error 999)
drmOpenDevice: Open failed
drmOpenDevice: minor is 0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 7, (OK)
drmGetBusid returned ''
(II) RADEON(0): [drm] loaded kernel module for "radeon" driver
(II) RADEON(0): [drm] created "radeon" driver at busid "PCI:0:18:0"
(II) RADEON(0): [drm] added 8192 byte SAREA at 0xcd971000
(II) RADEON(0): [drm] mapped SAREA 0xcd971000 to 0xb5d89000
(II) RADEON(0): [drm] framebuffer handle = 0xd8000000
(II) RADEON(0): [drm] added 1 reserved context for kernel


(EE) RADEON(0): [pci] Out of memory (-1007)          <------- *** LOOK HERE ***


(II) RADEON(0): [drm] removed 1 reserved context for kernel
(II) RADEON(0): [drm] unmapping 8192 bytes of SAREA 0xcd971000 at
0xb5d89000
(II) RADEON(0): Memory manager initialized to (0,0) (1280,6553)
(II) RADEON(0): Reserved area from (0,1024) to (1280,1026)
(II) RADEON(0): Largest offscreen area available: 1280 x 5527
(II) RADEON(0): Using XFree86 Acceleration Architecture (XAA)

<snip>

(II) RADEON(0): Direct rendering disabled


    Thanks!

--
Joseph Fannin
jhf@rivenstone.net

"Bull in pure form is rare; there is usually some contamination by data."
    -- William Graves Perry Jr.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBSQGeWv4KsgKfSVgRAk/YAJ9nlu7ZFNVwNXAObDz3YGOl2JLAygCgk5md
y/l8wDe3KppUogedLhh2DP4=
=8aWN
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
