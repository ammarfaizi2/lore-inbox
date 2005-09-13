Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750903AbVIMVn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbVIMVn5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbVIMVn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:43:57 -0400
Received: from smtp801.mail.ukl.yahoo.com ([217.12.12.138]:23222 "HELO
	smtp801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750892AbVIMVn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:43:57 -0400
Subject: Re: 2.6.14-rc1: oops during boot
From: Grant Wilson <gww@btinternet.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>
In-Reply-To: <432741E9.2090401@gmail.com>
References: <1126643143.5170.11.camel@tlg.swandive.local>
	 <432741E9.2090401@gmail.com>
Content-Type: text/plain
Date: Tue, 13 Sep 2005 22:43:58 +0100
Message-Id: <1126647838.6729.2.camel@tlg.swandive.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-14 at 05:17 +0800, Antonino A. Daplas wrote:
> Grant Wilson wrote:
> > 2.6.14-rc1 oops on boot as a result of the patch "nvidiafb: Fallback to
> > firmware EDID".
> > 
> Thanks.  Try this patch.
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
> diff --git a/drivers/video/nvidia/nv_i2c.c b/drivers/video/nvidia/nv_i2c.c
> --- a/drivers/video/nvidia/nv_i2c.c
> +++ b/drivers/video/nvidia/nv_i2c.c
> @@ -209,10 +209,13 @@ int nvidia_probe_i2c_connector(struct fb
>  
>  	if (!edid && conn == 1) {
>  		/* try to get from firmware */
> -		edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
> -		if (edid)
> -			memcpy(edid, fb_firmware_edid(info->device),
> -			       EDID_LENGTH);
> +		const u8 *e = fb_firmware_edid(info->device);
> +		
> +		if (e != NULL) {
> +			edid = kmalloc(EDID_LENGTH, GFP_KERNEL);
> +			if (edid)
> +				memcpy(edid, e, EDID_LENGTH);
> +		}
>  	}
>  
>  	if (out_edid)

The patch works and the machine now boots and runs without problems -
thank you.

Grant
-- 
Running Linux 2.6.14-rc1 on x86_64

