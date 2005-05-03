Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVECAlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVECAlO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 20:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVECAlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 20:41:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44306 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261264AbVECAkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 20:40:08 -0400
Date: Tue, 3 May 2005 02:39:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ak@muc.de, hch@lst.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [2.6 patch] {,un}register_ioctl32_conversion should have been removed last month
Message-ID: <20050503003959.GQ3592@stusta.de>
References: <20050502014550.GG3592@stusta.de> <20050502173052.5c78ae30.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502173052.5c78ae30.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 05:30:52PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > This removal should have happened last month.
> 
> drivers/usb/misc/sisusbvga/sisusb.c will use these functions if someone
> defines SISUSB_OLD_CONFIG_COMPAT, so we need to agree to zap that code
> before I can merge this upstream.


That's not a problem.


Quoting drivers/usb/misc/sisusbvga/sisusb.h:

#ifdef CONFIG_COMPAT
#if LINUX_VERSION_CODE <= KERNEL_VERSION(2,6,10)
#include <linux/ioctl32.h>
#define SISUSB_OLD_CONFIG_COMPAT
#else
#define SISUSB_NEW_CONFIG_COMPAT
#endif
#endif


I decided not to drop the SISUSB_OLD_CONFIG_COMPAT code in my patch 
because it seems Thomas is sharing this code between different kernel 
versions, and a removal might make his life harder for no big win.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

