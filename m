Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbTD0Ipa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 04:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263852AbTD0Ipa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 04:45:30 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61966 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263850AbTD0Ip3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 04:45:29 -0400
Date: Sun, 27 Apr 2003 10:57:11 +0200
From: Willy TARREAU <willy@w.ods.org>
To: marcelo@conectiva.com.br, vandrove@vc.cvut.cz, hch@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] was: Matrox FB problem in latest 2.4.21-rc1-BK
Message-ID: <20030427085711.GA181@pcw.home.local>
References: <20030427083232.GA171@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030427083232.GA171@pcw.home.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

OK I found it to be a typo in cset-1.1134 (intel fb fixes) which disabled CFB8.
It now works with this patch. Christoph, you might also have the typo in your
tree.

Cheers,
Willy


--- linux-2.4.21-rc1-bk1137/drivers/video/Config.in	Sun Apr 27 09:46:41 2003
+++ linux-2.4.21-rc1-fb/drivers/video/Config.in	Sun Apr 27 10:41:01 2003
@@ -299,7 +299,7 @@
 	   "$CONFIG_FB_PMAG_BA" = "y" -o "$CONFIG_FB_PMAGB_B" = "y" -o \
 	   "$CONFIG_FB_MAXINE" = "y" -o "$CONFIG_FB_TX3912" = "y" -o \
 	   "$CONFIG_FB_SIS" = "y" -o "$CONFIG_FB_NEOMAGIC" = "y" -o \
-	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" -o
+	   "$CONFIG_FB_STI" = "y" -o "$CONFIG_FB_HP300" = "y" -o \
 	   "$CONFIG_FB_INTEL" = "y" ]; then
 	 define_tristate CONFIG_FBCON_CFB8 y
       else


On Sun, Apr 27, 2003 at 10:32:32AM +0200, Willy TARREAU wrote:
> Hello,
> 
> I just compiled 2.4.21-rc1 + bk cset-1.1137, and now the Matrox framebuffer
> always starts in 640x480 mode, whatever the mode I tell it. Moreover, fbset
> returns "ioctl: FBIOPUT_VSCREENINFO: invalid argument". This is on a G400,
> and still works correctly on 2.4.21-rc1, so the problem really is within the
> latest BK changes. I don't understand, since this cset doesn't contain matrox
> changes, and no FB changes except intel's !
> 
> This is on a dual Athlon-XP 1800, Asus A7M266-D, 512 MB RAM, G400 video card.
> 
> I will try to revert changes one by one, but by the time, here is my epurated
> .config (# lines removed). I append "video=matrox:vesa:0x107" to the cmdline.
