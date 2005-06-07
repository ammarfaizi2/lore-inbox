Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVFGOrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVFGOrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 10:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVFGOru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 10:47:50 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:8985 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261887AbVFGOrg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:47:36 -0400
X-IronPort-AV: i="3.93,179,1115010000"; 
   d="scan'208"; a="251525217:sNHT25008628"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Tue, 7 Jun 2005 09:47:47 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3B0@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVq1CtopPdkQeuOSgiEg5f87HA1hQAmkpZw
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 07 Jun 2005 14:47:48.0491 (UTC) FILETIME=[DF7BEDB0:01C56B6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Monday, June 06, 2005 3:13 PM
> To: Salunke, Abhay
> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; akpm@osdl.org;
> Domsch, Matt
> Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
> DellBIOS update driver
> 
> On Mon, Jun 06, 2005 at 03:01:04PM -0500, Abhay_Salunke@Dell.com
wrote:
> > > Ok, in re-reading the firmware code, you are correct, it will
still
> > > timeout in 10 seconds and call your callback.
> > >
> > > Which, in my opinion, is wrong.  We should have some way to say
"wait
> > > forever".  Care to change the firmware_class.c code to support
this?
> > Will give it a try. So far the request_firmware code calls
> > kobject_hotplug with action as KOBJ_ADD. It invokes a hotplug script
> > form user mode. I guess we need to have some reverse mechanism which
is
> > invoked when a user writes to the file.
> 
> Why?  Your completion function should be called when the file is
closed,
> right?
> 
> > > I was assuming that this would wait forever, and is why I pointed
you
> > in
> > > this direction.  Sorry about the confusion here.
> > >
> > I guess the earlier method of request_firmware would work out as is
with
> > the only disadvantage of the user having to depend on hotplug
mechanism
> > and echoing firmware name.
> > Let me know if that is acceptable till we find a solution to wait
for
> > ever without using hotplug stuff.
> 
> Why not fix the firmware_class.c code now?  :)
I am working on a solution for this; so yes, I will submit a patch to
enhance firmware_class.c code.

Mean while the driver sent earlier is tested and working on current
version of 2.6 kernel and we have tested it with various distros based
on 2.6 kernel. Changing the kernel and making the driver dependent on
the new code will make the driver not work on the current kernels which
the users have. 
This will make driver non functional on current 2.6 kernels and will be
an issue if users don't want to upgrade their kernels but just want the
driver to update BIOS.

Thanks,
Abhay
