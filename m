Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbUJ3Q1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbUJ3Q1J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUJ3Q1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:27:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:54220 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261216AbUJ3QZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 12:25:44 -0400
Message-ID: <4183BF5B.5000303@osdl.org>
Date: Sat, 30 Oct 2004 09:20:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: james4765@verizon.net
CC: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [KJ] [PATCH] floppy: change MODULE_PARM to module_param in	drivers/block/floppy.c
References: <20041030134246.23710.45693.84191@localhost.localdomain>
In-Reply-To: <20041030134246.23710.45693.84191@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

james4765@verizon.net wrote:
> Replace MODULE_PARM with module_param in drivers/block/floppy.c.  Compile tested.
> 
> Signed-off-by: James Nelson <james4765@gmail.com>
> 
> diff -urN --exclude='*~' linux-2.6.9-original/drivers/block/floppy.c linux-2.6.9/drivers/block/floppy.c
> --- linux-2.6.9-original/drivers/block/floppy.c	2004-10-18 17:53:22.000000000 -0400
> +++ linux-2.6.9/drivers/block/floppy.c	2004-10-30 09:16:04.856720081 -0400
> @@ -180,6 +180,7 @@
>  #include <linux/devfs_fs_kernel.h>
>  #include <linux/device.h>
>  #include <linux/buffer_head.h>	/* for invalidate_buffers() */
> +#include <linux/moduleparam.h>
>  
>  /*
>   * PS/2 floppies have much slower step rates than regular floppies.
> @@ -4623,9 +4624,9 @@
>  	wait_for_completion(&device_release);
>  }
>  
> -MODULE_PARM(floppy, "s");
> -MODULE_PARM(FLOPPY_IRQ, "i");
> -MODULE_PARM(FLOPPY_DMA, "i");
> +module_param(floppy, charp, 0);
> +module_param(FLOPPY_IRQ, int, 0);
> +module_param(FLOPPY_DMA, int, 0);
>  MODULE_AUTHOR("Alain L. Knaff");
>  MODULE_SUPPORTED_DEVICE("fd");
>  MODULE_LICENSE("GPL");

Please check Andrew's 2.6.10-rc1-mm2 for a large MODULE_PARAM
patch, and then convert drivers that are not yet converted...

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/broken-out/convert-module_parm-to-module_param-family.patch


-- 
~Randy
