Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVJXR04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVJXR04 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVJXR04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:26:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:24502 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751185AbVJXR0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:26:55 -0400
Date: Mon, 24 Oct 2005 19:26:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: sharp zaurus c-3000: fix compile failure without CONFIG_FB_PXA
Message-ID: <20051024172639.GA30960@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes compile problem when CONFIG_FB_PXA is not set.

  LD      .tmp_vmlinux1
arch/arm/mach-pxa/built-in.o(.text+0x1d74): In function
`spitz_get_hsync_len':
: undefined reference to `pxafb_get_hsync_time'
make: *** [.tmp_vmlinux1] Error 1
3.46user 0.46system 5.10 (0m5.106s) elapsed 77.01%CPU

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/mach-pxa/corgi_lcd.c b/arch/arm/mach-pxa/corgi_lcd.c
--- a/arch/arm/mach-pxa/corgi_lcd.c
+++ b/arch/arm/mach-pxa/corgi_lcd.c
@@ -488,6 +488,7 @@ static int is_pxafb_device(struct device
 
 unsigned long spitz_get_hsync_len(void)
 {
+#ifdef CONFIG_FB_PXA
 	if (!spitz_pxafb_dev) {
 		spitz_pxafb_dev = bus_find_device(&platform_bus_type, NULL, NULL, is_pxafb_device);
 		if (!spitz_pxafb_dev)
@@ -496,6 +497,7 @@ unsigned long spitz_get_hsync_len(void)
 	if (!get_hsync_time)
 		get_hsync_time = symbol_get(pxafb_get_hsync_time);
 	if (!get_hsync_time)
+#endif
 		return 0;
 
 	return pxafb_get_hsync_time(spitz_pxafb_dev);


-- 
Thanks, Sharp!
