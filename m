Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287115AbRL2Dyi>; Fri, 28 Dec 2001 22:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287113AbRL2Dy2>; Fri, 28 Dec 2001 22:54:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:20243 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287116AbRL2DyX>; Fri, 28 Dec 2001 22:54:23 -0500
Message-ID: <3C2D3DBB.6ADE1CC5@zip.com.au>
Date: Fri, 28 Dec 2001 19:51:23 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: timothy.covell@ashavan.org
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        support@redhat.com
Subject: Re: Fwd: Hard Lockup on 2.4.16 with Via ieee1394 (sbp2 mode)
In-Reply-To: <200112290321.fBT3GCSs007627@svr3.applink.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell wrote:
> 
> lockup
> ...
> sbp2
> ...
> SMP
> ...

--- linux-2.4.17-pre8/drivers/ieee1394/sbp2.c	Mon Dec 10 13:46:20 2001
+++ linux-akpm/drivers/ieee1394/sbp2.c	Wed Dec 12 20:50:16 2001
@@ -2773,7 +2773,9 @@ static void sbp2scsi_complete_command(st
 	/*
 	 * Tell scsi stack that we're done with this command
 	 */
+	spin_lock_irq(&io_request_lock);
 	done (SCpnt);
+	spin_unlock_irq(&io_request_lock);
 
 	return;
 }

-
