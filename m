Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbUJZXyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbUJZXyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 19:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUJZXyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 19:54:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:23009 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261551AbUJZXyl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 19:54:41 -0400
Subject: Re: [PATCH] radeonfb: If no video memory, exit with error [repost]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, ajoshi@shell.unixbox.com,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200410261603.24434.bjorn.helgaas@hp.com>
References: <200410261603.24434.bjorn.helgaas@hp.com>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 09:50:55 +1000
Message-Id: <1098834655.6916.66.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, looks ok.

On Tue, 2004-10-26 at 16:03 -0600, Bjorn Helgaas wrote:
> Posted this last week (10/21) but haven't seen any response.
> Would you consider this for the next -mm?  Also attached in
> case kmail mangles the whitespace.
> 
> 
> [PATCH] radeonfb: If no video memory, exit with error
> 
> Nothing good will happen if we try to ioremap and use a zero-sized
> frame buffer.  I observed this problem on an ia64 sx1000 box, where
> the BIOS doesn't run the option ROM.  If we try to continue, radeonfb
> just gets hopelessly confused because the card isn't initialized
> correctly.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ===== drivers/video/aty/radeon_base.c 1.32 vs edited =====
> --- 1.32/drivers/video/aty/radeon_base.c 2004-10-19 03:40:34 -06:00
> +++ edited/drivers/video/aty/radeon_base.c 2004-10-21 11:50:51 -06:00
> @@ -2186,7 +2186,9 @@
>            rinfo->video_ram = 8192 * 1024;
>            break;
>           default:
> -          break;
> +   printk (KERN_ERR "radeonfb: no video RAM reported\n");
> +   ret = -ENXIO;
> +   goto err_unmap_rom;
>    }
>   }
>  
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

