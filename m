Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271713AbTGRGJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 02:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271720AbTGRGJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 02:09:50 -0400
Received: from mail.convergence.de ([212.84.236.4]:9182 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271713AbTGRGJs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 02:09:48 -0400
Message-ID: <3F1792AA.70704@convergence.de>
Date: Fri, 18 Jul 2003 08:24:42 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Add two drivers for USB based DVB-T adapters
References: <10582891731946@convergence.de> <20030715212005.GA5458@kroah.com>
In-Reply-To: <20030715212005.GA5458@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

>>+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>>+static void *ttusb_probe(struct usb_device *udev, unsigned int ifnum,
>>+		  const struct usb_device_id *id)
>>+{

> Ick, you don't really want to try to support all of the USB changes in
> the same driver, now do you?  Why not just live with two different
> drivers.

Because I'm the poor guy that has to test it with 2.4 and 2.5 and who's 
submitting the patches. 8-)

The author is mainly working with 2.4, I'm trying to compile it and test 
it for 2.5.

> The ALSA people eventually gave up trying to do this... :)

I agree, I'll separate the stuff now that it has gone into Linus' tree.

>>+#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,5,69))
>>+#undef devfs_remove
>>+#define devfs_remove(x)	devfs_unregister(ttusb->stc_devfs_handle);
>>+#endif
>>+#if 0
>>+	devfs_remove(TTUSB_BUDGET_NAME);
>>+#endif

> You end up with crud like this because of trying to support old kernels.
> Why do you care about kernels prior to 2.5.69?  If so, your USB kernel
> checks are wrong, as 2.5.0 didn't have those API changes :)

I already wrote Linus that I'll remove this compatibility crap with the 
next patchset.

> thanks,
> greg k-h

Thanks for your feedback!

CU
Michael.

