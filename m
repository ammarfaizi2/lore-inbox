Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266351AbUHMRtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266351AbUHMRtF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 13:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbUHMRtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 13:49:05 -0400
Received: from [80.190.193.18] ([80.190.193.18]:10127 "EHLO mx.vsadmin.de")
	by vger.kernel.org with ESMTP id S266381AbUHMRrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 13:47:41 -0400
From: Stefan Meyknecht <sm0407@nurfuerspam.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] cdrom: MO-drive open write fix (trivial)
Date: Fri, 13 Aug 2004 19:47:39 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
References: <200408061833.30751.sm0407@nurfuerspam.de> <200408131917.48833.sm0407@nurfuerspam.de> <20040813172605.GA9673@suse.de>
In-Reply-To: <20040813172605.GA9673@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408131947.39836.sm0407@nurfuerspam.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
> On Fri, Aug 13 2004, Stefan Meyknecht wrote:
> > Jens Axboe <axboe@suse.de> wrote:
> > > Patch looks fine (last hunk is a little code, but that's not
> > > your fault). Thanks!
> >
> > Do you consider including the patch into 2.6.8 or is it too late?
> > Please mail me if something is missing or to resend.
>
> IMHO it's fine for 2.6.8, please resend the patch and CC Linus.


[PATCH] cdrom: MO-drive open write fix

This patch allows mounting MO-drives readwrite.



--- linux/drivers/cdrom/cdrom.c.orig	2004-08-07 14:02:28.958908544 +0200
+++ linux/drivers/cdrom/cdrom.c	2004-08-07 13:58:29.306167698 +0200
@@ -833,8 +833,11 @@ static int cdrom_open_write(struct cdrom
 	if (!cdrom_is_mrw(cdi, &mrw_write))
 		mrw = 1;
 
-	(void) cdrom_is_random_writable(cdi, &ram_write);
-
+	if (CDROM_CAN(CDC_MO_DRIVE))
+		ram_write = 1;
+	else
+		(void) cdrom_is_random_writable(cdi, &ram_write);
+	
 	if (mrw)
 		cdi->mask &= ~CDC_MRW;
 	else
@@ -855,7 +858,7 @@ static int cdrom_open_write(struct cdrom
 	else if (CDROM_CAN(CDC_DVD_RAM))
 		ret = cdrom_dvdram_open_write(cdi);
  	else if (CDROM_CAN(CDC_RAM) &&
- 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW))
+ 		 !CDROM_CAN(CDC_CD_R|CDC_CD_RW|CDC_DVD|CDC_DVD_R|CDC_MRW|CDC_MO_DRIVE))
  		ret = cdrom_ram_open_write(cdi);
 	else if (CDROM_CAN(CDC_MO_DRIVE))
 		ret = mo_open_write(cdi);

-- 
Stefan Meyknecht
stefan at meyknecht dot org
