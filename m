Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937805AbWLFXkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937805AbWLFXkc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937807AbWLFXkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:40:32 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55214 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937805AbWLFXkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:40:31 -0500
Date: Wed, 6 Dec 2006 15:40:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
Message-Id: <20061206154020.bdc0e09a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612052131410.14114@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
	<Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
	<20061205100140.24888a96.akpm@osdl.org>
	<Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
	<20061205114310.e85d4c7e.akpm@osdl.org>
	<Pine.LNX.4.64.0612051946280.14114@pentafluge.infradead.org>
	<20061205122057.c2b617f4.akpm@osdl.org>
	<Pine.LNX.4.64.0612052131410.14114@pentafluge.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006 21:34:16 +0000 (GMT)
James Simmons <jsimmons@infradead.org> wrote:

> Here you go. This patch places the backlight before the framebuffers. You
> will now be able to select using the backlight with various framebuffer 
> drivers.

This doesn't work right for me.  x86_64 allmodconfig enables
CONFIG_FB_ATY_BACKLIGHT but fails to enable FB_BACKLIGHT so things won't
build.

drivers/video/aty/atyfb_base.c: In function 'aty_bl_get_level_brightness':
drivers/video/aty/atyfb_base.c:2130: error: 'struct fb_info' has no member named 'bl_curve'

I'm not sure how to fix it, either.  Are things like
CONFIG_FB_ATY_BACKLIGHT _really_ supposed to be pmac-only?

menuconfig says:

 Symbol: FB_BACKLIGHT [=FB_BACKLIGHT]
	Selected by: PMAC_BACKLIGHT && (PPC || MAC) && ADB_PMU && FB=y && (BROKEN || !PPC64)
 

Surely CONFIG_FB_ATY_BACKLIGHT should depend upon FB_BACKLIGHT?

How come I have CONFIG_BACKLIGHT_CLASS_DEVICE and things like that but
CONFIG_FB_BACKLIGHT=n?

And a `make oldconfig' says

drivers/macintosh/Kconfig:126:warning: 'select' used by config symbol 'PMAC_BACKLIGHT' refer to undefined symbol 'FB_BACKLIGHT'


Here's what allmodconfig gave:

akpm2:/usr/src/25> grep BACKL .config
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_BACKLIGHT_CLASS_DEVICE=m
CONFIG_BACKLIGHT_DEVICE=y
CONFIG_FB_NVIDIA_BACKLIGHT=y
CONFIG_FB_RIVA_BACKLIGHT=y
CONFIG_FB_RADEON_BACKLIGHT=y
CONFIG_FB_ATY128_BACKLIGHT=y
CONFIG_FB_ATY_BACKLIGHT=y


Anyway, it seems all screwed up - I'll drop the patch.
