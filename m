Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWA2Omk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWA2Omk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 09:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbWA2Omk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 09:42:40 -0500
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:8840 "EHLO
	gw03.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S1751012AbWA2Omj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 09:42:39 -0500
Date: Sun, 29 Jan 2006 16:42:28 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Ingo Oeser <ioe-lkml@rameria.de>,
       linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       benh@kernel.crashing.org, linux-kernel@hansmi.ch
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev: Fix usage of blank value passed to fb_blank
Message-ID: <20060129144228.GA22425@sci.fi>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>, Ingo Oeser <ioe-lkml@rameria.de>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, benh@kernel.crashing.org,
	linux-kernel@hansmi.ch
References: <20060127231314.GA28324@hansmi.ch> <20060127.204645.96477793.davem@davemloft.net> <43DB0839.6010703@gmail.com> <200601282106.21664.ioe-lkml@rameria.de> <43DC25EB.1040005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DC25EB.1040005@gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 10:18:19AM +0800, Antonino A. Daplas wrote:
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index d2dede6..5bed0fb 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -843,6 +843,19 @@ fb_blank(struct fb_info *info, int blank
>  {	
>   	int ret = -EINVAL;
>  
> +	/*
> +	 * The framebuffer core supports 5 blanking levels (FB_BLANK), whereas
> +	 * VESA defined only 4.  The extra level, FB_BLANK_NORMAL, is a
> +	 * console invention and is not related to power management.
> +	 * Unfortunately, fb_blank callers, especially X, pass VESA constants
> +	 * leading to undefined behavior.

Since when? X.Org uses numbers 0,2,3,4 which match the FB_BLANK 
constants not the VESA constants.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/
