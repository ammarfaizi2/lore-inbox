Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUFSD2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUFSD2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 23:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUFSD2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 23:28:44 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:40869 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261752AbUFSD2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 23:28:43 -0400
Subject: Re: BUG(?): class_device_driver_link()
From: James Bottomley <James.Bottomley@steeleye.com>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040619000356.GC24902@kroah.com>
References: <20040618202305.GB18008@kroah.com>
	<Pine.LNX.4.44L0.0406181723020.979-100000@ida.rowland.org> 
	<20040619000356.GC24902@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 22:28:39 -0500
Message-Id: <1087615720.2134.233.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 19:03, Greg KH wrote:
> Again, the driver owns the class device.  scsi has something wrong
> again.  Time to stop avoiding everyone at work...

Well, the SCSI model for using these things isn't exactly the same as a
more standard entity like a PCI device.

For every SCSI device the mid-layer scans, we allocate a generic device.

We have various drivers in the driver model corresponding to our Upper
Layer Drivers (disc[sd] tape[st] etc), although there are SCSI devices
(like processors) that will get no driver at all bound.

We then use classes to export *device* interfaces, like one class of all
devices, another for Parallel interface devices, another for Fibre
Channel devices and so on.

We expect the class interface to work whether or not a driver is
present, because the class as we've implemented it is an interface to a
device property, not a driver property (and we also expect the class
interface to span multiple drivers...tapes and discs may all be attached
to a parallel bus, etc).

It sounds like the mismatch is interface on device rather than interface
on driver, but I don't see a way we could make the interface on driver
work for us because we need the interface even if a driver isn't bound.

James


