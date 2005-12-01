Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVLATrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVLATrp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 14:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVLATrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 14:47:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:41640 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932419AbVLATro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 14:47:44 -0500
Date: Thu, 1 Dec 2005 20:46:37 +0100
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: mchehab@brturbo.com.br, video4linux-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/media/video/: make code static
Message-ID: <20051201194637.GA2306@suse.de>
References: <20051120024432.GV16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051120024432.GV16060@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Nov 20, Adrian Bunk wrote:

>  drivers/media/video/cx25840/cx25840-core.c |    4 ++--

> --- linux-2.6.15-rc1-mm2-full/drivers/media/video/cx25840/cx25840-core.c.old	2005-11-20 02:55:12.000000000 +0100
> +++ linux-2.6.15-rc1-mm2-full/drivers/media/video/cx25840/cx25840-core.c	2005-11-20 02:55:23.000000000 +0100
> @@ -714,7 +714,7 @@
>  
>  /* ----------------------------------------------------------------------- */
>  
> -struct i2c_driver i2c_driver_cx25840;
> +static struct i2c_driver i2c_driver_cx25840;
>  
>  static int cx25840_detect_client(struct i2c_adapter *adapter, int address,
>  				 int kind)
> @@ -807,7 +807,7 @@
>  
>  /* ----------------------------------------------------------------------- */
>  
> -struct i2c_driver i2c_driver_cx25840 = {
> +static struct i2c_driver i2c_driver_cx25840 = {
>  	.name = "cx25840",
>  
>  	.id = I2C_DRIVERID_CX25840,

Why does it exist twice? Once uninitalized, once intialized? Appearently
I miss the point.  I also dont find the place where ->command is called. 

There are other problems with this driver. If VIDIOC_S_STD gets passed
to cx25840_command, set_v4lstd will get a 64bit value as second arg. gcc
for ppc generates calls to __ucmpdi2, from libgcc.
Only a few archs implement this function inside the kernel. Maybe this
driver should become arm/fvr/h8300 only in 2.6.15?

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
