Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbUKCAo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbUKCAo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 19:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbUKBWOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:14:03 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:3758 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262137AbUKBWKa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:10:30 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       joshk@triplehelix.org (Joshua Kwan)
Subject: Re: [Linux-fbdev-devel] Re: Problem with current fb_get_color_depth function
Date: Wed, 3 Nov 2004 06:10:12 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
References: <20041010225903.GA2418@darjeeling.triplehelix.org> <200410110832.19978.adaplas@hotpop.com> <20041102055555.GJ6361@triplehelix.org>
In-Reply-To: <20041102055555.GJ6361@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411030610.12231.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 13:55, Joshua Kwan wrote:
> [ long overdue follow-up ]
>
> On Mon, Oct 11, 2004 at 08:33:10AM +0800, Antonino A. Daplas wrote:
> > So, linux_logo_224 cannot be drawn when visual is directcolor at RGB555
> > or RGB565 because the logo clut requirements exceeds the hardware clut
> > capability. You need to use a logo image with a lower depth such as the
> > 16-color logo, linux_logo_16.
>
> This is weird, because removing that conditional from fb_get_color_depth
> allows a 224-color logo to show correctly on my Radeon framebuffer, in
> full color.
>
> Otherwise, it is dithered to kingdom come and mostly appears all orange
> and black.
>
> You may be right conceptually, but the fact of the matter is that this
> is a regression because 224-color logos work perfectly with the old
> fb_get_color_depth. So what is the real problem?
>

After giving it a lot of thought, perhaps you are not booting at 16 bpp, but
at 8bpp pseudocolor.  However, radeonfb's default var use only a red, green,
and blue length of 6.  Try this patch and let me know if it helps.

Tony

diff -Nru a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
--- a/drivers/video/aty/radeon_monitor.c	2004-10-27 14:58:07 +08:00
+++ b/drivers/video/aty/radeon_monitor.c	2004-10-28 06:04:32 +08:00
@@ -12,9 +12,9 @@
 	.xres_virtual	= 640,
 	.yres_virtual	= 480,
 	.bits_per_pixel = 8,
-	.red		= { 0, 6, 0 },
-	.green		= { 0, 6, 0 },
-	.blue		= { 0, 6, 0 },
+	.red		= { 0, 8, 0 },
+	.green		= { 0, 8, 0 },
+	.blue		= { 0, 8, 0 },
 	.activate	= FB_ACTIVATE_NOW,
 	.height		= -1,
 	.width		= -1,


