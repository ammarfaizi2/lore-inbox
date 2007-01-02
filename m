Return-Path: <linux-kernel-owner+w=401wt.eu-S1755078AbXABCg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbXABCg2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 21:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbXABCg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 21:36:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:34306 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755040AbXABCg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 21:36:27 -0500
Date: Mon, 1 Jan 2007 18:36:24 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: linux-ide@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] cdrom: longer timeout for "Read Track Info" command
Message-ID: <20070102023623.GA3108@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a DVD combo drive and a CD in which the
"READ TRACK INFORMATION" command (implemented in the
cdrom_get_track_info() function) takes about 7 seconds to run.
The current implementation of cdrom_get_track_info() uses the
default timeout of 5 seconds.  So here's a patch that increases
the timeout from 5 to 15 seconds.

The drive in question is a TSSTcorpCD/DVDW SN-S082D, and I have
a Silicon Image 680A adapter, in case that's of interest.

signed-off-by: <jeremy@sgi.com>

diff -ur linux-2.6.20-rc3_ORIG/drivers/cdrom/cdrom.c linux-2.6.20-rc3/drivers/cdrom/cdrom.c
--- linux-2.6.20-rc3_ORIG/drivers/cdrom/cdrom.c	2006-12-31 16:53:20.000000000 -0800
+++ linux-2.6.20-rc3/drivers/cdrom/cdrom.c	2007-01-01 18:13:50.135173456 -0800
@@ -3094,6 +3094,7 @@
 	cgc.cmd[5] = track & 0xff;
 	cgc.cmd[8] = 8;
 	cgc.quiet = 1;
+	cgc.timeout = 15*HZ;
 
 	if ((ret = cdo->generic_packet(cdi, &cgc)))
 		return ret;
