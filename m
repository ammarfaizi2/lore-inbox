Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270469AbTHQS3R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHQS3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:29:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:29421 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270469AbTHQS3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:29:14 -0400
Date: Sun, 17 Aug 2003 11:28:47 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20030817182847.GA2422@kroah.com>
References: <200307262036.13989.arvidjaar@mail.ru> <200307282044.43131.arvidjaar@mail.ru> <20030728170308.GA4839@kroah.com> <200308172041.31874.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308172041.31874.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 08:41:31PM +0400, Andrey Borzenkov wrote:
> On Monday 28 July 2003 21:03, Greg KH wrote:
> [...]
> > > Question: how to configure udev so that "database" always refers to LUN 0
> > > on target 0 on bus 0 on HBA in PCI slot 1.
> >
> > If you can't rely on scsi position, then you need to look for something
> > that uniquely describes the device.  Like a filesystem label, or a uuid
> > on the device.  udev can handle this (well I'm still working on the
> > filesystem label, but others have already done the hard work for that to
> > be intregrated easily.)
> >
> 
> I tried to explain that I can rely on SCSI position but kernel does not give 
> me this SCSI position. Apparently we have some communication problem. You do 
> not understand my question and I do not understand what you do not understand 
> :) I attribute it to my bad English.
> 
> Let's avoid this communication problem. You show me namedev.config line that 
> implements the above. If it really does it - it is likely I understand what 
> you mean better and won't bother you with stupid questions anymore. If it 
> does not do it - I can immediately point out where it fails.

Here's the line that I used in my demo at OLS 2003 for udev:

	# USB camera from Fuji to be named "camera"
	LABEL, BUS="usb", vendor="FUJIFILM", NAME="camera"

This is a scsi device on the USB bus that has the vendor name "FUJIFILM"
in it's scsi sysfs directory.

Now, partition issues asside (all partitions of this device will be
named camera, camera1, camera2, etc., but I'm working on identifying
partitions better) this shows that the vendor of a scsi device is able
to be named uniquely.

Does that help?  Have you looked at the 2003 OLS paper about udev for
more information?

thanks,

greg k-h
