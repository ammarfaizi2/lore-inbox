Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVFHQnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVFHQnD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbVFHQlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:41:00 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:10505 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261392AbVFHQfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:35:20 -0400
X-IronPort-AV: i="3.93,183,1115010000"; 
   d="scan'208"; a="252057667:sNHT24176994"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Date: Wed, 8 Jun 2005 11:35:05 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3B7@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Thread-Index: AcVsRwEhFOl84AqzQnKeWIvRRjgRwgAAAwKA
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <dtor_core@ameritech.net>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>, <ranty@debian.org>
X-OriginalArrivalTime: 08 Jun 2005 16:35:17.0735 (UTC) FILETIME=[0DF23770:01C56C48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, June 08, 2005 11:27 AM
> To: Salunke, Abhay
> Cc: dtor_core@ameritech.net; linux-kernel@vger.kernel.org;
akpm@osdl.org;
> Domsch, Matt; ranty@debian.org
> Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c to
> support nohotplug
> 
> On Wed, Jun 08, 2005 at 11:23:30AM -0500, Abhay_Salunke@Dell.com
wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Wednesday, June 08, 2005 11:10 AM
> > > To: Salunke, Abhay
> > > Cc: dtor_core@ameritech.net; linux-kernel@vger.kernel.org;
> > akpm@osdl.org;
> > > Domsch, Matt; ranty@debian.org
> > > Subject: Re: [patch 2.6.12-rc3] modifications in firmware_class.c
to
> > > support nohotplug
> > >
> > > On Wed, Jun 08, 2005 at 11:04:09AM -0500, Abhay_Salunke@Dell.com
> > wrote:
> > > > > I think it would be better if you just have request_firmware
and
> > > > > request_firmware_nowait accept timeout parameter that would
> > override
> > > > > default timeout in firmware_class. 0 would mean use default,
> > > > > MAX_SCHED_TIMEOUT - wait indefinitely.
> > > >
> > > > But we still need to avoid hotplug being invoked as we need it
be a
> > > > manual process.
> > >
> > > No, hotplug can happen just fine (it happens loads of times today
for
> > > things that people don't care about.)
> > >
> > If hotplug happens the complete function is called which makes the
> > request_firmware return with a failure.
> 
> If this was true, then the current code would not work at all.
Why not? Can't we avoid hotplug from running by not calling
kobject_hotplug()?
If hotplug does not happen we can do the stuff done by hotplug script
manually. And also the current code skips add_timer so not timeouts
irrespective of the timeout specified in /sys/class/firmware/timeout
thus preventing from breaking other's who are using timeout.

Thanks,
Abhay

