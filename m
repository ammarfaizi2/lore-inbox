Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVFCT5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVFCT5m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVFCT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:57:42 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:8229 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261526AbVFCT5V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:57:21 -0400
X-IronPort-AV: i="3.93,167,1115010000"; 
   d="scan'208"; a="268908275:sNHT25460060"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Fri, 3 Jun 2005 14:57:23 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3AA@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVocqnnvaxBfSP3Q6iZ/IyIxTGHaAAAKFog
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 03 Jun 2005 19:57:18.0375 (UTC) FILETIME=[72585B70:01C56876]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > At what point I should be calling request_firmware?
> 
> Never, you should call request_firmware_nowait() instead.  And do it
> from your module init function.
> 
> > As my driver does
> > not have any entry points. In this driver it is called when the user
is
> > ready to download the firmware image (when it echoes the firmware
image
> > name). Also the driver needs to be resident for handling multiple
such
> > requests; that's why cannot do this at driver init time.
> 
> That's what request_firmware_nowait() is for.
> 
But isn't request_firmware_nowait a one time deal. It creates a kernel
thread which will call the cont function once and end it. In that case I
will have to unload and reload the driver every time before doing an
update.
Also driver's unload has to free the allocated memory; this will not
serve the purpose of this driver.
> > When ever the user echoes the file name, it gets passed on to
> > request_firmware and the $FIRMWARE env gets populated with the file
> > name. thus making the hotplug code to automatically load the image
which
> > is passed back as fw->data and fw->size.
> 
> It's easier for the user to just copy the firmware to the sysfs file
> whenever they want to.  No messing with hotplug events or filenames.
> 
I must be missing some things here. Can copying the data to the sysfs
file with normal attributes work? Don't we need to have a sysfs file
with bin attribute? Could you please elaborate on this...I am quoting
you from one of your earlier response "I can understand having the data
use the sysfs binary attribute, but do not do this for the size files.
Please just use a normal attribute for them, the binary ones are _only_
for blobs of data that are not interpreted by the kernel"

Thanks,
Abhay

