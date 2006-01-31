Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWAaGcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWAaGcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 01:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWAaGcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 01:32:07 -0500
Received: from smtp111.sbc.mail.re2.yahoo.com ([68.142.229.94]:55699 "HELO
	smtp111.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932276AbWAaGcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 01:32:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Ben Collins <bcollins@ubuntu.com>
Subject: Re: [PATCH 2.6.15/2.6.16-git] Fix off-by-one for num_values =?utf-8?q?in=09uref=5Fmulti?= requests
Date: Tue, 31 Jan 2006 01:32:02 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       vojtech@suse.cz
References: <1138638276.4456.121.camel@grayson>
In-Reply-To: <1138638276.4456.121.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601310132.02803.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 11:24, Ben Collins wrote:
> Found this when working with a HAPP UGCI device. It has a usage with 7
> indexes. I could read them all one at a time, but using a multiref it
> would only allow me to read the first 6. The patch below fixed it.
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
>

I applied this to the input tree, thanks!

> --- a/drivers/usb/input/hiddev.c
> +++ b/drivers/usb/input/hiddev.c
> @@ -632,7 +632,7 @@ static int hiddev_ioctl(struct inode *in
>  
>  			else if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
>  				 (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
> -				  uref->usage_index + uref_multi->num_values >= field->report_count))
> +				  uref->usage_index + uref_multi->num_values > field->report_count))
>  				goto inval;
>  			}
>  
> 

-- 
Dmitry
