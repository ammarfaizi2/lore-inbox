Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264275AbUEMQDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbUEMQDH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 12:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUEMQDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 12:03:06 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:58557 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264275AbUEMQDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 12:03:03 -0400
Date: Thu, 13 May 2004 18:02:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Valdis.Kletnieks@vt.edu
Cc: Kronos <kronos@kronoz.cjb.net>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040513160234.GC31123@wohnheim.fh-wedel.de>
References: <20040513134847.GA2024@dreamland.darkstar.lan> <20040513145640.GA3430@dreamland.darkstar.lan> <20040513151549.GB31123@wohnheim.fh-wedel.de> <200405131536.i4DFaaSE017433@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200405131536.i4DFaaSE017433@turing-police.cc.vt.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 11:36:36 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 13 May 2004 17:15:49 +0200, =?iso-8859-1?Q?J=F6rn?= Engel said:
> 
> > Even quicker fix:
> > 
> > --- linux-2.6/drivers/video/aty/radeon_base.c~	2004-05-13 16:51:08.000
> 000000 +0200
> > +++ linux-2.6/drivers/video/aty/radeon_base.c	2004-05-13 16:55:09.000000000 +
> 0200
> > @@ -1397,7 +1397,7 @@
> >  {
> >  	struct radeonfb_info *rinfo = info->par;
> >  	struct fb_var_screeninfo *mode = &info->var;
> > -	struct radeon_regs newmode;
> > +	static struct radeon_regs newmode;
> >  	int hTotal, vTotal, hSyncStart, hSyncEnd,
> >  	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
> >  	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
> 
> Is that racy if you have more than one graphics card installed?

Could be.  It's a quick hack, just like the kmalloc() variant.  For
the solution, see my previous mail.

Jörn

-- 
I can say that I spend most of my time fixing bugs even if I have lots
of new features to implement in mind, but I give bugs more priority.
-- Andrea Arcangeli, 2000
