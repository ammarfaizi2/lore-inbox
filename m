Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266647AbRGJQRx>; Tue, 10 Jul 2001 12:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266644AbRGJQRo>; Tue, 10 Jul 2001 12:17:44 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:55534 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266642AbRGJQRc>; Tue, 10 Jul 2001 12:17:32 -0400
Date: Tue, 10 Jul 2001 09:17:15 -0700
From: Mike Anderson <mike.anderson@us.ibm.com>
To: Eddie Williams <Eddie.Williams@steeleye.com>
Cc: Douglas Gilbert <dougg@torque.net>,
        "Cress, Andrew R" <andrew.r.cress@intel.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4.3] scsi logging
Message-ID: <20010710091715.B24861@us.ibm.com>
Mail-Followup-To: Eddie Williams <Eddie.Williams@steeleye.com>,
	Douglas Gilbert <dougg@torque.net>,
	"Cress, Andrew R" <andrew.r.cress@intel.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <dougg@torque.net> <200107101335.f6ADZ4f01436@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200107101335.f6ADZ4f01436@localhost.localdomain>; from Eddie.Williams@steeleye.com on Tue, Jul 10, 2001 at 09:35:04AM -0400
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
While I would like to see scsi scan pick up / print  serial numbers or a
form of device UUID  I have to agree with Eddie that this patch would only
provide data for devices that decided to fill in the vendor specific area
of the standard inquiry page.

A more generic solution would involve two more inquiry commands to the
device using the EVPD bit. The first would be to request page 0 and then
working from highest to lowest use page 0x83, 0x80, stanard inquiry page
(vendor, product, serial). In some cases though with really old devices
this still might not generate useful information.

-Mike

Eddie Williams [Eddie.Williams@steeleye.com] wrote:
> 
>  .. Snip ...
> Getting back to your first comment (sorry I have already deleted your initial 
> mail) did you provide the patch for getting the serial number?  Note that 
> getting the serial number is not a required SCSI feature so you wont get 100% 
> of the devices.
> 
> Eddie Williams
> 
> > Andrew wrote:
> > > I'd like to propose the following patch to 3 SCSI mid-layer 
> > > files from kernel 2.4.3.  I have tested this with 2.4.3, 
> > > but it should be relevant to other 2.4.x kernels also.
> > > 
> > > It has the following changes/enhancements:
> > > 1) Log the disk serial number during scsi_scan() 
> > >    - scsi_scan.c.
> > >    Why: This is a requirement in some environments to 
> > >    ensure unambiguous identification of a particular 
> > >    problem disk.
> > > 2) Interpret additional values in print_sense_internal()
> > >    - constants.c.  Why: The detail wrt Illegal Requests 
> > >    is very useful, since it can indicate either an 
> > >    application bug or an incompatible feature of the device.
> > > 3) Don't skip logging sense errors for sg functions - sg.c.
> > >    Why: All sense errors should be logged so that a 
> > >    potential scsi device hardware problem doesn't go
> > >    unrecognized.
> > 
> > Andrew,
> > I would object to point 3). SANE, and to a lesser extent
> > cdrecord, execute lots of commands that give SCSI check
> > conditions and would bloat the log and the console with
> > many serious looking messages. Those error 
> > indications are conveyed back to the app via the sg 
> > interface so the information is not lost. There is an 
> > ioctl in the sg driver [SG_SET_DEBUG] to turn on that 
> > output to the log/console [the default is off (to
> > stop the curious querying the maintainer about the
> > strange messages in their logs)].
> > 
> > Doug Gilbert
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> > the body of a message to majordomo@vger.kernel.org
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Michael Anderson
mike.anderson@us.ibm.com

