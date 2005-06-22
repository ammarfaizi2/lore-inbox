Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVFVSdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVFVSdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 14:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261870AbVFVSdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 14:33:37 -0400
Received: from sd291.sivit.org ([194.146.225.122]:3593 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261862AbVFVSd1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 14:33:27 -0400
Subject: Re: [linux-usb-devel] usb sysfs intf files no longer created when
	probe fails
From: Stelian Pop <stelian@popies.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0506221144360.6938-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0506221144360.6938-100000@iolanthe.rowland.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 22 Jun 2005 20:33:25 +0200
Message-Id: <1119465205.5080.10.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 juin 2005 à 12:03 -0400, Alan Stern a écrit :
> On Wed, 22 Jun 2005, Stelian Pop wrote:
> 
> > Notice the '1-2:1.1' is missing. Upon booting I get:
> > 
> > Jun 22 13:34:04 localhost kernel: HID device not claimed by input or hiddev
> > Jun 22 13:34:04 localhost kernel: usbhid: probe of 1-2:1.1 failed with error -5
> > Jun 22 13:34:04 localhost kernel: usb 1-2: device_add(1-2:1.1) --> -5

> You shouldn't call usb_create_sysfs_intf_files in any case.

Ok.

> Your driver is returning -EIO from its probe routine according to the log,
> so it's not getting bound to the device. 

Actually that's usbhid which returns -EIO.

>  Hence there shouldn't be any
> attempt to unbind the device when your driver is removed.  This is a bug
> in usbcore; it tries to delete all the interfaces without checking whether 
> they were successfully added.

Since this is fixed by reverting the device_add patch, I'm wondering if
this isn't a driver model core bug, where it tries to device_remove all
the "devices" even if they weren't correctly added before...

But I haven't looked closely at the code, this is just a thought.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

