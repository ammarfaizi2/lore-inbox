Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSKRXKw>; Mon, 18 Nov 2002 18:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265114AbSKRXKw>; Mon, 18 Nov 2002 18:10:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61451 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265108AbSKRXKt>; Mon, 18 Nov 2002 18:10:49 -0500
Date: Mon, 18 Nov 2002 23:17:45 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] More missing includes [1/4]
Message-ID: <20021118231745.D21571@flint.arm.linux.org.uk>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.21.0211182314490.16079-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0211182314490.16079-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Mon, Nov 18, 2002 at 11:16:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 11:16:04PM +0100, Geert Uytterhoeven wrote:
> 
> Add missing #include <linux/init.h>
> 
> --- linux-2.5.48/drivers/scsi/scsi.h	Mon Nov 18 10:03:40 2002
> +++ linux-m68k-2.5.48/drivers/scsi/scsi.h	Mon Nov 18 14:18:21 2002
> @@ -18,6 +18,7 @@
>  #include <linux/config.h>	/* for CONFIG_SCSI_LOGGING */
>  #include <linux/devfs_fs_kernel.h>
>  #include <linux/proc_fs.h>
> +#include <linux/init.h>
>  
>  /*
>   * Some of the public constants are being moved to this file.
> 

The more obvious solution is to remove the __initdata from the
declaration on line 545.  Such usage of __initdata (and __init)
serves no purpose.

--- orig/drivers/scsi/scsi.h	Mon Nov 18 09:52:15 2002
+++ linux/drivers/scsi/scsi.h	Mon Nov 18 15:25:42 2002
@@ -542,7 +542,7 @@
 	unsigned flags;
 };
 
-extern struct dev_info scsi_static_device_list[] __initdata;
+extern struct dev_info scsi_static_device_list[];
 
 /*
  * scsi_dev_info_list: structure to hold black/white listed devices.


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

