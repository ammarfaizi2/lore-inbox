Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271196AbTHRCEe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 22:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271201AbTHRCEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 22:04:34 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:44044 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271196AbTHRCEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 22:04:32 -0400
Date: Sun, 17 Aug 2003 19:04:25 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Does sysfs really provides persistent hardware path to devices?
Message-ID: <20030818020425.GB10453@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <200307262036.13989.arvidjaar@mail.ru> <200307282044.43131.arvidjaar@mail.ru> <20030728170308.GA4839@kroah.com> <200308172041.31874.arvidjaar@mail.ru> <20030817182847.GA2422@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817182847.GA2422@kroah.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Unauthorised duplication and storage of this email is a violation of international copyright law and is subject to prosecution.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 11:28:47AM -0700, Greg KH wrote:
> On Sun, Aug 17, 2003 at 08:41:31PM +0400, Andrey Borzenkov wrote:
> > On Monday 28 July 2003 21:03, Greg KH wrote:
> > [...]
> > > > Question: how to configure udev so that "database" always refers to LUN 0
> > > > on target 0 on bus 0 on HBA in PCI slot 1.
> > >
> > > If you can't rely on scsi position, then you need to look for something
> > > that uniquely describes the device.  Like a filesystem label, or a uuid
> > > on the device.  udev can handle this (well I'm still working on the
> > > filesystem label, but others have already done the hard work for that to
> > > be intregrated easily.)
> > >
> > 
> > I tried to explain that I can rely on SCSI position but kernel does not give 
> > me this SCSI position. Apparently we have some communication problem. You do 
> > not understand my question and I do not understand what you do not understand 
> > :) I attribute it to my bad English.
> > 
> > Let's avoid this communication problem. You show me namedev.config line that 
> > implements the above. If it really does it - it is likely I understand what 
> > you mean better and won't bother you with stupid questions anymore. If it 
> > does not do it - I can immediately point out where it fails.
> 
> Here's the line that I used in my demo at OLS 2003 for udev:
> 
> 	# USB camera from Fuji to be named "camera"
> 	LABEL, BUS="usb", vendor="FUJIFILM", NAME="camera"
> 
> This is a scsi device on the USB bus that has the vendor name "FUJIFILM"
> in it's scsi sysfs directory.
> 
> Now, partition issues asside (all partitions of this device will be
> named camera, camera1, camera2, etc., but I'm working on identifying
> partitions better) this shows that the vendor of a scsi device is able
> to be named uniquely.

<OT>
That's nice.  Now add a second camera from the same vendor
:(  No, i don't expect you to be able to uniquely identify
identical devices being added and removed from a single USB buss
in a persistent way.  But it would be nice if we could get
consistency between busses so that a mouse on one USB buss
weren't confused with a mouse on another USB buss.
</OT>

> Does that help?  Have you looked at the 2003 OLS paper about udev for
> more information?

Actually you have not answered his question.  And i think it
a reasonable one.  It could be it was answered elsewhere.

>>>> Question: how to configure udev so that "database" always refers to LUN 0
>>>> on target 0 on bus 0 on HBA in PCI slot 1.
>> Let's avoid this communication problem. You show me namedev.config line that 
>> implements the above.

I'll try to put slightly differently.  I'll concede that we
cannot positionaly identify USB devices so lets set that
aside for the nonce.  We can persistently, positionaly
identify a device within the HBA context (BUS +ID + LUN) and
should be able to do the same for a PCI HBA (PCI slot +
device) or (PCI bridge topology).

So can i uniquely identify using persistent positional
information a drive at PCI_slot=1, HBA_on_card=0, BUS=0,
ID=1, LUN=0?  And how do i uniquely identify it in the udev
config file so that adding the same model drive in the same
BUS+ID+LUN on an same model HBA card in another PCI slot
does not confuse the two?  If i cannot, can i at least do
the identification so that adding ID=0,LUN=0 to the scsi buss
doesn't cause a name change.


-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
