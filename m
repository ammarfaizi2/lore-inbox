Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964994AbVKGRsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964994AbVKGRsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbVKGRsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:48:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:26597 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964994AbVKGRsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:48:18 -0500
Date: Mon, 7 Nov 2005 09:47:42 -0800
From: Greg KH <greg@kroah.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051107174742.GF17004@kroah.com>
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <43691E7E.5090902@free.fr> <43692D15.8060307@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43692D15.8060307@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 10:18:13PM +0100, matthieu castet wrote:
> matthieu castet wrote:
> >Hi Greg,
> >>>+/*
> >>>+ * sometime hotplug don't have time to give the firmware the
> >>>+ * first time, retry it.
> >>>+ */
> >>>+static int sleepy_request_firmware(const struct firmware **fw, 
> >>>+        const char *name, struct device *dev)
> >>>+{
> >>>+    if (request_firmware(fw, name, dev) == 0)
> >>>+        return 0;
> >>>+    msleep(1000);
> >>>+    return request_firmware(fw, name, dev);
> >>>+}
> >>
> >>
> >>
> >>No, use the async firmware download mode instead of this.  That will
> >>solve all of your problems.
> >>
> >>
> >Thanks, but does userspace will retry if it fails the first time ?
> >The device needs the firmware quickly and after 3-5 seconds without it, 
> >it goes berserk.
> >
> In request_firmware_nowait, when kernel_thread failed, where fw_work is 
> freed ?
> Aren't there a memleack ?

I really do not know, as I have not looked at that code.  If you see
problems in it, please feel free to fix it up, as there is no living
maintainer for it anymore :(

thanks,

greg k-h
