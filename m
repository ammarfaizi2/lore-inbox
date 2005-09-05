Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVIEPBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVIEPBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 11:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVIEPBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 11:01:22 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:45330 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S932298AbVIEPBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 11:01:21 -0400
Date: Mon, 5 Sep 2005 17:01:12 +0200 (CEST)
From: gl@dsa-ac.de
To: linux-kernel@vger.kernel.org
Subject: who sets boot_params[].screen_info.orig_video_isVGA?
Message-ID: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am trying to get intelfb running on a system with a 855GM onboard chip, 
and the driver exits at intelfbdrv.c::intelfb_pci_register() (2.6.13, line 
814:

 	if (FIXED_MODE(dinfo) && ORIG_VIDEO_ISVGA != VIDEO_TYPE_VLFB) {
 		ERR_MSG("Video mode must be programmed at boot time.\n");
 		cleanup(dinfo);
 		return -ENODEV;
 	}

The FIXED_MODE(dinfo) test is true, because the board has a LCD connected 
to it, now, why is ORIG_VIDEO_ISVGA != VIDEO_TYPE_VLFB and is there any 
way to set the type to VIDEO_TYPE_VLFB? ORIG_VIDEO_ISVGA is defined in 
tty.h as

#define ORIG_VIDEO_ISVGA	(screen_info.orig_video_isVGA)

and screen_info is populated in setup.c::setup_arch() as

  	screen_info = SCREEN_INFO;

where SCREEN_INFO is defined in include/asm-i386/setup.h as

extern unsigned char boot_params[PARAM_SIZE];

#define PARAM	(boot_params)
#define SCREEN_INFO (*(struct screen_info *) (PARAM+0))

Now, what do I do with that? I couldn't get my analysis behind this point. 
It doesn't seem to be set up by the bootloader. Who sets this field(s), 
how can one force isVGA to the needed value and is this the correct way to 
get the driver to initialise at all? Is the test in intelfbdrv.c actually 
correct? And this

#define SCREEN_INFO (*(struct screen_info *) (PARAM+0))
#define EXT_MEM_K (*(unsigned short *) (PARAM+2))

in setup.h looks somewhat strange, unless, of course, it is not some 
16-bit mode...

Thanks in advance
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
