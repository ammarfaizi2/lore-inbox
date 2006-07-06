Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWGGABe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWGGABe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWGGABe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:01:34 -0400
Received: from ns.suse.de ([195.135.220.2]:38083 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750880AbWGGABd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:01:33 -0400
Date: Thu, 6 Jul 2006 16:57:45 -0700
From: Greg KH <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Implement class_device_update_dev() function
Message-ID: <20060706235745.GA13548@kroah.com>
References: <1152226792.29643.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152226792.29643.8.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2006 at 12:59:52AM +0200, Marcel Holtmann wrote:
> Hi Greg,
> 
> for the Bluetooth subsystem integration into the driver model it is
> required that we can update the device of a class device at any time.

You can?  Ick.

That messes with my "get rid of struct class_device" plans a bit...

> For the RFCOMM TTY device for example we create the TTY device and only
> when it got opened we create the Bluetooth connection. Once this new
> connection has been created we have a device to attach to the class
> device of the TTY.
> 
> I came up with the attached patch and it worked fine with the Bluetooth
> RFCOMM layer.

But userspace should also find out about this change, and this patch
prevents that from happening.  What about just tearing down the class
device and creating a new one?  That way userspace knows about the new
linkage properly, and any device naming and permission issues can be
handled anew?

thanks,

greg k-h
