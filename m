Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUIWFXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUIWFXy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 01:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268285AbUIWFXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 01:23:54 -0400
Received: from webmail-outgoing.us4.outblaze.com ([205.158.62.67]:31108 "EHLO
	webmail-outgoing.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S268283AbUIWFXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 01:23:40 -0400
X-OB-Received: from unknown (205.158.62.148)
  by wfilter.us4.outblaze.com; 23 Sep 2004 05:23:38 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Frank Phillips" <fphillips@linuxmail.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Date: Thu, 23 Sep 2004 08:23:38 +0300
Subject: Re: 2.6.9-rc2-mm2 vs glxgears
X-Originating-Ip: 68.114.204.194
X-Originating-Server: ws5-6.us4.outblaze.com
Message-Id: <20040923052338.C1D0C21B32F@ws5-6.us4.outblaze.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I don't know why your FPS would be decreasing like that, but as for
the 9FPS - radeon, right? Look for this line in Xorg.0.log:

(EE) RADEON(0): [pci] Out of memory (-1007)

this is an easy fix:

===== linux/drm_scatter.h 1.6 vs edited =====
--- 1.6/linux/drm_scatter.h     Sun Sep  5 21:22:06 2004
+++ edited/linux/drm_scatter.h  Thu Sep 16 01:11:13 2004
@@ -73,7 +73,7 @@
  
        DRM_DEBUG( "%s\n", __FUNCTION__ );
  
-       if (drm_core_check_feature(dev, DRIVER_SG))
+       if (!drm_core_check_feature(dev, DRIVER_SG))
                return -EINVAL;
  
        if ( dev->sg )


courtesy Jon Smirl. See this thread: http://marc.theaimsgroup.com/?t=109530394200002&r=1&w=2

With this I get consistent 350s on 2.6.9-rc2-mm1-VP-S1.

Frank
-- 
______________________________________________
Check out the latest SMS services @ http://www.linuxmail.org 
This allows you to send and receive SMS through your mailbox.


Powered by Outblaze
