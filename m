Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288932AbSAFXrO>; Sun, 6 Jan 2002 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289045AbSAFXrD>; Sun, 6 Jan 2002 18:47:03 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:24453 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S288932AbSAFXqz>; Sun, 6 Jan 2002 18:46:55 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 6 Jan 2002 15:46:54 -0800
Message-Id: <200201062346.PAA01750@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.2.9: fbdev kdev_t build fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
>This patch fixes the build for the rest of fbdev in 2.5.2-pre9...

        I submitted a patch two days ago that fixed drivers/video
compilation.  The difference between my patch and yours is that
while I deleted the initializations of the form "fb_info.node = -1;",
you replaced them with "fb_info.node = NODEV;".

        -1 is all ones, NODEV is currently encoded as all zeroes.
I see no change in your patch that modifies any test for the
value of the "node" field, so, if there was any test that relied
on this value, it is now broken.

        However, I believe that there is no test that relies on the
initial value of fb_info.node before any call to register_framebuffer
(which sets fb_info.node to something meaningful).  So, as far as I
can tell, these initializations of fb_info.node are just wasting
CPU cycles and confusing developers.

        Can anyone identify a place that uses the initialized value
of fb_info.node prior to fb_info.node being set by register_framebuffer?

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
