Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293554AbSCHLHP>; Fri, 8 Mar 2002 06:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310808AbSCHLHG>; Fri, 8 Mar 2002 06:07:06 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:14235 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S293554AbSCHLGy>; Fri, 8 Mar 2002 06:06:54 -0500
Date: Fri, 8 Mar 2002 12:06:53 +0100
From: bert hubert <ahu@ds9a.nl>
To: tw@webit.com
Cc: linux-kernel@vger.kernel.org
Subject: new sisfb driver 2.5.6 compile fix
Message-ID: <20020308120653.A28906@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, tw@webit.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas, 

This patch makes your most recent work (as found on
http://www.webit.at/~twinny/linuxsis630.shtml) compile & work on 2.5.6.

Regards,

bert


diff -urBb sis-orig/sis_main.c sis/sis_main.c
--- sis-orig/sis_main.c	Wed Mar  6 19:47:21 2002
+++ sis/sis_main.c	Fri Mar  8 11:09:58 2002
@@ -2286,7 +2286,7 @@
 	if (boot_cpu_data.x86 > 3)
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 #endif
-	if (io_remap_page_range(vma->vm_start, off, vma->vm_end - vma->vm_start,
+	if (io_remap_page_range(vma, vma->vm_start, off, vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) 
 		return -EAGAIN;
 	return 0;
@@ -2994,7 +2994,7 @@
 		sisfb_crtc_to_var(&default_var);
 
 		fb_info.changevar = NULL;
-		fb_info.node = -1;
+		fb_info.node = NODEV;
 		fb_info.fbops = &sisfb_ops;
 		fb_info.disp = &disp;
 		fb_info.switch_con = &sisfb_switch;

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
