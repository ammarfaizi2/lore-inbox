Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265095AbUETKQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265095AbUETKQN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 06:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUETKQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 06:16:13 -0400
Received: from gprs212-127.eurotel.cz ([160.218.212.127]:3456 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S265095AbUETKQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 06:16:11 -0400
Date: Thu, 20 May 2004 12:15:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Olaf Hering <olh@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] out of bounds access in hiddev_cleanup
Message-ID: <20040520101548.GD425@ucw.cz>
References: <20040519173929.GA25589@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519173929.GA25589@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 07:39:29PM +0200, Olaf Hering wrote:
> 
> hiddev_table[] is an array of pointers. the minor number is used as an
> offset. hiddev minors start either with zero, or with 96.
> If they start with 96, the offset must be reduced by HIDDEV_MINOR_BASE
> because only 16 minors are available.
> unplugging a hiddevice will zero data outside the hiddev_table array.
> 
> this was spotted by Takashi Iwai.
> 
> --- linux-2.6.5/drivers/usb/input/hiddev.c-dist	2004-05-16 17:16:20.260126241 +0200
> +++ linux-2.6.5/drivers/usb/input/hiddev.c	2004-05-16 17:16:55.285207314 +0200
> @@ -232,7 +232,7 @@ static int hiddev_fasync(int fd, struct 
>  static struct usb_class_driver hiddev_class;
>  static void hiddev_cleanup(struct hiddev *hiddev)
>  {
> -	hiddev_table[hiddev->hid->minor] = NULL;
> +	hiddev_table[hiddev->hid->minor - HIDDEV_MINOR_BASE] = NULL;
>  	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
>  	kfree(hiddev);
>  }
 
Already applied to my tree, thanks for forwarding it anyway.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
