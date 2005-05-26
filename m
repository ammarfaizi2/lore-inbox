Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbVEZSnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbVEZSnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEZSnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:43:53 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:31027 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261696AbVEZSnf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:43:35 -0400
X-IronPort-AV: i="3.93,140,1115010000"; 
   d="scan'208"; a="265690076:sNHT23251418"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Date: Thu, 26 May 2005 13:43:30 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED39A@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Thread-Index: AcViE+iPCkOzE3IDS7eJ3EfFhgNjrwADbjEg
From: <Abhay_Salunke@Dell.com>
To: <Matt_Domsch@Dell.com>
Cc: <greg@kroah.com>, <linux-kernel@vger.kernel.org>, <ranty@debian.org>
X-OriginalArrivalTime: 26 May 2005 18:43:31.0297 (UTC) FILETIME=[D04BDD10:01C56222]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt,
I may be wrong; but I think request_firmware(&fw, NAME , device)  will
create an entry /sys/firmware/NAME/(loading,data).
You can simply download the firmware by doing 
echo 1 > /sys/firmware/NAME/loading
cat rbu.image > /sys/firmware/NAME/data.
After this is done request_firmware returns and the image can be
actually 
copied to the device using fw->data and fw-size. 
Once this is complete the fw can be released.
Not sure why do I need a firmware image file in /lib/firmware?
Thanks,
Abhay

> -----Original Message-----
> From: Domsch, Matt
> Sent: Thursday, May 26, 2005 11:56 AM
> To: Salunke, Abhay
> Cc: greg@kroah.com; linux-kernel@vger.kernel.org; ranty@debian.org
> Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new
Dell
> BIOS update driver
> 
> On Thu, May 26, 2005 at 11:37:44AM -0500, Abhay_Salunke@Dell.com
wrote:
> > > -----Original Message-----
> > > From: Greg KH [mailto:greg@kroah.com]
> > > Sent: Monday, May 23, 2005 10:48 AM
> > > To: Salunke, Abhay
> > > Cc: linux-kernel@vger.kernel.org; akpm@osdl.org; Domsch, Matt
> > > Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for
new
> > Dell
> > > BIOS update driver
> > >
> > > On Mon, May 23, 2005 at 09:52:05AM -0500, Abhay_Salunke@Dell.com
> > wrote:
> > > > Greg,
> > > > >
> > > > > Also, what's wrong with using the existing firmware interface
in
> > the
> > > > > kernel?
> > > > request_firmware requires the $FIRMWARE env to be populated with
the
> > > > firmware image name or the firmware image name needs to be
hardcoded
> > > > within  the call to request_firmware. Since the user is free to
> > change
> > > > the BIOS update image at will, it may not be possible if we use
> > > > $FIRMWARE also I am not sure if this env variable might be
> > conflicting
> > > > to some other driver.
> > >
> > > As others have already stated, this doesn't really matter.  Make
it
> > > "dell_bios_update", if any device names their firmware that, well,
> > > that's their problem...
> >
> > OK, I have been trying to use request_firmware but it always fails
with
> > return code -2. This is the code snippet below, any thoughts?
> 
> -2 is -ENOENT, "No such file or directory".
> It's looking for a file called /lib/firmware/dell_rbu_type, and not
> finding it.  That probably isn't the name of the file you want it to
> look for.
> 
> Thanks,
> Matt
> 
> --
> Matt Domsch
> Software Architect
> Dell Linux Solutions linux.dell.com & www.dell.com/linux
> Linux on Dell mailing lists @ http://lists.us.dell.com

