Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUIFC7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUIFC7I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 22:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264213AbUIFC7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 22:59:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:29163 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263806AbUIFC7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 22:59:03 -0400
Date: Sun, 5 Sep 2004 17:20:23 -0700
From: Greg KH <greg@kroah.com>
To: James Lamanna <jamesl@appliedminds.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remove Phidget Blacklist if kernel driver is not selected
Message-ID: <20040906002023.GB16840@kroah.com>
References: <auto-000000530333@appliedminds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auto-000000530333@appliedminds.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 03:21:06PM -0700, James Lamanna wrote:
> This patch (compile-tested not runtime tested yet)
> is to remove the blacklisting of Phidgets 
> if the PhidgetServo kernel driver is not included
> in the kernel.
> (Right now it gets rid of all Phidget Blacklists, as more
> drivers are added I would expect they would be per-driver
> segmented).
> 
> It gets quite annoying to have to patch recent kernels 
> everytime to use userspace tools (libhid + libphidgets)
> as opposed to using the kernel driver, which cannot be
> used because of the HID blacklist.
> 
> I don't understand why a kernel driver for the
> PhidgetServo was included in the kernel. Wasn't the
> point of the HID layer to be able to present HID devices
> to userspace so that kernel drivers don't have to be 
> written for each and every device?
> It seems to be that the way to control a fairly simple
> device like the PhidgetServo is through userspace and
> the kernel shouldn't be bothered with the device control
> details.

Yes, you are correct.  I'm going to rip out the in-kernel version (Oh
no! Not again...) because this can all be done better and safer from
userspace.

But the hid blacklist is still correct, even when using the userspace
library, as the hid driver should never bind to these devices.

thanks,

greg k-h
