Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbTK3CAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 21:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTK3CAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 21:00:11 -0500
Received: from ws23-90.kotiportti.fi ([193.185.141.90]:19328 "EHLO
	mood.kotiportti.fi") by vger.kernel.org with ESMTP id S264594AbTK3CAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 21:00:07 -0500
Date: Sun, 30 Nov 2003 04:00:06 +0200
From: Ville Hallivuori <vph@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Gameport in cmpci (2.4.23)
Message-ID: <20031130020006.GA1199@vph.iki.fi>
Reply-To: vph@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone managed to get gameport to work in cmpci driver with 2.4.23
kernel? Upgrade from 2.4.22 broke it for me (using cmpci with CM8738
integrated on Soyo Dragon mother board).

With kernels <2.4.23 one would use ns558 to provide game port (cmpci
only enable joystick support). However in 2.4.23 cmpci provides game
port support directly. This new support does not appear to be working.

The major difference between cmpci and ns558 is that cmpci assumes IO
port 0x200 while ns558 probes quite many ports. In my case the port is
0x201, not 0x200 as hard-coded in the driver.

If 201 is valid port for all chips supported by cmpci, the patch below
should fix the issue:

--- cmpci.c.old Fri Nov 28 20:26:20 2003
+++ cmpci.c     Sun Nov 30 03:16:22 2003
@@ -3354,7 +3354,7 @@
 #endif
        s->iosynth = fmio;
        s->iomidi = mpuio;
-       s->gameport.io = 0x200;
+       s->gameport.io = 0x201;
        s->status = 0;
        /* range check */
        if (speakers < 2)

If the io port is not fixed, perhaps probing mechanism from ns558
could be copied to cmpci...

As I do not have specs for CM8738 I can not quess how large the IO port
should be. With the above fix game port works, but reserved io port is
8 bytes long (vs 1 byte with ns558). Someone with more familiarity to
CM87738 might wish to change this...

-- 
[Ville Hallivuori][vph@iki.fi][http://www.iki.fi/vph/]
[ID 8E1AD461][FP16=C9 50 E2 DF 48 F6 33 62  5D 87 47 9D 3F 2B 07 5D]
[ID 58543419][FP20=8731 941D 15AB D4A0 88A0  FC8F B55C F4C4 5854 3419]
[ID 8061C24E][FP20=C722 12DA 841E D811 DBFE  2FB3 174C E291 8061 C24E]
 LocalWords:  Ville Hallivuori
