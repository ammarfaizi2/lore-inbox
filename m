Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUJAUXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUJAUXw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUJAUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:23:36 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:51353 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S266460AbUJAUW0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:22:26 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] vesafb memory size mismatch
Date: Sat, 2 Oct 2004 04:22:14 +0800
User-Agent: KMail/1.5.4
References: <20041001153624.267a808b@homer.gnuage.org> <87acv6l9ru.fsf@bytesex.org>
In-Reply-To: <87acv6l9ru.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410020422.15936.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 October 2004 23:48, Gerd Knorr wrote:
> +	/*   size_vmode -- that is the amount of memory needed for the
> +	 *                 used video mode, i.e. the minimum amount of
> +	 *                 memory we need. */
> +	size_vmode = (vesafb_defined.xres * vesafb_defined.yres *
> +		vesafb_defined.bits_per_pixel) >> 3;
> +
> +	/*   size_total -- all video memory we have. Used for mtrr
> +	 *                 entries and bounds checking. */
> +	size_total = screen_info.lfb_size * 65536;
> +	if (size_total < size_vmode)
> +		size_total = size_vmode;
> +	if (vram)
> +		size_total = vram * 1024 * 1024;
> +
> +	/*   size_remap -- the amount of video memory we are going to
> +	 *                 use for vesafb.  With modern cards it is no
> +	 *                 option to simply use size_total as that
> +	 *                 wastes plenty of kernel address space. */
> +	size_remap  = size_vmode * 2;
> +	if (size_remap > size_total)
> +		size_remap = size_total;
> +	vesafb_fix.smem_len = size_remap;

Probably a typo, but shouldn't it be...

size_remap = size_vmode * 2;
if (vram)
	size_remap = vram * 1024 * 1024;
if (size_remap > size_total)
	size_remap = size_total

... so vram doesn't mess up with mtrr and user and fbcon can multibuffer
> size_vmode?

Tony  


