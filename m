Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262627AbTCNVhv>; Fri, 14 Mar 2003 16:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263509AbTCNVhv>; Fri, 14 Mar 2003 16:37:51 -0500
Received: from rj.sgi.com ([192.82.208.96]:53901 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S262627AbTCNVhu>;
	Fri, 14 Mar 2003 16:37:50 -0500
Date: Fri, 14 Mar 2003 13:48:27 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] small fix for aty128fb support on ia64
Message-ID: <20030314214827.GC1037@sgi.com>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0303081540090.8221-100000@vervain.sonytel.be> <Pine.LNX.4.44.0303081510380.28479-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303081510380.28479-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a patch I had to use on ia64.  The framebuffer worked nicely,
but it looks like X doesn't restore the state correctly when I switch
back to an fb console, so I just got a blank screen.

Maybe you can think of a better way to address the #ifdef issue, it
certainly looks bad...

Thanks,
Jesse


--- linux-2.5.64-ia64-sn/drivers/video/aty128fb.c	Tue Mar  4 19:29:18 2003
+++ linux-2.5.64-ia64/drivers/video/aty128fb.c	Fri Mar 14 12:12:19 2003
@@ -1448,7 +1448,10 @@
 			}
 		}
 #endif /* CONFIG_ALL_PPC */
+#if defined(CONFIG_PMAC_PBOOK) || defined(CONFIG_MTRR) || \
+    defined(CONFIG_ALL_PPC)
 		else
+#endif /* this is getting ugly */
 			mode_option = this_opt;
 	}
 	return 0;
@@ -1709,7 +1712,7 @@
 					"Guessing...\n");
 	else {
 		printk(KERN_INFO "aty128fb: Rage128 BIOS located at "
-				"segment %4.4X\n", (unsigned int)bios_seg);
+				"segment %4.4lX\n", (unsigned long)bios_seg);
 		aty128_get_pllinfo(par, bios_seg);
 	}
 #endif
