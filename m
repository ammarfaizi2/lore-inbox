Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbTK3RRt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264950AbTK3RRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:17:49 -0500
Received: from gprs151-64.eurotel.cz ([160.218.151.64]:4225 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264949AbTK3RRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:17:46 -0500
Date: Sun, 30 Nov 2003 18:18:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       kernel list <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: FYI: My current suspend bigdiff
Message-ID: <20031130171833.GB516@elf.ucw.cz>
References: <20031128171323.GG303@elf.ucw.cz> <3FC7860C.2060505@gmx.de> <20031128173312.GH303@elf.ucw.cz> <3FC789F5.2000208@gmx.de> <20031128175503.GB18072@elf.ucw.cz> <3FC7908A.9030007@gmx.de> <20031128235623.GB18147@elf.ucw.cz> <3FC8C0DB.9050107@gmx.de> <20031129172537.GB459@elf.ucw.cz> <3FC9C560.2070902@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FC9C560.2070902@gmx.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Well... it could work with scsi. You can try it, but be carefull. [If
> >it goes wrong it might eat your data.]
> 
> Thats why I use xfs on my main system to test... And I tried with libata 
> and it won't work as it complains that the "katad" process cannot be 
> stopped, so swsusp immediatly comes back.

I do not know how much more support is needed to allow powermanagment
for libata, but this one should be easy...

[Hmm, I hope it compiles, I certainly do not use libata for now.]
								Pavel

--- clean/drivers/scsi/libata-core.c	2003-11-28 17:06:39.000000000 +0100
+++ linux/drivers/scsi/libata-core.c	2003-11-30 18:16:02.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
+#include <linux/suspend.h>
 #include <scsi/scsi.h>
 #include "scsi.h"
 #include "hosts.h"
@@ -2564,6 +2565,8 @@
 
         while (1) {
 		cond_resched();
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
 
 		timeout = ata_thread_iter(ap);
 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
