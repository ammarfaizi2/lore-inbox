Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVCGVZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVCGVZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVCGVYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:24:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56728 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261755AbVCGU21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:28:27 -0500
Date: Sun, 6 Mar 2005 17:51:14 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: dahinds@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.30-pre2] fix undefined behaviour in cistpl.c
Message-ID: <20050306205114.GA2543@logos.cnet>
References: <200503051517.j25FHI2U001419@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503051517.j25FHI2U001419@harpo.it.uu.se>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 04:17:18PM +0100, Mikael Pettersson wrote:
> Compiling drivers/pcmcia/cistpl.c with gcc-4.0 generates this warning:
> 
> cistpl.c: In function 'read_cis_mem':
> cistpl.c:143: warning: 'sys' is used uninitialized in this function
> 
> Note 'is' not 'may be'. And there is indeed a control flow path in
> which 'sys' is updated with '+=' even though it has no initial value.
> Luckily 'sys' is reassigned later before being used, making this
> assignment redundant, so the fix is to simply remove it.

Indeed - applied, thanks Mikael.

> This problem is not present in the 2.6 kernel.
> 
> Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>
> 
> --- linux-2.4.30-pre2/drivers/pcmcia/cistpl.c.~1~	2004-02-18 15:16:23.000000000 +0100
> +++ linux-2.4.30-pre2/drivers/pcmcia/cistpl.c	2005-03-05 15:51:37.000000000 +0100
> @@ -140,7 +140,6 @@ int read_cis_mem(socket_info_t *s, int a
>      } else {
>  	u_int inc = 1;
>  	if (attr) { mem->flags |= MAP_ATTRIB; inc++; addr *= 2; }
> -	sys += (addr & (s->cap.map_size-1));
>  	mem->card_start = addr & ~(s->cap.map_size-1);
>  	while (len) {
>  	    set_cis_map(s, mem);
