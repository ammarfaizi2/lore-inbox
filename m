Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267026AbUBMSpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 13:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267174AbUBMSpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 13:45:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:19721 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267026AbUBMSow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 13:44:52 -0500
Date: Fri, 13 Feb 2004 18:44:49 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbdev driver and sysfs question.
In-Reply-To: <20040211225724.GN21151@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0402131839040.17669-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	if (!info->screen_base) {
> >  		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
> >  		printk(KERN_ERR
> >  		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
> 
> 	Who will free info?
...
> 	Who will undo allocations?  BTW, that applies to the old code too -
> even if fb_alloc_cmap() doesn't require any actions on cleanup, ioremap()
> definitely does.

release_fb_info in fbsysfs.c. That happens in the struct class release 
function. Also the fb_dealloc_cmap is called. No ioremap is called tho 
since this is driver specific. So I have the ioremap and cleanup of it 
done in the dev.remove function. 

This makes sense since we could have one driver for the hardware with 
multiple framebuffers on board. One driver and two devices. 




