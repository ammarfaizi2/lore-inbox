Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbSJTSLH>; Sun, 20 Oct 2002 14:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSJTSLH>; Sun, 20 Oct 2002 14:11:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:57288 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263333AbSJTSLG>; Sun, 20 Oct 2002 14:11:06 -0400
Date: Sun, 20 Oct 2002 11:18:25 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi segfaults under 2.5.44
Message-ID: <20021020181825.GA3915@beaverton.ibm.com>
Mail-Followup-To: Thomas Molina <tmolina@cox.net>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210192229310.891-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210192229310.891-100000@dad.molina>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,
	It looks like sg.c was missed in the update from put_device to
	device_unregister.

I have only compile tested the patch below, but it should fix the
problem. I will have a chance to run later on today.


Thomas Molina [tmolina@cox.net] wrote:
> Oct 19 22:10:30 dad kernel:  [<d905f780>] 
> scsi_driverfs_bus_type_Rfc6baff9+0x0/0x80 [scsi_mod]
> Oct 19 22:10:30 dad kernel:  [<c01d0b78>] put_driver+0x28/0x50
> Oct 19 22:10:30 dad kernel:  [<d9097028>] sg_template+0x48/0xa0 [sg]
> Oct 19 22:10:30 dad kernel:  [<d90928ac>] exit_sg+0x4c/0x50 [sg]
> Oct 19 22:10:30 dad kernel:  [<d9097028>] sg_template+0x48/0xa0 [sg]
> Oct 19 22:10:30 dad kernel:  [<c0119e1e>] free_module+0x1e/0xb0
> Oct 19 22:10:30 dad kernel:  [<c01192f7>] sys_delete_module+0xe7/0x1c0
> Oct 19 22:10:30 dad kernel:  [<c0108adf>] syscall_call+0x7/0xb
> Oct 19 22:10:30 dad kernel:
-andmike
--
Michael Anderson
andmike@us.ibm.com

 sg.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

===== drivers/scsi/sg.c 1.30 vs edited =====
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
