Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUG1Mlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUG1Mlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 08:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266898AbUG1Mlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 08:41:52 -0400
Received: from enif.enif.ee ([193.40.56.210]:15377 "EHLO serv.enif.ee")
	by vger.kernel.org with ESMTP id S266896AbUG1Mld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 08:41:33 -0400
Date: Wed, 28 Jul 2004 15:41:28 +0300 (EEST)
From: Olav Kongas <olav@enif.ee>
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: input system: EVIOCSABS(abs) ioctl disabled, why?
Message-ID: <Pine.LNX.4.58.0407281453560.16069@serv.enif.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When trying to feed calibration information to a touchscreen driver with
the EVIOCSABS(abs) ioctl command, I noticed that this command is disabled
in 2.6.7. Only after the modification given in the patch below it was
possible to use this ioctl command.

Why is the EVIOCSABS command disabled? I cannot imagine that nobody uses
or needs it. The touchscreen drivers have no good way of determining the
absolute limits themselves, do they?

Thanks in advance,
Olav


--- linux-2.6.7/drivers/input/evdev.c.or	2004-07-21 13:27:03.000000000 +0300
+++ linux-2.6.7/drivers/input/evdev.c	2004-07-21 15:53:46.000000000 +0300
@@ -284,7 +284,7 @@

 		default:

-			if (_IOC_TYPE(cmd) != 'E' || _IOC_DIR(cmd) != _IOC_READ)
+			if (_IOC_TYPE(cmd) != 'E' || (_IOC_DIR(cmd) != _IOC_READ && (cmd & ~ABS_MAX) !=  EVIOCSABS(0)))
 				return -EINVAL;

 			if ((_IOC_NR(cmd) & ~EV_MAX) == _IOC_NR(EVIOCGBIT(0,0))) {
