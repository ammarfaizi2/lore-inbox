Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131495AbRAOVQY>; Mon, 15 Jan 2001 16:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131502AbRAOVQE>; Mon, 15 Jan 2001 16:16:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20234 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131495AbRAOVQE>;
	Mon, 15 Jan 2001 16:16:04 -0500
Date: Mon, 15 Jan 2001 22:15:53 +0100
From: Jens Axboe <axboe@suse.de>
To: mmaciaszek@gmx.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: vmware 2.0.3, kernel 2.4.0 and a cdrom
Message-ID: <20010115221553.A9977@suse.de>
In-Reply-To: <20010114204948.A10017@nexus.shadowrun.not>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20010114204948.A10017@nexus.shadowrun.not>; from mmaciaszek@gmx.net on Sun, Jan 14, 2001 at 08:49:48PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 14 2001, Martin Maciaszek wrote:
> Since I installed Kernel 2.4.0 VMware is no longer able to
> recognize my cdrom drive. VMware shows a dialog box on power up
> with following content:
> [...]
> CDROM: '/dev/scd0' exists, but does not appear tobe a CDROM device.
> 
> Error connecting the CDROM device
> [...]
> 
> At the same time my syslog records the following message:
> Jan 13 21:49:57 nexus kernel: sr0: CDROM (ioctl) reports ILLEGAL REQUEST.
> 
> I tried 2.2.18 and VMware recognized the cdrom drive.

Could you try with this patch, so maybe we can get some hints as to what
is going on?

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sr_debug-1

--- /opt/kernel/linux-2.4.0-ac9/drivers/scsi/sr_ioctl.c	Fri Dec 29 23:07:22 2000
+++ drivers/scsi/sr_ioctl.c	Mon Jan 15 22:14:59 2001
@@ -161,10 +161,10 @@
 			} else {
 				err = -EINVAL;
 			}
-#ifdef DEBUG
-			print_command(sr_cmd);
-			print_req_sense("sr", SRpnt);
-#endif
+			if (!quiet) {
+				print_command(sr_cmd);
+				print_req_sense("sr", SRpnt);
+			}
 			break;
 		default:
 			printk(KERN_ERR "sr%d: CDROM (ioctl) error, command: ", target);

--HcAYCG3uE/tztfnV--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
