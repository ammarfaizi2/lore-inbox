Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSBGWX1>; Thu, 7 Feb 2002 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291373AbSBGWXR>; Thu, 7 Feb 2002 17:23:17 -0500
Received: from mailc.telia.com ([194.22.190.4]:33239 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S291372AbSBGWXC>;
	Thu, 7 Feb 2002 17:23:02 -0500
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.5.4-pre1 (decoded) oops on boot in device_create_file
In-Reply-To: <3C61DCE5.6D05CF90@oracle.com>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Feb 2002 23:22:36 +0100
In-Reply-To: <3C61DCE5.6D05CF90@oracle.com>
Message-ID: <m2bsf1hqz7.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi <alessandro.suardi@oracle.com> writes:

> Must be my time of the year - first the kmem_cache_create one in
>  2.5.3-pre[45], now this one (should happen about PCI allocation
>  of one of the Xircom CardBus resources):

I had the same problem with 2.5.4-pre2. The patch below makes my
laptop able to boot again, but I don't know if the patch is correct.

--- linux/drivers/pcmcia/cardbus.c.old	Thu Feb  7 23:09:54 2002
+++ linux/drivers/pcmcia/cardbus.c	Thu Feb  7 23:17:45 2002
@@ -281,6 +281,10 @@
 
 		pci_setup_device(dev);
 
+		strcpy(dev->dev.name, dev->name);
+		strcpy(dev->dev.bus_id, dev->slot_name);
+		device_register(&dev->dev);
+
 		/* FIXME: Do we need to enable the expansion ROM? */
 		for (r = 0; r < 7; r++) {
 			struct resource *res = dev->resource + r;

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
