Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWH0IoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWH0IoN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWH0IoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:44:13 -0400
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:19208 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750918AbWH0IoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:44:11 -0400
Date: Sun, 27 Aug 2006 10:44:15 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, i2c@lm-sensors.org
Subject: Re: [-mm patch] struct i2c_algo_pcf_data: remove the mdelay member
Message-Id: <20060827104415.159a8726.khali@linux-fr.org>
In-Reply-To: <20060827024702.GP4765@stusta.de>
References: <20060826160922.3324a707.akpm@osdl.org>
	<20060827024702.GP4765@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> On Sat, Aug 26, 2006 at 04:09:22PM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.18-rc4-mm2:
> >...
> > +gregkh-i2c-i2c-algo-bit-kill-mdelay.patch
> >...
> >  I2C tree updates
> >...
> 
> This patch also removes the only usage of the mdelay member in 
> struct i2c_algo_pcf_data, but doesn't remove the struct member itself.
> 
> Is seems this patch was also intended?
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.18-rc4-mm3/include/linux/i2c-algo-pcf.h.old	2006-08-27 04:01:35.000000000 +0200
> +++ linux-2.6.18-rc4-mm3/include/linux/i2c-algo-pcf.h	2006-08-27 04:01:40.000000000 +0200
> @@ -35,7 +35,6 @@ struct i2c_algo_pcf_data {
>  
>  	/* local settings */
>  	int udelay;
> -	int mdelay;
>  	int timeout;
>  };

I removed mdelay from i2c-elektor thinking that it was using
i2c-algo-bit, I didn't realize it was using a different i2c algorithm.
And I didn't know i2c-algo-pcf also had an unused mdelay.

I will send an updated i2c-algo-bit-kill-mdelay.patch to Greg which
doesn't affect i2c-elektor. Then we can stack a second patch doing the
same for i2c-algo-pcf, which will include your change above, and my
change to i2c-elektor.

I agree it doesn't matter much, in the end we end up removing
everything and it was dead code anyway, but let's still have clean
separate patches doing just one thing at a time.

I just found that i2c-algo-ite has the same unused mdelay member in its
algorithm data structure... But I wouldn't bother cleaning it up, given
that it is planed for removal next month anyway.

Thanks,
-- 
Jean Delvare
