Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266353AbUAHX0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUAHX0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:26:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24837 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266353AbUAHX0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:26:24 -0500
Date: Thu, 8 Jan 2004 23:26:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New FBDev patch
Message-ID: <20040108232621.B25760@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0401082108080.12797-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Thu, Jan 08, 2004 at 10:03:54PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 10:03:54PM +0000, James Simmons wrote:
> This is the latest patch against 2.6.0-rc3. Give it a try.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

This looks wrong (cyber2000fb.c):

@@ -1220,18 +1220,18 @@
 }

 static struct cfb_info * __devinit
-cyberpro_alloc_fb_info(unsigned int id, char *name)
+cyberpro_alloc_fb_info(unsigned int id, char *name, struct device *dev)
 {
        struct cfb_info *cfb;
+       struct fb_info *fb_info;

-       cfb = kmalloc(sizeof(struct cfb_info) +
-                      sizeof(u32) * 16, GFP_KERNEL);
+       fb_info = framebuffer_alloc(sizeof(struct cfb_info) + 32 * 16, dev);

sizeof(u32) != 32.  Proper fix is to place the pseudopalette array
inside cfb_info, and dispense with this addition here.

I could supply a patch, but I'll wait for this to be merged before
I fix this up.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
