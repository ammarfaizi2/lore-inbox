Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWJJRhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWJJRhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 13:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWJJRhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 13:37:50 -0400
Received: from xenotime.net ([66.160.160.81]:57518 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751006AbWJJRht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 13:37:49 -0400
Date: Tue, 10 Oct 2006 10:39:15 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Jeremy Higdon <jeremy@sgi.com>, Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
Message-Id: <20061010103915.f412d770.rdunlap@xenotime.net>
In-Reply-To: <20061010120928.V71367@pkunk.americas.sgi.com>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 12:11:16 -0500 (CDT) Brent Casavant wrote:

> Index: top/drivers/Kconfig
> ===================================================================
> --- top.orig/drivers/Kconfig	2006-10-09 17:41:25.000000000 -0500
> +++ top/drivers/Kconfig	2006-10-09 17:47:50.415607888 -0500
> @@ -14,6 +14,10 @@
>  
>  source "drivers/block/Kconfig"
>  
> +# misc before ide - BLK_DEV_SGIIOC4 depends on SGI_IOC4
> +
> +source "drivers/misc/Kconfig"
> +
>  source "drivers/ide/Kconfig"
>  
>  source "drivers/scsi/Kconfig"
> @@ -52,8 +56,6 @@
>  
>  source "drivers/hwmon/Kconfig"
>  
> -source "drivers/misc/Kconfig"
> -
>  source "drivers/mfd/Kconfig"
>  
>  source "drivers/media/Kconfig"

Mostly curious:  did you observe that this is required?
I always thought that Roman said that unknown config variables
caused a rescan by kconfig.  IOW, I thought that it wouldn't
be observable by a user.  Just wondering..


> Index: top/drivers/misc/Kconfig
> ===================================================================
> --- top.orig/drivers/misc/Kconfig	2006-10-09 17:41:25.000000000 -0500
> +++ top/drivers/misc/Kconfig	2006-10-09 17:48:56.555631075 -0500
> @@ -28,6 +28,18 @@
>  
>  	  If unsure, say N.
>  
> +config SGI_IOC4
> +	tristate "SGI IOC4 Base IO support"
> +	default m
> +	---help---
> +	This option enables basic support for the IOC4 chip on certain
> +	SGI IO controller cards (IO9, IO10, and PCI-RT).  This option
> +	does not enable any specific functions on such a card, but provides
> +	necessary infrastructure for other drivers to utilize.
> +
> +	If you have an SGI Altix with an IOC4-based card say Y.
> +	Otherwise say N.

The lines under ---help--- should be indented by 2 spaces (by
convention) (and even though they were not when in the /sn/ subdir).


>  config TIFM_CORE
>  	tristate "TI Flash Media interface support (EXPERIMENTAL)"
>  	depends on EXPERIMENTAL



---
~Randy
