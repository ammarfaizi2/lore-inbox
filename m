Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUIQWvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUIQWvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 18:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269082AbUIQWut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 18:50:49 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:55957 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263003AbUIQWum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 18:50:42 -0400
Date: Fri, 17 Sep 2004 15:51:05 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v4l: bttv update
Message-ID: <20040917225105.GA11971@us.ibm.com>
References: <20040916091505.GA11528@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916091505.GA11528@bytesex>
X-Operating-System: Linux 2.6.8.1 (i686)
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 11:15:05AM +0200, Gerd Knorr wrote:
>   Hi,
> 
> This update for the bttv driver fixes kernel crashes when capturing
> planar yuv images.  It also added sanity checks for the bt878 risc
> code buffer sizes, adds support for a new tv card and has some minor
> code cleanups.

<snip>

> diff -up linux-2.6.9-rc2/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
> --- linux-2.6.9-rc2/drivers/media/video/bttv-driver.c	2004-09-14 10:37:08.000000000 +0200
> +++ linux/drivers/media/video/bttv-driver.c	2004-09-16 10:06:33.000000000 +0200
> @@ -1,4 +1,6 @@
>  /*
> +    $Id: bttv-driver.c,v 1.14 2004/09/15 16:15:24 kraxel Exp $
> +
>      bttv - Bt848 frame grabber driver
>      
>      Copyright (C) 1996,97,98 Ralph  Metzler <rjkm@thp.uni-koeln.de>
> @@ -743,8 +745,7 @@ static void set_pll(struct bttv *btv)
>          for (i=0; i<10; i++) {
>  		/*  Let other people run while the PLL stabilizes */
>  		vprintk(".");
> -		set_current_state(TASK_INTERRUPTIBLE);
> -		schedule_timeout(HZ/50);
> +		msleep(10);

My original patch used

msleep(20);

Is there a reason the conversion was changed?

-Nish
