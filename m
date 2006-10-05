Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWJEVKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWJEVKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWJEVKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:10:01 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:47783 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S932200AbWJEVJ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:09:59 -0400
Date: Thu, 5 Oct 2006 23:09:36 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: monitor not active after boot (was Re: Merge window closed: v2.6.19-rc1)
Message-ID: <20061005210936.GA29654@aepfle.de>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If my monitor is off during boot and I turn it on once KDE is fully
started, the screen remains black. If it stays on during boot, X will
work ok. This happens on a G5 with ' nVidia Corporation NV43 [GeForce 6600] (rev a2)'
The i2c errors are new.

...
nvidiafb: Device ID: 10de0141 
nvidiafb: CRTC0 analog found
nvidiafb: CRTC1 analog found
ieee1394: Current remote IRM is not 1394a-2000 compliant, resetting...
i2c_adapter i2c-0: unable to read EDID block.
i2c_adapter i2c-0: unable to read EDID block.
ieee1394: Error parsing configrom for node 0-01:1023
i2c_adapter i2c-0: unable to read EDID block.
nvidiafb: Found OF EDID for head 1
nvidiafb: EDID found from BUS1
nvidiafb: EDID found from BUS2
nvidiafb: CRTC 0 appears to have a CRT attached
nvidiafb: Using CRT on CRTC 0
Console: switching to colour frame buffer device 128x48
nvidiafb: PCI nVidia NV14 framebuffer (64MB @ 0x90000000)
...


346bc21026e7a92e1d7a4a1b3792c5e8b686133d is first bad commit
diff-tree 346bc21026e7a92e1d7a4a1b3792c5e8b686133d (from fc5891c8a3ba284f13994d7bc1f1bfa8283982de)
Author: Antonino A. Daplas <adaplas@gmail.com>
Date:   Tue Oct 3 01:14:43 2006 -0700

    [PATCH] nvidiafb: Use generic DDC reading

    Update driver to use generic DDC reading

    Signed-off-by: Antonino Daplas <adaplas@pol.net>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 f20a7c1e3ce7d97a4b6e9bcde25b24685aeaabe4 9383ef67e1f4525eaaecd7d3c54685dea997dffc M      drivers

git-bisect start
# bad: [d223a60106891bfe46febfacf46b20cd8509aaad] Linux 2.6.19-rc1
git-bisect bad d223a60106891bfe46febfacf46b20cd8509aaad
# good: [119248f4578ca60b09c20893724e10f19806e6f1] Linux v2.6.18. Arrr!
git-bisect good 119248f4578ca60b09c20893724e10f19806e6f1
# good: [ac7f6b5e44cb0982b98c31fa33298ba73fb5dcfc] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev
git-bisect good ac7f6b5e44cb0982b98c31fa33298ba73fb5dcfc
# good: [82965addad66fce61a92c5f03104ea90b0b87124] Merge master.kernel.org:/pub/scm/linux/kernel/git/davej/agpgart
git-bisect good 82965addad66fce61a92c5f03104ea90b0b87124
# bad: [c53c1bb94f30cecee79ca0a8e9977640338283be] knfsd: lockd: Add nlm_destroy_host
git-bisect bad c53c1bb94f30cecee79ca0a8e9977640338283be
# bad: [2dc350283d3ea194c954428d86025190cab47366] drivers/video/sis/sis_accel.h: removal of old code
git-bisect bad 2dc350283d3ea194c954428d86025190cab47366
# good: [a12f66fccf2e266ad197df142b5ebafc6a169a8c] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git-bisect good a12f66fccf2e266ad197df142b5ebafc6a169a8c
# good: [829d464e60151a525c7ba57e7acfc4fc297f7069] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/roland/infiniband
git-bisect good 829d464e60151a525c7ba57e7acfc4fc297f7069
# good: [14e0a193209aeea810ad3d66388f422dc79c5b40] ide: fix revision comparison in ide_in_drive_list
git-bisect good 14e0a193209aeea810ad3d66388f422dc79c5b40
# bad: [bf5df0a2c54c2dc0fad619ac25d029119023610a] rivafb: Use generic DDC reading
git-bisect bad bf5df0a2c54c2dc0fad619ac25d029119023610a
# good: [a4bea10eca68152e84ffc4eaeb9d20ec2ac34664] Allow ide_generic_all to be used modular and built in
git-bisect good a4bea10eca68152e84ffc4eaeb9d20ec2ac34664
# good: [535a09ad59286b7675ffbf8b51d8ecb001c44386] rivafb: use constants instead of magic values
git-bisect good 535a09ad59286b7675ffbf8b51d8ecb001c44386
# good: [fc5891c8a3ba284f13994d7bc1f1bfa8283982de] fbdev: Add generic ddc read functionality
git-bisect good fc5891c8a3ba284f13994d7bc1f1bfa8283982de
# bad: [346bc21026e7a92e1d7a4a1b3792c5e8b686133d] nvidiafb: Use generic DDC reading
git-bisect bad 346bc21026e7a92e1d7a4a1b3792c5e8b686133d
