Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269209AbUIBWjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269209AbUIBWjl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269169AbUIBWj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:39:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:6817 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269156AbUIBWi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:38:27 -0400
Date: Thu, 2 Sep 2004 15:36:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: janitor@sternwelten.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 11/14]  radio/radio-zoltrix: replace 	sleep_delay() with
 schedule()
Message-Id: <20040902153630.60ce9e72.akpm@osdl.org>
In-Reply-To: <E1C2eLH-0002rZ-CX@sputnik>
References: <E1C2eLH-0002rZ-CX@sputnik>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

janitor@sternwelten.at wrote:
>
> diff -puN drivers/media/radio/radio-zoltrix.c~msleep-drivers_media_radio-zoltrix drivers/media/radio/radio-zoltrix.c
>  --- linux-2.6.9-rc1-bk7/drivers/media/radio/radio-zoltrix.c~msleep-drivers_media_radio-zoltrix	2004-09-01 19:35:14.000000000 +0200
>  +++ linux-2.6.9-rc1-bk7-max/drivers/media/radio/radio-zoltrix.c	2004-09-01 19:35:14.000000000 +0200
>  @@ -54,12 +54,6 @@ struct zol_device {
>   
>   /* local things */
>   
>  -static void sleep_delay(void)
>  -{
>  -	/* Sleep nicely for +/- 10 mS */
>  -	schedule();
>  -}
>  -
>   static int zol_setvol(struct zol_device *dev, int vol)
>   {
>   	dev->curvol = vol;
>  @@ -76,7 +70,7 @@ static int zol_setvol(struct zol_device 
>   	}
>   
>   	outb(dev->curvol-1, io);
>  -	sleep_delay();
>  +	schedule();

I'm inclined to leave this one as-is.  If this driver really wants
to sleep to 10ms then it should do so, rather than doing that
pointless schedule().
