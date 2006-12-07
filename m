Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031823AbWLGIFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031823AbWLGIFK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 03:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031822AbWLGIFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 03:05:10 -0500
Received: from mx-out-01.nestec.net ([203.200.144.45]:2858 "EHLO
	mx-out-01.nestec.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031823AbWLGIFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 03:05:07 -0500
Organization: NeST-India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A50AB71042@pdc2.nestec.net>
From: ANIL JACOB <ANILJACOB@nestec.net>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: The invoking of probe function for platform devices ??
Date: Thu, 7 Dec 2006 13:32:33 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.3)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Greg,

I just started to hack the Linux kernel source code and I am having a doubt
regarding the platform devices addition in Linux kernel.

My understanding is now the platform device also uses probe functions.
Usually for plug and play devices like USB, when it is plugged some signals
from the USB device and HOST does the trick of invoking the probe functions.
 
For platform devices like RTC which is not plug_and_play, how this probe
function is initiated?

At what stage of the initiation the probe function is called. I guess when
compiled as a module, the only entry point of the driver I will be having is
init function and the exit point is exit function. Then how will it be
entering into the probe function for platform devices?

If my understanding about the probe function is incorrect please clarify my
doubts.

Please find the code snippet for the platform_driver I tried below.

Struct platform_device *my_dev;

Struct my_res = {
	.start = start_of_my_device_res, //Starting of the physical address
of 						   //the device I am playing
with
	.end = end_of_my_device_res,
	.name = "my_res",
	.flags = IORESOURCE_IO,
};

......
......

Struct platform_driver my_drv ={
	.probe = my_probe,
	.remove =  my_remove,
	.driver	= {
		.name 	= "my_platform_driver",
		.owner	= THIS_MODULE,
	},
};

static int __init ds15x1rtc_init(void)
{
	int err;

	if ((err = platform_driver_register(&my_drv)))
		return err;
	
	if ((my_dev =  platform_device_register_simple("my_platform_device",
1, &my_res,1)) == NULL){
		printk("device registeration failed\n");
		goto errout_pf_dev_register;
	}

	
	return 0;

errout_pf_dev_register:
	platform_driver_unregister(&my_drv);
	return err;
	

}

static void __exit ds15x1rtc_cleanup(void)
{
	platform_device_unregister(my_dev);
	platform_driver_unregister(&my_drv);
	
}

Also is it a right thing to do the initialization of the resource of my
platform device in this file or should it be done in the target specific
initialization codes for more portability?

Thanks in advance

Regards,
Anil Jacob 


---------------------------------------------------------------------------
       "This e-mail and any files transmitted with it are for the sole use
of the intended recipient(s) and may contain confidential and privileged
information. If you are not the intended recipient, please contact the
sender by reply e-mail and destroy all copies of the original message.

       Any unauthorized review, use, disclosure, dissemination, forwarding,
printing or copying of this email or any action taken upon this e-mail is
strictly prohibited and may be unlawful."
---------------------------------------------------------------------------
