Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277924AbRJRSjb>; Thu, 18 Oct 2001 14:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277949AbRJRSjW>; Thu, 18 Oct 2001 14:39:22 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:39320 "EHLO
	apone.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S277924AbRJRSjH>; Thu, 18 Oct 2001 14:39:07 -0400
Date: Thu, 18 Oct 2001 14:40:43 -0400
From: Bill Nottingham <notting@redhat.com>
To: Todd <todd@unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia64 gcc compile prob
Message-ID: <20011018144042.A2099@apone.devel.redhat.com>
Mail-Followup-To: Todd <todd@unm.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A41.4.33.0110181103240.31982-100000@aix07.unm.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.A41.4.33.0110181103240.31982-100000@aix07.unm.edu>; from todd@unm.edu on Thu, Oct 18, 2001 at 11:05:38AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Todd (todd@unm.edu) said: 
> scsi_ioctl.c: In function `scsi_ioctl_send_command':
> scsi_ioctl.c:366: Internal compiler error in rws_access_regno, at
> config/ia64/ia64.c:3689

It's a compiler bug; fixed in a later release (2.96-9x, 3.0).
Attached is a hack workaround patch.

Bill

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.3-ia64-compile.patch"

--- linux/drivers/scsi/scsi_ioctl.c.foo	Tue May 29 12:59:24 2001
+++ linux/drivers/scsi/scsi_ioctl.c	Tue May 29 12:58:01 2001
@@ -200,6 +200,7 @@
 	unsigned int needed, buf_needed;
 	int timeout, retries, result;
 	int data_direction;
+	int foo;
 
 	if (!sic)
 		return -EINVAL;
@@ -209,10 +210,12 @@
 	if (verify_area(VERIFY_READ, sic, sizeof(Scsi_Ioctl_Command)))
 		return -EFAULT;
 
-	if(__get_user(inlen, &sic->inlen))
+	foo = __get_user(inlen, &sic->inlen);
+	if (foo)
 		return -EFAULT;
 		
-	if(__get_user(outlen, &sic->outlen))
+	foo = __get_user(outlen, &sic->outlen);
+	if (foo)
 		return -EFAULT;
 
 	/*

--TB36FDmn/VVEgNH/--
