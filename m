Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVB1FkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVB1FkY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 00:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVB1FkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 00:40:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:14763 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261561AbVB1FkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 00:40:18 -0500
Date: Sun, 27 Feb 2005 21:39:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: "" <pmarques@grupopie.com>
Cc: mdharm-kernel@one-eyed-alien.net, linux-kernel@vger.kernel.org,
       perex@suse.cz, luming.yu@intel.com
Subject: Re: sizeof(ptr) or sizeof(*ptr)?
Message-Id: <20050227213946.199e82af.akpm@osdl.org>
In-Reply-To: <1109546013.4222541d5db16@webmail.grupopie.com>
References: <1109535904.42222ca0b0b78@webmail.grupopie.com>
	<20050227204524.GA29026@one-eyed-alien.net>
	<1109546013.4222541d5db16@webmail.grupopie.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"" <pmarques@grupopie.com> wrote:
>
> Anyway, after improving the tool and checking for false positives, there is only
>  one more suspicious piece of code in drivers/acpi/video.c:561
> 
>  	status = acpi_video_device_lcd_query_levels(device, &obj);
> 
>  	if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count >= 2) {
>  		int count = 0;
>  		union acpi_object *o;
> 
>  		br = kmalloc(sizeof &br, GFP_KERNEL);

yup, bug.

>  		if (!br) {
>  			printk(KERN_ERR "can't allocate memory\n");
>  		} else {
>  			memset(br, 0, sizeof &br);
>  			br->levels = kmalloc(obj->package.count * sizeof &br->levels, GFP_KERNEL);

And another one, although it happens to work out OK.

I'll get these all fixed up, thanks.
