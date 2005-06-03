Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVFCTAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVFCTAr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 15:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVFCTAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 15:00:47 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:40263 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261504AbVFCTAb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 15:00:31 -0400
X-IronPort-AV: i="3.93,167,1115010000"; 
   d="scan'208"; a="250457407:sNHT44115452"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Date: Fri, 3 Jun 2005 14:00:37 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED3A9@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new DellBIOS update driver
Thread-Index: AcVoZqIaaq3tFA2dTDKfABUHfBpHagAAie2Q
From: <Abhay_Salunke@Dell.com>
To: <greg@kroah.com>
Cc: <marcel@holtmann.org>, <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <Matt_Domsch@Dell.com>
X-OriginalArrivalTime: 03 Jun 2005 19:00:37.0743 (UTC) FILETIME=[876917F0:01C5686E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > No no no.  Just because you are using the firmware interface, does
not
> > > mean you need to add this extra round-trip to the whole system.
Just
> > > dump the firmware to the /sys/firmware/whatever... file whenever
you
> > > want to, that's all that is needed.  No hotplug stuff, no filename
> > > stuff, just a simple copy.
> > Greg, all the feedback gave the impression that request_firmwae
hotplug
> > stuff was the way to go.
> 
> It is the way to go.
> 
> > Seems it's not required!
> 
> Not at all, why do you think I mean that?
I meant this driver does not need hotplug per say and just a copy should
be enough (if we decide to go with bin attribute for data file).
> 
> > Now that means it needs to be done the way it was before except that
> > it needs to have a bin attribute for data and a normal attribute for
> > size.  This would be even better as it makes it easy to read back
the
> > data.
> 
> No, you can still use the firmware core code, that's what it is there
> for.  But don't mess with the "make the user provide a filename"
stuff.
> Just have your driver create the firmware request and then relax.
Your
> code will get called when the firware is written to, right?  That's
all
> you need.
> 
At what point I should be calling request_firmware? As my driver does
not have any entry points. In this driver it is called when the user is
ready to download the firmware image (when it echoes the firmware image
name). Also the driver needs to be resident for handling multiple such
requests; that's why cannot do this at driver init time.
When ever the user echoes the file name, it gets passed on to
request_firmware and the $FIRMWARE env gets populated with the file
name. thus making the hotplug code to automatically load the image which
is passed back as fw->data and fw->size. 
> What's with this obsession about firmware filenames... :)
> 
The file name can be same (hardcode) for every update; but writing the
file name was a way to get the user start the update process.

Thanks
Abhay
