Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286220AbRLTM2i>; Thu, 20 Dec 2001 07:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286222AbRLTM22>; Thu, 20 Dec 2001 07:28:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23816 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S286220AbRLTM2R>;
	Thu, 20 Dec 2001 07:28:17 -0500
Date: Thu, 20 Dec 2001 13:28:05 +0100
From: Jens Axboe <axboe@suse.de>
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'eject' process stuck in "D" state
Message-ID: <20011220132805.D710@suse.de>
In-Reply-To: <20011220111249.GA15692@wizard.com> <20011220122325.A710@suse.de> <20011220113654.GA1271@wizard.com> <20011220123904.B710@suse.de> <20011220120750.GA1429@wizard.com> <20011220131116.C710@suse.de> <20011220122414.GA507@wizard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20011220122414.GA507@wizard.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 20 2001, A Guy Called Tyketto wrote:
>         Just getting to that. as I brought down the box, I got some errors on 
> /dev/tty1, which are the same from dmesg. 'ere ya go.

Ah, please try this patch.

-- 
Jens Axboe


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-cd-block-pc-1

diff -ur -X exclude /opt/kernel/linux-2.5.1/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- /opt/kernel/linux-2.5.1/drivers/ide/ide-cd.c	Sat Dec  8 23:02:47 2001
+++ linux/drivers/ide/ide-cd.c	Thu Dec 20 07:25:26 2001
@@ -594,7 +594,7 @@
 		cdrom_end_request (1, drive);
 		*startstop = ide_error (drive, "request sense failure", stat);
 		return 1;
-	} else if (rq->flags & REQ_PC) {
+	} else if (rq->flags & (REQ_PC | REQ_BLOCK_PC)) {
 		/* All other functions, except for READ. */
 		struct completion *wait = NULL;
 		pc = (struct packet_command *) rq->special;

--yrj/dFKFPuw6o+aM--
