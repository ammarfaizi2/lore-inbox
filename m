Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277191AbRJRGQX>; Thu, 18 Oct 2001 02:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276489AbRJRGQN>; Thu, 18 Oct 2001 02:16:13 -0400
Received: from fe030.worldonline.dk ([212.54.64.197]:37643 "HELO
	fe030.worldonline.dk") by vger.kernel.org with SMTP
	id <S277191AbRJRGPy>; Thu, 18 Oct 2001 02:15:54 -0400
Date: Thu, 18 Oct 2001 08:16:09 +0200
From: Jens Axboe <axboe@suse.de>
To: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE CDROM problems -- No medium found -- 2.4.12-ac3
Message-ID: <20011018081609.D4048@suse.de>
In-Reply-To: <20011017161506.C930@wirex.com> <87k7xt7r1d.fsf@kosh.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <87k7xt7r1d.fsf@kosh.ultra.csn.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 18 2001, Enrico Scholz wrote:
> sarnold@wirex.com (Seth Arnold) writes:
> 
> > [...]
> > mount will sometimes give:
> > [...]
> > $ mount /mnt/cdrom
> > mount: No medium found
> 
> ide-cd.c is broken since 2.4.1 and gives bad status reports on most
> ATAPI drives. Perhaps the attached patch helps...

I just sent the right diff to Linus and Alan some days ago, it should
look like this.

-- 
Jens Axboe


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-cd-tray-1

--- /opt/kernel/linux-2.4.10-pre11/drivers/ide/ide-cd.c	Thu Aug 16 18:30:45 2001
+++ drivers/ide/ide-cd.c	Mon Oct 15 18:54:52 2001
@@ -2409,7 +2409,7 @@
 		 * any other way to detect this...
 		 */
 		if (sense.sense_key == NOT_READY) {
-			if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
+			if (sense.asc == 0x3a && sense.ascq == 1)
 				return CDS_NO_DISC;
 			else
 				return CDS_TRAY_OPEN;

--jRHKVT23PllUwdXP--
