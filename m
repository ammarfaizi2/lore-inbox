Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271144AbRHOLXi>; Wed, 15 Aug 2001 07:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271148AbRHOLX2>; Wed, 15 Aug 2001 07:23:28 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:46089 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S271144AbRHOLXT>; Wed, 15 Aug 2001 07:23:19 -0400
Date: Wed, 15 Aug 2001 13:17:33 +0200
From: Jens Axboe <axboe@suse.de>
To: "Joseph N. Hall" <joseph@5sigma.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 4.7GB DVD-RAM geometry wrong?
Message-ID: <20010815131733.I545@suse.de>
In-Reply-To: <20010815111030Z271139-761+1405@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <20010815111030Z271139-761+1405@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 15 2001, Joseph N. Hall wrote:
> I don't know if I'm doing this the right way or not.  I did spend an hour
> or three googling for "linux dvd-ram" and the like, and all I came up with
> was a bunch of 2.2-specific stuff, until I found a usenet posting that
> said in effect "you can write to /dev/scd0".  So I gave that a try
> and it worked.  Sort of.
> 
> I have a Panasonic DVD-RAM, LF-D201 (SCSI 4.7/9.4GB).  I put in a
> 4.7GB type II cartridge (that's a single-sided disk), did 'mkfs 
> /dev/scd0' and then mounted it, and ... I have a 2.2GB disk!

Attached patch should fix it, Linus please apply.

-- 
Jens Axboe


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sr_cap-1

--- /opt/kernel/linux-2.4.9-pre4/drivers/scsi/sr_ioctl.c	Thu Jul  5 20:28:17 2001
+++ drivers/scsi/sr_ioctl.c	Wed Aug 15 13:15:21 2001
@@ -545,7 +545,7 @@
 
 	switch (cmd) {
 	case BLKGETSIZE:
-		return put_user(scsi_CDs[target].capacity >> 1, (long *) arg);
+		return put_user(scsi_CDs[target].capacity, (long *) arg);
 	case BLKROSET:
 	case BLKROGET:
 	case BLKRASET:

--Rgf3q3z9SdmXC6oT--
