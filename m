Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269452AbRGaUAQ>; Tue, 31 Jul 2001 16:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269450AbRGaUAG>; Tue, 31 Jul 2001 16:00:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11173 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269451AbRGaT77>; Tue, 31 Jul 2001 15:59:59 -0400
Date: Tue, 31 Jul 2001 12:59:26 -0700
From: Mike Anderson <mike.anderson@us.ibm.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Jeremy Higdon <jeremy@classic.engr.sgi.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
Message-ID: <20010731125926.B10914@us.ibm.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Jeremy Higdon <jeremy@classic.engr.sgi.com>,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca> <rgooch@ras.ucalgary.ca> <10107310041.ZM233282@classic.engr.sgi.com> <200107311225.f6VCPj003249@mobilix.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200107311225.f6VCPj003249@mobilix.ras.ucalgary.ca>; from rgooch@ras.ucalgary.ca on Tue, Jul 31, 2001 at 08:25:45AM -0400
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Richard Gooch [rgooch@ras.ucalgary.ca] wrote:
> Jeremy Higdon writes:
> > With the sard patch and a 64 bit system, you start having
> > trouble at around 103 configured disks, because of the following
> 
> So even without my patch, sard doesn't support the previous limit of
> 128 devices.
> 
> > line in sd_init() (sd.c), because kmalloc doesn't like allocating
> > large chunks of memory:
> > 
> >         sd = kmalloc((sd_template.dev_max << 4) *
> >                                           sizeof(struct hd_struct),
> >                                           GFP_ATOMIC);
> > 
> > Without sard, you'd have problems past 512 disks.
> 
> Yes, when I was coding up the patch I noticed the use of GFP_ATOMIC in
> the allocation calls. I have two questions:
> - can we use GFP_KERNEL instead (why use GFP_ATOMIC)
> - can we switch to vmalloc() instead of kmalloc()?

In previous experiments trying to connect up to 512 devices we switched to
vmalloc because the static nature of sd.c's allocation exceeds 128k which
I assumed was the max for kmalloc YMMV.

> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org

-Mike
-- 
Michael Anderson
mike.anderson@us.ibm.com

