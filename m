Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264605AbSIQWQh>; Tue, 17 Sep 2002 18:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264621AbSIQWQh>; Tue, 17 Sep 2002 18:16:37 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:28806 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264605AbSIQWQg>;
	Tue, 17 Sep 2002 18:16:36 -0400
Date: Tue, 17 Sep 2002 15:21:02 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Thomas Dodd <ted@cypress.com>
Cc: Rogier Wolff <R.E.Wolff@bitwizard.nl>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net
Subject: Re: Problems accessing USB Mass Storage
Message-ID: <20020917152102.A17561@eng2.beaverton.ibm.com>
References: <1032261937.1170.13.camel@stimpy.angelnet.internal> <20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com> <20020917174631.GD2569@kroah.com> <20020917234302.A26741@bitwizard.nl> <3D87A6E3.5090407@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3D87A6E3.5090407@cypress.com>; from ted@cypress.com on Tue, Sep 17, 2002 at 05:04:19PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 05:04:19PM -0500, Thomas Dodd wrote:
> 
> 
> Rogier Wolff wrote:
> > On Tue, Sep 17, 2002 at 10:46:31AM -0700, Greg KH wrote:
> > 
> >>On Tue, Sep 17, 2002 at 12:37:37PM -0500, Thomas Dodd wrote:
> >>
> >>>I get the feeling it's not a true mass storage device.
> >>
> >>Sounds like it.
> > 
> > 
> > Nope. Sure does sound like it's a mass storage device. And it works
> > too. 
> > 
> > The kernel managed to read the partition table off it, and got
> > one valid partition: sda1. 
> 
> Accept that you cannot read data from the device. At all.
> Even dd fails. And the windows drivers work (using XP
> in vmware it think it was) correctly on this same device.
> 
> 	-Thomas

But it did read the first 8 blocks off the devices when it
read the partition, the usb debug showed:

usb-storage: Command READ_10 (10 bytes)
usb-storage: 28 00 00 00 00 00 00 00 08 00 30 da

With offsets starting at 0 -

Bytes 2 - 5 are the logical block address, all 0.
Bytes 7 - 8 are the transfer length  - 8 blocks.

The last two bytes are junk.

You should be able to run the equivalent:

	dd if=/dev/sda of=/dev/zero bs=512 count=8

And, look in dmesg for the failure message of the first read that fails, it
could have set the device offline.

-- Patrick Mansfield
