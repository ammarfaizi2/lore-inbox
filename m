Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264687AbTFEOME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 10:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264689AbTFEOME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 10:12:04 -0400
Received: from franka.aracnet.com ([216.99.193.44]:4542 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264687AbTFEOMC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 10:12:02 -0400
Date: Thu, 05 Jun 2003 07:25:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 777] New: vesafb fails to initalize 1GB system memory and 128MB video memory 
Message-ID: <8580000.1054823126@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: vesafb fails to initalize 1GB system memory and 128MB
                    video memory
    Kernel Version: 2.5.63 - Current
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: crude@copymat.net
                CC: crude@copymat.net


Distribution: 
Gentoo Linux 1.4 profile w/ ARCH=~x86 
Hardware Environment: 
2xAthlon MP 1900+,Tyan 2462 (AMD 760MP), 1GB memory, VisionTek Gforce 4 Ti4600(128 
MB) 
Software Environment: 
GCC 3.2.3, Glibc 2.3.2 
Problem Description: 
trying to use vesafb, and get blank screen (system boots normaly w/ exception of no 
frambuffer) has something to do with failing to allopcate memory (ioremap i belive) this had 
been present in 2.4 series as well, untill recently (at least in the ac sources, and 
gentoo-sources) 
 
Steps to reproduce: install 1GB of memory, and use a video card w/ 128MB memory and try 
to use frambuffered console (I have seen behaviour on more than just my card. 
 
I have ported the patch that I had used in the 2.4 series (before gentoo and ac picked it up) 
 
please be kind as I am relativly new to this, and I hope this helps (btw I have been using this 
patch since 2.5.63, w/ slight change at 2.5.67, on linus's kernel and on the mm tree, and have 
had no troubles) 
 
______________________________________________ 
diff -Naur linux-2.5.67/drivers/video/vesafb.c 
linux-2.5.67-postpatch/drivers/video/vesafb.c 
--- linux-2.5.67/drivers/video/vesafb.c 2003-04-16 13:29:54.000000000 -0500 
+++ linux-2.5.67-postpatch/drivers/video/vesafb.c       2003-04-09 14:52:46.000000000 -0500 
@@ -225,7 +225,7 @@ 
        vesafb_defined.xres = screen_info.lfb_width; 
        vesafb_defined.yres = screen_info.lfb_height; 
        vesafb_fix.line_length = screen_info.lfb_linelength; 
-       vesafb_fix.smem_len = screen_info.lfb_size * 65536; 
+       vesafb_fix.smem_len = screen_info.lfb_width * screen_info.lfb_height * 
vesafb_defined.bits_per_pixel / 8; 
        vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ? 
                FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR; 
 
________________________________________________ 
 
please let me know what I can do better to make this easier on you.... 
 
Thanks for all your hard work, the 2.6 kernel is going to turn a lot of heads, been nothing but 
impressed with the developmental branch

