Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288294AbSACUHo>; Thu, 3 Jan 2002 15:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288295AbSACUHe>; Thu, 3 Jan 2002 15:07:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30481 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288294AbSACUHY>;
	Thu, 3 Jan 2002 15:07:24 -0500
Date: Thu, 3 Jan 2002 21:06:53 +0100
From: Jens Axboe <axboe@suse.de>
To: petter wahlman <petter@bluezone.no>
Cc: linux-kernel@vger.kernel.org, ipslinux@us.ibm.com
Subject: Re: bug in IBM ServeRAID driver?
Message-ID: <20020103210653.H8673@suse.de>
In-Reply-To: <1010087472.9561.0.camel@BadEip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1010087472.9561.0.camel@BadEip>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

