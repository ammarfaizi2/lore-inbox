Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbVIMS0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbVIMS0I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVIMS0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:26:07 -0400
Received: from wdscexfe01.sc.wdc.com ([129.253.170.53]:2514 "EHLO
	wdscexfe01.sc.wdc.com") by vger.kernel.org with ESMTP
	id S964961AbVIMS0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:26:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2.6.13] scsi: sd fails to copy cmd_len on SG_IO
Date: Tue, 13 Sep 2005 11:26:06 -0700
Message-ID: <CA45571DE57E1C45BF3552118BA92C9D69BDDB@WDSCEXBECL03.sc.wdc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13] scsi: sd fails to copy cmd_len on SG_IO
Thread-Index: AcW4i3zYCZuaPCHrS2GLcW45b1ZePAABKsjg
From: "Timothy Thelin" <Timothy.Thelin@wdc.com>
To: "Mike Christie" <michaelc@cs.wisc.edu>
Cc: "James Bottomley" <James.Bottomley@SteelEye.com>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
X-OriginalArrivalTime: 13 Sep 2005 18:26:03.0391 (UTC) FILETIME=[992298F0:01C5B890]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Christie [mailto:michaelc@cs.wisc.edu]
> Sent: Tuesday, September 13, 2005 10:49 AM
> To: Timothy Thelin
> Cc: James Bottomley; SCSI Mailing List; Linux Kernel; Andrew Morton
> Subject: Re: [PATCH 2.6.13] scsi: sd fails to copy cmd_len on SG_IO
> 
> 
> Timothy Thelin wrote:
> > This fixes an issue when doing SG_IO on an sd device: the
> > sd driver fails to copy the request's cmd_len to the scsi
> > command's cmd_len when initializing the command.
> > 
> 
> Do you need the same fix to st, sr, and scsi_lib (in the 
> scsi_generic_done path)?
> 

I just looked, and st and sr look like they need the same fix, but i'm
unaware of where scsi_lib might need it (I'm new to the Linux scsi stack).
Mind elaborating on your thoughts of the scsi_generic_done path? (I cant
find
the symbol in drivers/scsi/*)


> > Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>
> > 
> > --- linux-2.6.13.orig/drivers/scsi/sd.c	2005-08-28 
> 16:41:01.000000000 -0700
> > +++ linux-2.6.13/drivers/scsi/sd.c	2005-09-13 
> 09:39:06.000000000 -0700
> > @@ -236,6 +236,7 @@ static int sd_init_command(struct scsi_c
> >  			return 0;
> >  
> >  		memcpy(SCpnt->cmnd, rq->cmd, sizeof(SCpnt->cmnd));
> > +		SCpnt->cmd_len = rq->cmd_len;
> >  		if (rq_data_dir(rq) == WRITE)
> >  			SCpnt->sc_data_direction = DMA_TO_DEVICE;
> >  		else if (rq->data_len)
> > -
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
