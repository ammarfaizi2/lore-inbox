Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289667AbSA2PEM>; Tue, 29 Jan 2002 10:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289697AbSA2PDw>; Tue, 29 Jan 2002 10:03:52 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26012 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289667AbSA2PDq>; Tue, 29 Jan 2002 10:03:46 -0500
Subject: RE: Encountered a Null Pointer Problem on the SCSI Layer
To: Jesper Juhl <jju@dif.dk>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@suse.de>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFE618C04F.50767A0E-ON85256B50.0000887B@raleigh.ibm.com>
From: "Peter Wong" <wpeter@us.ibm.com>
Date: Tue, 29 Jan 2002 09:03:42 -0600
X-MIMETrack: Serialize by Router on D04NM203/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/29/2002 10:03:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper,

     Let's use sd_find_queue() as an example.

     If the array pointed by rscsi_disk has been allocated,
dpnt cannot be null.

     If rscsi_disk has not been allocated, dpnt = &rscsi_disks[target]
may not be null depending on the value of target. Thus, "if (!dpnt)"
is not sufficient anyway.

     You can also look at sd_attach(), in which "if (!dpnt->device)" is
tested, not "if (!dpnt)".

Regards,
Peter

Wai Yee Peter Wong
IBM Linux Technology Center, Performance Analysis
email: wpeter@us.ibm.com



                                                                                                                                       
                      Jesper Juhl                                                                                                      
                      <jju@dif.dk>             To:       "'Pete Zaitcev '" <zaitcev@redhat.com>, Peter Wong/Austin/IBM@IBMUS,          
                                                "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>                       
                      01/28/02 05:57 PM        cc:       "'Jens Axboe '" <axboe@suse.de>                                               
                                               Subject:  RE: Encountered a Null Pointer Problem on the SCSI Layer                      
                                                                                                                                       
                                                                                                                                       
                                                                                                                                       






> -       if (!dpnt)
> +       if (!dpnt->device)
>                 return NULL;    /* No such device */


Maybe I don't understand this right, but shouldn't that be


if (!dpnt || !dpnt->device)
        return NULL;    /* No such device */


?






Best regards,
Jesper Juhl
jju@dif.dk






