Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261430AbSJUPv7>; Mon, 21 Oct 2002 11:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261442AbSJUPv6>; Mon, 21 Oct 2002 11:51:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:23966 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261430AbSJUPv3>; Mon, 21 Oct 2002 11:51:29 -0400
Date: Mon, 21 Oct 2002 08:58:51 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 Call Trace
Message-ID: <20021021155851.GB1069@beaverton.ibm.com>
Mail-Followup-To: Gregoire Favre <greg@ulima.unil.ch>,
	linux-kernel@vger.kernel.org
References: <20021021093341.GG2917@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021021093341.GG2917@ulima.unil.ch>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregoire Favre [greg@ulima.unil.ch] wrote:
> Trace; c01d58fe <put_device+de/f0>
> Trace; c022ecf0 <sg_detach+c0/220>
> Trace; c022319c <scsi_host_chk_and_release+1ac/250>
> Trace; c0222f58 <scsi_tp_for_each_host+78/90>
> Trace; d9208d00 <END_OF_CODE+cd3fd/????>
> Trace; c0223adc <scsi_unregister_host+3c/90>
> Trace; d9208d00 <END_OF_CODE+cd3fd/????>
> Trace; c0222ff0 <scsi_host_chk_and_release+0/250>
> Trace; c011cb23 <qm_symbols+f3/1e0>
> Trace; d91ff5bf <END_OF_CODE+c3cbc/????>
> Trace; d9208d00 <END_OF_CODE+cd3fd/????>
> Trace; c011d123 <free_module+e3/f0>
> Trace; c011c3d3 <sys_delete_module+d3/2a0>
> Trace; c010786b <syscall_call+7/b>
> Trace; c01d58fe <put_device+de/f0>
> Trace; c022ae37 <sr_detach+47/80>
> Trace; c022319c <scsi_host_chk_and_release+1ac/250>
> Trace; c0222f58 <scsi_tp_for_each_host+78/90>
> Trace; d9208d00 <END_OF_CODE+cd3fd/????>
> Trace; c0223adc <scsi_unregister_host+3c/90>
> Trace; d9208d00 <END_OF_CODE+cd3fd/????>
> Trace; c0222ff0 <scsi_host_chk_and_release+0/250>
> Trace; c011cb23 <qm_symbols+f3/1e0>
> Trace; d91ff5bf <END_OF_CODE+c3cbc/????>
> Trace; d9208d00 <END_OF_CODE+cd3fd/????>
> Trace; c011d123 <free_module+e3/f0>
> Trace; c011c3d3 <sys_delete_module+d3/2a0>
> Trace; c010786b <syscall_call+7/b>

Gregoire,
	I posted a patch yesterday for this but it was in another
	thread. It is below. I will also post it in a new thread by
	itself.

-andmike
--
Michael Anderson
andmike@us.ibm.com

 sg.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

--- 1.30/drivers/scsi/sg.c	Fri Oct 18 11:27:30 2002
+++ edited/drivers/scsi/sg.c	Sun Oct 20 10:59:33 2002
@@ -1607,7 +1607,7 @@
 		sdp->de = NULL;
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_type);
 		device_remove_file(&sdp->sg_driverfs_dev, &dev_attr_kdev);
-		put_device(&sdp->sg_driverfs_dev);
+		device_unregister(&sdp->sg_driverfs_dev);
 		if (NULL == sdp->headfp)
 			vfree((char *) sdp);
 	}

