Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUESJcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUESJcQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 05:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUESJcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 05:32:16 -0400
Received: from not.theboonies.us ([66.139.79.224]:34974 "EHLO
	not.theboonies.us") by vger.kernel.org with ESMTP id S262488AbUESJcO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 05:32:14 -0400
Date: Wed, 19 May 2004 11:36:21 +0200 (CEST)
To: akpm@osdl.org
cc: Linux Frame Buffer Dev <linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: FB accel capabilities patch
Message-ID: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Delivery-Agent: TMDA/1.0.2 (Bold Forbes)
From: David Eger <eger@theboonies.us>
X-Primary-Address: random@theboonies.us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Andrew,

A month or two ago I noticed that the framebuffer console driver doesn't
know to do proper framebuffer acceleration in Linux 2.6;  I've implemented
a solution Geert suggested where each framebuffer driver advertizes its 
hardware capabilities via fb_info->flags.  Please apply to -mm so I can 
get wider testing.

The patches are at:

http://www.yak.net/random/fbdev-patches/accel-cap-take2/relative2mainline/

The core of these patches is enabling the use of the following flags:

+/* FBIF = FB_Info.Flags */
+#define FBIF_MODULE		0x0001	/* Low-level driver is a module */
+#define FBIF_HWACCEL_DISABLED	0x0002
+
+/* hints */
+#define FBIF_PARTIAL_PAN_OK	0x0040 /* otw use pan only for double-buffering */
+#define FBIF_READS_FAST		0x0080 /* soft-copy faster than rendering */
+
+/* hardware supported ops */
+#define FBIF_HWACCEL_NONE	0x0000
+#define FBIF_HWACCEL_COPYAREA	0x0100
+#define FBIF_HWACCEL_FILLRECT	0x0200
+#define FBIF_HWACCEL_ROTATE	0x0400
+#define FBIF_HWACCEL_IMAGEBLIT	0x0800
+#define FBIF_HWACCEL_XPAN	0x1000
+#define FBIF_HWACCEL_YPAN	0x2000
+#define FBIF_HWACCEL_YWRAP	0x4000

Patches to each individual driver will trickle in as I get to them;
Since these are only hints to the "application" of fbcon, the fact that 
the hints aren't yet accurate for all drivers (default is zero/one depending
on if the fb driver is a module) is OK, and nothing should break with these
patches.  Each driver also doesn't have to reimplement a noaccel flag 
(to disable acceleration, mainly for testing new accel code), since it
will be already in fb_info now ;-)

-dte

---
getting bounce messages from me? let me know and you'll go on my whitelist
