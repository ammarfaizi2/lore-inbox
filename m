Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290810AbSARUm5>; Fri, 18 Jan 2002 15:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290815AbSARUms>; Fri, 18 Jan 2002 15:42:48 -0500
Received: from mta3n.bluewin.ch ([195.186.1.212]:55251 "EHLO mta3n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S290810AbSARUma>;
	Fri, 18 Jan 2002 15:42:30 -0500
Message-ID: <3C4887F4.6B410959@bluewin.ch>
Date: Fri, 18 Jan 2002 21:39:16 +0100
From: Nicolas Aspert <Nicolas.Aspert@bluewin.ch>
Reply-To: Nicolas.Aspert@epfl.ch
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Didier Moens <moensd@xs4all.be>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOPS in APM 2.4.18-pre4 with i830MP agpgart
In-Reply-To: <3C487E68.1000404@xs4all.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again

Here is a small patch (against 2.4.18-pre2 since I don't have the latest
18-pre at hand) that should fix your the problem. It may not apply
cleanly but that's all I can do at the moment.
Sorry again for my mistake.

Best regards

Nicolas.

--- agpgart_be.c        Fri Jan 18 21:37:43 2002
+++ agpgart_be.c_correct        Fri Jan 18 21:39:02 2002
@@ -1400,7 +1400,6 @@
        agp_bridge.free_by_type = intel_i810_free_by_type;
        agp_bridge.agp_alloc_page = agp_generic_alloc_page;
        agp_bridge.agp_destroy_page = agp_generic_destroy_page;
-
        agp_bridge.suspend = agp_generic_suspend;
        agp_bridge.resume = agp_generic_resume;
        agp_bridge.cant_use_aperture = 0;
@@ -1857,7 +1856,10 @@
        agp_bridge.free_by_type = agp_generic_free_by_type;
        agp_bridge.agp_alloc_page = agp_generic_alloc_page;
        agp_bridge.agp_destroy_page = agp_generic_destroy_page;
-
+       agp_bridge.suspend = agp_generic_suspend;
+       agp_bridge.resume = agp_generic_resume;
+       agp_bridge.cant_use_aperture = 0;
+
        return 0;
 
        (void) pdev; /* unused */
@@ -1887,7 +1889,9 @@
        agp_bridge.free_by_type = agp_generic_free_by_type;
        agp_bridge.agp_alloc_page = agp_generic_alloc_page;
        agp_bridge.agp_destroy_page = agp_generic_destroy_page;
-
+       agp_bridge.suspend = agp_generic_suspend;
+       agp_bridge.resume = agp_generic_resume;
+       agp_bridge.cant_use_aperture = 0;
        return 0;
 
        (void) pdev; /* unused */
