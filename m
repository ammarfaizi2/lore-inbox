Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUIMX2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUIMX2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269060AbUIMX2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:28:42 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:44742 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269059AbUIMX2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:28:38 -0400
Date: Tue, 14 Sep 2004 00:28:36 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dri-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Evan Paul Fletcher <evanpaul@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] DRM: add missing pci_enable_device()
In-Reply-To: <200409131651.05059.bjorn.helgaas@hp.com>
Message-ID: <Pine.LNX.4.58.0409140026430.15167@skynet>
References: <200409131651.05059.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This causes problems when DRI and fb are loaded and you unload dri.. guess
what happens your fb??, or it does in theory I might have time to practice
later,

now the quick fix is to take the stealth/non-stealth code from CVS which
we know works or we wait for Alan to finish his vga device code and we fix
up the DRM and fb to use it ... this patch won't help anyways...

Dave.

On Mon, 13 Sep 2004, Bjorn Helgaas wrote:

> Add pci_enable_device()/pci_disable_device.  In the past, drivers often worked
> without this, but it is now required in order to route PCI interrupts
> correctly.
>
> Evan Paul Fletcher found this problem with 2.6.9-rc1-mm4 and X.org 6.8.0
> and verified that this patch fixes it.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> ===== drivers/char/drm/drm_drv.h 1.47 vs edited =====
> --- 1.47/drivers/char/drm/drm_drv.h	2004-09-08 03:41:23 -06:00
> +++ edited/drivers/char/drm/drm_drv.h	2004-09-13 12:27:16 -06:00
> @@ -443,6 +443,8 @@
>  	}
>  	up( &dev->struct_sem );
>
> +	pci_disable_device( dev->pdev );
> +
>  	return 0;
>  }
>
> @@ -492,6 +494,9 @@
>  		return -EPERM;
>  	dev->device = MKDEV(DRM_MAJOR, dev->minor );
>  	dev->name   = DRIVER_NAME;
> +
> +	if ((retcode = pci_enable_device(pdev)))
> +		return retcode;
>
>  	dev->pdev   = pdev;
>  #ifdef __alpha__
>

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

