Return-Path: <linux-kernel-owner+w=401wt.eu-S965008AbWLMPey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWLMPey (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 10:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWLMPey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 10:34:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60916 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965008AbWLMPex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 10:34:53 -0500
Date: Wed, 13 Dec 2006 14:58:26 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] Proper backlight selection for fbdev
 drivers
In-Reply-To: <20061213000029.edd9c91e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612131442440.4484@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0612071757230.949@pentafluge.infradead.org>
 <20061213000029.edd9c91e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem is the overlap of the patches 

fbdev-update-after-backlight-argument-change.diff
proper-backlight-selection-forfbdev-drivers.patch

The machine_is change is in the argument change patch. It should be in 
this patch. I can send updates of both patches.

On Wed, 13 Dec 2006, Andrew Morton wrote:

> On Thu, 7 Dec 2006 17:59:01 +0000 (GMT)
> James Simmons <jsimmons@infradead.org> wrote:
> 
> > Try this patch. This should fix any module/built-in dependencys.
> 
> drivers/video/aty/atyfb_base.c: In function 'atyfb_blank':
> drivers/video/aty/atyfb_base.c:2817: warning: implicit declaration of function 'machine_is'
> drivers/video/aty/atyfb_base.c:2817: error: 'powermac' undeclared (first use in this function)
> drivers/video/aty/atyfb_base.c:2817: error: (Each undeclared identifier is reported only once
> drivers/video/aty/atyfb_base.c:2817: error: for each function it appears in.)
> 
> This is i386 build.
> 
> #ifdef CONFIG_FB_ATY_BACKLIGHT
> 	if (machine_is(powermac) && blank > FB_BLANK_NORMAL)
> 		aty_bl_set_power(info, FB_BLANK_POWERDOWN);
> #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
> 
> It assumes that only pmacs have backlights.
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 
