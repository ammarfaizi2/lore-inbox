Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbUJYBvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbUJYBvr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUJYBvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:51:47 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:6596 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261658AbUJYBvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:51:45 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Why bttv depends on FW_LOADER?
Date: Sun, 24 Oct 2004 21:51:43 -0400
User-Agent: KMail/1.7
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, kraxel@bytesex.org
References: <20041023201756.GA15560@vana.vc.cvut.cz>
In-Reply-To: <20041023201756.GA15560@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410242151.43209.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.58.180] at Sun, 24 Oct 2004 20:51:44 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 October 2004 16:17, Petr Vandrovec wrote:
>Hello,
>  what is purpose of this change in 2.6.10-rc1?  I seem to have no
>problems after removing dependency on FW_LOADER, and my hardware
>definitely does not need any firmware to work.
>
>  I also do not understand why bttv depends on I2C and selects
>I2C_ALGOBIT.  Should not it depend on I2C_ALGOBIT instead, or
>select both I2C and I2C_ALGOBIT.  Doing it this way seems rather
>strange to me.
>    Thanks,
>     Petr Vandrovec

I'll second, third, or whatever place I have in the squawk line, this 
squawk, bttv has been working just fine with the former config 
settings.  I'm on 2.6.9, but when I went to watch a little tv 
tonight, tvtime had a blue screen, saying it couldn't 
open /dev/video0.  An lsmod didn't show videodev or bttv and the 
modules do not exist in /lib/modules/2.6.9/kernel/*.  I don't have 
any firmware to load, so this patch below needs to be reverted.

>diff -Nru a/drivers/media/video/Kconfig
> b/drivers/media/video/Kconfig --- a/drivers/media/video/Kconfig    
>   2004-10-23 22:09:21 +02:00 +++ b/drivers/media/video/Kconfig     
>  2004-10-23 22:09:21 +02:00 @@ -9,7 +9,7 @@
>
> config VIDEO_BT848
>        tristate "BT848 Video For Linux"
>-       depends on VIDEO_DEV && PCI && I2C && SOUND
>+       depends on VIDEO_DEV && PCI && I2C && FW_LOADER
>        select I2C_ALGOBIT
>        ---help---
>          Support for BT848 based frame grabber/overlay boards. This
> includes

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.28% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
