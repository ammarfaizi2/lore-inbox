Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265235AbUEMW6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265235AbUEMW6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 18:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265239AbUEMW6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 18:58:55 -0400
Received: from gate.crashing.org ([63.228.1.57]:31880 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265235AbUEMW6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 18:58:52 -0400
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040513151549.GB31123@wohnheim.fh-wedel.de>
References: <20040513134847.GA2024@dreamland.darkstar.lan>
	 <20040513145640.GA3430@dreamland.darkstar.lan>
	 <20040513151549.GB31123@wohnheim.fh-wedel.de>
Content-Type: text/plain
Message-Id: <1084488980.1935.119.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 14 May 2004 08:56:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> --- linux-2.6/drivers/video/aty/radeon_base.c~	2004-05-13 16:51:08.000000000 +0200
> +++ linux-2.6/drivers/video/aty/radeon_base.c	2004-05-13 16:55:09.000000000 +0200
> @@ -1397,7 +1397,7 @@
>  {
>  	struct radeonfb_info *rinfo = info->par;
>  	struct fb_var_screeninfo *mode = &info->var;
> -	struct radeon_regs newmode;
> +	static struct radeon_regs newmode;
>  	int hTotal, vTotal, hSyncStart, hSyncEnd,
>  	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
>  	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
> 
> I'm not sure what the point behind the radeon_write_mode() is at all.
> The best solution could be to just merge radeon_write_mode() and
> radeonfb_set_par() into a single function and do the tons of OUTREG()
> directly.  In that case, don't bother to fix any typos

No, they should stay separate functions. I may use write_mode in a
different way in the future (like restoring previous mode on module
unload for example) and I'm very much against merging 2 already too big
function into one huge horror.

Ben.
 

