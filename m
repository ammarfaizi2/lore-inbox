Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265639AbUBPQTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUBPQT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:19:29 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:10206 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S265639AbUBPQT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:19:27 -0500
Date: Mon, 16 Feb 2004 16:17:00 +0000
From: Dave Jones <davej@redhat.com>
To: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel-smp on i386, too many arguments to function `aty128_find_mem_vbios'
Message-ID: <20040216161700.GA27470@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Olaf Hering <olh@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org
References: <20040216092350.GA23211@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040216092350.GA23211@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 10:23:50AM +0100, Olaf Hering wrote:
 > 
 >   CC [M]  drivers/video/aty/radeon_base.o
 > drivers/video/aty/radeon_base.c: In function `radeon_screen_blank':
 > drivers/video/aty/radeon_base.c:945: warning: `val2' might be used uninitialized in this function
 > drivers/video/aty/radeon_base.c: In function `radeonfb_setcolreg':
 > drivers/video/aty/radeon_base.c:1026: warning: `vclk_cntl' might be used uninitialized in this function
 > drivers/video/aty/radeon_base.c: In function `radeonfb_set_par':
 > drivers/video/aty/radeon_base.c:1320: warning: `pll_output_freq' might be used uninitialized in this function
 >   CC [M]  drivers/video/aty/radeon_pm.o
 >   CC [M]  drivers/video/aty/radeon_monitor.o
 > drivers/video/aty/radeon_monitor.c: In function `radeon_match_mode':
 > drivers/video/aty/radeon_monitor.c:865: warning: passing arg 1 of `fb_validate_mode' discards qualifiers from pointer target type
 >   CC [M]  drivers/video/aty/radeon_accel.o
 >   CC [M]  drivers/video/aty/radeon_i2c.o
 >   LD [M]  drivers/video/aty/atyfb.o
 >   CC [M]  drivers/video/aty/aty128fb.o
 > drivers/video/aty/aty128fb.c: In function `aty128_probe':
 > drivers/video/aty/aty128fb.c:1955: error: too many arguments to function `aty128_find_mem_vbios'
 > make[3]: *** [drivers/video/aty/aty128fb.o] Error 1
 > make[2]: *** [drivers/video/aty] Error 2
 > make[1]: *** [drivers/video] Error 2
 > make: *** [drivers] Error 2


Looks straightforward enough...

		Dave

 
--- linux-2.6.2/drivers/video/aty/aty128fb.c~	2004-02-16 14:39:19.000000000 +0000
+++ linux-2.6.2/drivers/video/aty/aty128fb.c	2004-02-16 14:40:25.000000000 +0000
@@ -1952,7 +1952,7 @@
 	bios = aty128_map_ROM(par, pdev);
 #ifdef __i386__
 	if (bios == NULL)
-		bios = aty128_find_mem_vbios(par, pdev);
+		bios = aty128_find_mem_vbios(par);
 #endif
 	if (bios == NULL)
 		printk(KERN_INFO "aty128fb: BIOS not located, guessing timings.\n");
