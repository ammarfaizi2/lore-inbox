Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289171AbSAGNDK>; Mon, 7 Jan 2002 08:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289181AbSAGNDB>; Mon, 7 Jan 2002 08:03:01 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:63419 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289171AbSAGNCw>;
	Mon, 7 Jan 2002 08:02:52 -0500
Subject: Re: bug in IBM ServeRAID driver?
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, petter wahlman <petter@bluezone.no>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF493DDACD.A19A0EAB-ON85256B3A.00476E26@raleigh.ibm.com>
From: "ServeRAID For Linux" <ipslinux@us.ibm.com>
Date: Mon, 7 Jan 2002 08:02:29 -0500
X-MIMETrack: Serialize by Router on D04NMS65/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 01/07/2002 08:02:29 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delayed response.   We have been snow-bound and shut-down
here for several days.   We will address this immediately.   Thanks for
bringing it to our attention.




                                                                                                 
                    Jens Axboe                                                                   
                    <axboe@suse.de       To:     petter wahlman <petter@bluezone.no>             
                    >                    cc:     linux-kernel@vger.kernel.org, ServeRAID For     
                                          Linux/Raleigh/IBM@IBMUS                                
                    01/03/2002           Subject:     Re: bug in IBM ServeRAID driver?           
                    03:06 PM                                                                     
                                                                                                 
                                                                                                 



On Thu, Jan 03 2002, petter wahlman wrote:
>
> While looking through linux-2.4.18pre1/drivers/scsi/ips.c I noticed that
> a spin_lock_irq is held while doing a possibly blocking operation.
> Can't this code livelock on SMP if datasize is set?
>
> linux-2.4.18pre1/drivers/scsi/ips.c
>
>    1778       /* reobtain the lock */
>    1779       spin_lock_irq(&io_request_lock);
>    1780
>    1781       /* command finished -- copy back */
>    1782       user_area = *((char **) &SC->cmnd[4]);
>    1783       kern_area = ha->ioctl_data;
>    1784       datasize = *((u_int32_t *) &SC->cmnd[8]);
>    1785
>    1786       if (datasize) {
>    1787          if (copy_to_user(user_area, kern_area, datasize) > 0) {
>    1788             DEBUG_VAR(1, "(%s%d) passthru failed - unable to
> copy out user data",
>    1789                       ips_name, ha->host_num);
>
>
> I am not subscribed to this list, so please CC me.

Yup, that's surely a nasty bug.

--
Jens Axboe




