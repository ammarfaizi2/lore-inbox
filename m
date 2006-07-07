Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbWGGHm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWGGHm0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 03:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWGGHm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 03:42:26 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:59558 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1750907AbWGGHmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 03:42:25 -0400
Subject: Re: Implement class_device_update_dev() function
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060706235745.GA13548@kroah.com>
References: <1152226792.29643.8.camel@localhost>
	 <20060706235745.GA13548@kroah.com>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 09:42:32 +0200
Message-Id: <1152258152.3693.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > for the Bluetooth subsystem integration into the driver model it is
> > required that we can update the device of a class device at any time.
> 
> You can?  Ick.
> 
> That messes with my "get rid of struct class_device" plans a bit...

this must not be a class device, but at the moment TTY, network and
input are still class devices. The Bluetooth subsystem moved away from
using class devices.

> > For the RFCOMM TTY device for example we create the TTY device and only
> > when it got opened we create the Bluetooth connection. Once this new
> > connection has been created we have a device to attach to the class
> > device of the TTY.
> > 
> > I came up with the attached patch and it worked fine with the Bluetooth
> > RFCOMM layer.
> 
> But userspace should also find out about this change, and this patch
> prevents that from happening.  What about just tearing down the class
> device and creating a new one?  That way userspace knows about the new
> linkage properly, and any device naming and permission issues can be
> handled anew?

This won't work for Bluetooth. We create the TTY and its class device
with tty_register_device() and then the device node is present. Then at
some point later we open that device and the Bluetooth connection gets
established. Only when the connection has been established we know the
device that represents it. So tearing down the class device and creating
a new one will screw up the application that is using this device node.

Would reissuing the uevent of the class device help here?

Regards

Marcel


