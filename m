Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267556AbUJIXkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267556AbUJIXkd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 19:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUJIXkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 19:40:33 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57608 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S267556AbUJIXka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 19:40:30 -0400
Date: Sun, 10 Oct 2004 01:36:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michel Angelo da Silva Pereira <michel@michel.eti.br>
Cc: linux-kernel@vger.kernel.org, Denis Oliver Kropp <dok@directfb.org>,
       jsimmons@infradead.org, geert@linux-m68k.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: drivers/built-in.o(.text+0x1411f): In function `neo_scan_monitor
Message-ID: <20041009233641.GB3727@stusta.de>
References: <415B2974.2020208@michel.eti.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <415B2974.2020208@michel.eti.br>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 06:30:28PM -0300, Michel Angelo da Silva Pereira wrote:

> 	I'm getting this error on compiling 2.6.9-rc2 with FrameBuffer 
> 	support for my ThinkPad.
> 	01:00.0 VGA compatible controller: Neomagic Corporation NM2200 
> 	[MagicGraph 256AV] (rev 20)
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0x1411f): In function `neo_scan_monitor':
> : undefined reference to `vesa_modes'
> drivers/built-in.o(.text+0x141bf): In function `neo_scan_monitor':
> : undefined reference to `vesa_modes'
> drivers/built-in.o(.text+0x1420b): In function `neo_scan_monitor':
> : undefined reference to `vesa_modes'
> make: ** [.tmp_vmlinux1] Erro 1
> root@nerdbook:/usr/src/linux#


Thanks for this report!

This is a bug still present in both 2.6.9-rc3 and 2.6.9-rc3-mm3.

The following patch should fix it:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9-rc3-mm3/drivers/video/Kconfig.old	2004-10-10 01:31:52.000000000 +0200
+++ linux-2.6.9-rc3-mm3/drivers/video/Kconfig	2004-10-10 01:32:26.000000000 +0200
@@ -793,6 +793,7 @@
 config FB_NEOMAGIC
 	tristate "NeoMagic display support"
 	depends on FB && PCI
+	select FB_MODE_HELPERS
 	help
 	  This driver supports notebooks with NeoMagic PCI chips.
 	  Say Y if you have such a graphics card. 


