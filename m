Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275122AbRIYRb7>; Tue, 25 Sep 2001 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275121AbRIYRbv>; Tue, 25 Sep 2001 13:31:51 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:34578 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S274579AbRIYRbn>; Tue, 25 Sep 2001 13:31:43 -0400
Date: Tue, 25 Sep 2001 13:34:16 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland.hansa.lan>
To: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] VIA sound driver now works on AOpen AK-33
Message-ID: <Pine.LNX.4.33.0109251309300.22564-100000@portland.hansa.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The driver for VIA 82Cxxx sound from the AC kernels is almost useless on
AOpen AK-33 motherboard - it reports that the dsp rate is locked at 48k.
Most programs cannot deal with it.

The driver from CVS maintained by Jeff Garzik
(http://sourceforge.net/projects/gkernel/) works much better - it doesn't
report that the frequency is locked.  Most applications work, although
xanim and realplayer sometimes produce an unpleasant noise.

The problem with Jeff's driver is that it resets the dsp format (stereo,
16-bit) on SNDCTL_DSP_RESET, unlike other drivers.

Another problem is that the pci resources are freed twice, which causes
alarming, although harmless, warnings when the driver is unloaded.

After fixing those problems the driver works just fine.  No problems
whatsoever.

Patch from Jeff's version to my fixed version (small):
http://www.red-bean.com/~proski/viasound/jg-pr.diff

Patch from 2.4.9-ac15 to my fixed version:
http://www.red-bean.com/~proski/viasound/ac-pr.diff

Whole driver:
http://www.red-bean.com/~proski/viasound/via82cxxx_audio.c

I'm not ready to comment on the Jeff's part of the patch.  I think it will
be better if Jeff submits the new driver.  I'm posting my results for
those who just want a working driver now.

-- 
Regards,
Pavel Roskin

