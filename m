Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbUDWXaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUDWXaO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUDWXaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:30:13 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:13572 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261712AbUDWXaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:30:09 -0400
Date: Sat, 24 Apr 2004 00:30:06 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Byron Stanoszek <gandalf@winds.org>
cc: marcelo@hera.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.26 Patch] Blue line in nVidia framebuffer (rivafb)
In-Reply-To: <Pine.LNX.4.58.0404141415350.12872@winds.org>
Message-ID: <Pine.LNX.4.44.0404240029550.5826-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Its in 2.6.X as well. Applied patch.


On Wed, 14 Apr 2004, Byron Stanoszek wrote:

> This patch fixes a regression since Linux 2.4.21. There is an off-by-one error
> with the vertical-blank register in the riva framebuffer driver. The error
> makes a persistent scan line (normally blue) appear on the top of the screen.
> 
> Marcelo, please include this patch in the next -pre series.
> 
> Thanks,
>  Byron
> 
> 
> --- linux-2.4.26/drivers/video/riva/fbdev.bak	Wed Apr 14 11:45:26 2004
> +++ linux-2.4.26/drivers/video/riva/fbdev.c	Wed Apr 14 14:15:22 2004
> @@ -952,7 +952,7 @@
>  	newmode.crtc[0x12] = Set8Bits (vDisplay);
>  	newmode.crtc[0x13] = ((width / 8) * ((bpp + 1) / 8)) & 0xFF;
>  	newmode.crtc[0x15] = Set8Bits (vBlankStart);
> -	newmode.crtc[0x16] = Set8Bits (vBlankEnd);
> +	newmode.crtc[0x16] = Set8Bits (vBlankEnd + 1);
> 
>  	newmode.ext.bpp = bpp;
>  	newmode.ext.width = width;
> 
> 
> 
> --
> Byron Stanoszek                         Ph: (330) 644-3059
> Systems Programmer                      Fax: (330) 644-8110
> Commercial Timesharing Inc.             Email: byron@comtime.com

