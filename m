Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbTEPU6g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 16:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTEPU6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 16:58:35 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:28612 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264386AbTEPU6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 16:58:35 -0400
Date: Fri, 16 May 2003 14:06:35 -0700
From: Andrew Morton <akpm@digeo.com>
To: Alistair Strachan <alistair@devzero.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm6
Message-Id: <20030516140635.07f5e843.akpm@digeo.com>
In-Reply-To: <200305162035.50063.alistair@devzero.co.uk>
References: <200305162035.50063.alistair@devzero.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 21:11:22.0441 (UTC) FILETIME=[B3D04390:01C31BEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Strachan <alistair@devzero.co.uk> wrote:
>
> Just a quick note to alert you to a problem versus 2.5.69 virgin. In 
> dmesg, I see the following:
> 
> failed to register PPP device (0)

ah, thanks.  Easily fixed.

diff -puN drivers/net/ppp_generic.c~ppp-warning-fix drivers/net/ppp_generic.c
--- 25/drivers/net/ppp_generic.c~ppp-warning-fix	Fri May 16 14:04:48 2003
+++ 25-akpm/drivers/net/ppp_generic.c	Fri May 16 14:05:00 2003
@@ -803,7 +803,7 @@ int __init ppp_init(void)
 				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
 	}
 
-	if (!err)
+	if (err)
 		printk(KERN_ERR "failed to register PPP device (%d)\n", err);
 	return err;
 }

_

