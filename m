Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129327AbRBLOm1>; Mon, 12 Feb 2001 09:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129404AbRBLOmR>; Mon, 12 Feb 2001 09:42:17 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:56328 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S129327AbRBLOl6>; Mon, 12 Feb 2001 09:41:58 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E95260@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'myg@nolab.conman.org'" <myg@nolab.conman.org>
Cc: Peter Jarrett <Peterj@ami.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Bug in AMI Raid controller, Linux 2.4
Date: Mon, 12 Feb 2001 09:37:26 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This is because the 2.2.XX contains the a later version of the
driver when compared to 2.4.1 kernel. I have submitted to Linus and Alan the
1.14g version of the driver which works for 2.2.XX and contains special code
for 2.4.XX kernels.
	As the file is too large for me post to LKML i have submitted the
patch to Linus and Alan which i guess will be in the next incremental
release of both 2.2.19 and 2.4.1-pre?
	Thanks,
	Venkatesh

> -----Original Message-----
> From: Mark Grosberg [mailto:myg@nolab.conman.org]
> Sent: Saturday, February 10, 2001 8:39 PM
> To: linux-kernel@vger.kernel.org
> Subject: Bug in AMI Raid controller, Linux 2.4
> 
> 
> 
> Hello all, forgive me if this has already been discovered...
> 
> I think I have found a bug in the AMI Megatrends RAID controller driver,
> scsi/megaraid.c.
> 
> If I look in the old, 2.2.x code, in the routine mega_findCard, I find:
> 
>     if (flag != BOARD_QUARTZ) {
>       /* Request our IO Range */
>       if (check_region (megaBase, 16)) {
>         printk (KERN_WARNING "megaraid: Couldn't register I/O range!" ...
>         scsi_unregister (host);
>         continue;
>       }
>      request_region (megaBase, 16, "megaraid");
> 
> And in the 2.4.1 code, same routine, I find:
> 
>          if (flag != BOARD_QUARTZ) {
>       /* Request our IO Range */
>       if (request_region (megaBase, 16, "megaraid")) {
>         printk (KERN_WARNING "megaraid: Couldn't register I/O range!" ...
>         scsi_unregister (host);
>         continue;
>       }
>     }
> 
> I think the code is missing a "!" in front of request_region(). It seems
> that the 2.4.1 kernel does not recognize my RAID controller where as
> 2.2.x does. 
> 
> L8r,
> Mark G.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
