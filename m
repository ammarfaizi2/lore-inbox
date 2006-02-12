Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWBLLg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWBLLg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWBLLg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:36:28 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:40068 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932383AbWBLLg1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:36:27 -0500
Subject: Re: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
From: Marcel Holtmann <marcel@holtmann.org>
To: Carsten Paeth <calle@calle.in-berlin.de>
Cc: Armin Schindler <armin@melware.de>, Adrian Bunk <bunk@stusta.de>,
       kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, kkeil@suse.de
In-Reply-To: <20060212110903.GD17864@calle.in-berlin.de>
References: <20060131213306.GG3986@stusta.de>
	 <1138743844.3968.14.camel@localhost.localdomain>
	 <20060202214059.GB14097@stusta.de>
	 <1138924621.3788.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602030941580.13271@phoenix.one.melware.de>
	 <1138956828.3731.2.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0602031110280.15581@phoenix.one.melware.de>
	 <1138996640.3830.5.camel@localhost.localdomain>
	 <20060212110903.GD17864@calle.in-berlin.de>
Content-Type: multipart/mixed; boundary="=-WddJi7imxWc95MMeG2vh"
Date: Sun, 12 Feb 2006 12:36:15 +0100
Message-Id: <1139744175.5070.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WddJi7imxWc95MMeG2vh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Calle,

> I have no problems, when capifs is removed, but the pppdcapiplugin
> has to work without it.
> So if you want to remove capifs make sure pppdcapiplugin is
> working without problems together with udev ...
> 
> I'm too busy to check pppdcapiplugin together with udev ....

I posted this patch some time ago (actually April 2004) which made pppd
wait for the device node to be created before failing. I used it since
then and it still works fine for me.

Regards

Marcel


--=-WddJi7imxWc95MMeG2vh
Content-Disposition: attachment; filename=patch-pppdcapiplugin-wait-for-dev
Content-Type: text/x-patch; name=patch-pppdcapiplugin-wait-for-dev; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: capiplugin.c
===================================================================
RCS file: /i4ldev/isdn4k-utils/pppdcapiplugin/capiplugin.c,v
retrieving revision 1.33
diff -u -r1.33 capiplugin.c
--- capiplugin.c	16 Jan 2004 15:27:13 -0000	1.33
+++ capiplugin.c	12 Apr 2004 13:20:50 -0000
@@ -1413,6 +1413,11 @@
 	   fatal("capiplugin: failed to get tty devname - %s (%d)",
 			strerror(serrno), serrno);
 	}
+	retry = 0;
+	while (access(tty, 0) != 0 && (retry++ < 4)) {
+	   dbglog("capiplugin: capitty not available, waiting for device ...");
+	   sleep(1);
+	}
 	if (access(tty, 0) != 0 && errno == ENOENT) {
 	      fatal("capiplugin: tty %s doesn't exist - CAPI Filesystem Support not enabled in kernel or not mounted ?", tty);
 	}

--=-WddJi7imxWc95MMeG2vh--

