Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWGRDro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWGRDro (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 23:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWGRDro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 23:47:44 -0400
Received: from srvr22.engin.umich.edu ([141.213.75.21]:50342 "EHLO
	srvr22.engin.umich.edu") by vger.kernel.org with ESMTP
	id S1751158AbWGRDro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 23:47:44 -0400
From: Matt Reuther <mreuther@umich.edu>
Organization: The Knights Who Say... Ni!
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: 2.6.18-rc2: depmod warning for backlight.ko
Date: Mon, 17 Jul 2006 23:58:06 -0400
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607172358.07713.mreuther@umich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Antonino.

I am still getting warnings on depmod with the 2.6.18-rc2 kernel:

  INSTALL sound/usb/snd-usb-audio.ko
  INSTALL sound/usb/snd-usb-lib.ko
  INSTALL sound/usb/usx2y/snd-usb-usx2y.ko
if [ -r System.map -a -x /sbin/depmod ]; then /sbin/depmod -ae -F System.map  
2.6.18-rc2; fi
WARNING: /lib/modules/2.6.18-rc2/kernel/drivers/video/backlight/backlight.ko 
needs unknown symbol fb_unregister_client
WARNING: /lib/modules/2.6.18-rc2/kernel/drivers/video/backlight/backlight.ko 
needs unknown symbol fb_register_client

You posted a patch here a few days ago for 2.6.18-rc1-mm1 which fixes this 
issue. Basically, the USB Apple Cinema display driver selects backlight 
support, but backlight needs some things from framebuffer, which is turned 
off. Kconfig does not recursively select CONFIG_FB, so backlight ends up with 
unresolved symbols.

Matt
