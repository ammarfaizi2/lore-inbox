Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUB0SA5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUB0SA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:00:57 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:25095 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263088AbUB0SAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:00:55 -0500
Date: Fri, 27 Feb 2004 18:00:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: arief# <arief_m_utama@telkomsel.co.id>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
In-Reply-To: <1077865490.22215.217.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402271755090.2216-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you test the patch below ? :

Just a couple of things. The idea of adding another field to 
con_blank bothers me. I think the better approach is to add more flags.
 
> ===== drivers/char/vt.c 1.61 vs edited =====
> --- 1.61/drivers/char/vt.c	Thu Feb 19 14:43:03 2004
> +++ edited/drivers/char/vt.c	Fri Feb 27 17:27:09 2004
> @@ -2743,12 +2743,12 @@
>       *  Called only if powerdown features are allowed.
>       */
>      switch (vesa_blank_mode) {
> -	case VESA_NO_BLANKING:
> -	    c->vc_sw->con_blank(c, VESA_VSYNC_SUSPEND+1);
> +    case VESA_NO_BLANKING:
> +	    c->vc_sw->con_blank(c, VESA_VSYNC_SUSPEND+1, 0);

> ===== drivers/video/fbmem.c 1.90 vs edited =====
> --- 1.90/drivers/video/fbmem.c	Mon Feb 16 23:42:15 2004
> +++ edited/drivers/video/fbmem.c	Fri Feb 27 17:25:21 2004
> @@ -943,7 +943,8 @@
>  {
>  	int err;
>  
> -	if (memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
> +	if ((var->activate & FB_ACTIVATE_FORCE) ||
> +	    memcmp(&info->var, var, sizeof(struct fb_var_screeninfo))) {
>  		if (!info->fbops->fb_check_var) {
>  			*var = info->var;
>  			return 0;

Ug!!! Another flag. How about instead in fbcon.c we call set_par directly 
instead of messing with fb_set_var. 

Let me play with some ideas. I can have a another patch ready over the 
weekend. 

