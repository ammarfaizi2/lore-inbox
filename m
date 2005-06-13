Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVFMQit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVFMQit (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVFMQit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:38:49 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:14923 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261812AbVFMQgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:36:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=l25GWaRaSpWRpUjlZeT0KMTCMJr81n3eTkfxFIqwQrKR3ixr/BnO1FUqF2OSYIPtktiufaDzjLwv1vJC4ftzszECCUQb7+ySVTCFs1u5qrgd6I++jG8+nX0xUDSw+cR/07Wo9dUT8TDecEiEl1olyPnqaTrzIubUDf3NSPD6crM=
Message-ID: <42ACEB1A.6070700@gmail.com>
Date: Mon, 13 Jun 2005 02:10:34 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Real-Time Preemption, using msecs_to_jiffies() instead
 of HZ
References: <42A9C2E0.30002@gmail.com> <20050611133246.GA29414@elte.hu>
In-Reply-To: <20050611133246.GA29414@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar ha scritto:
> oops, indeed. (i've also forwarded your patch to akpm, as the softlockup 
> patch is included in -mm too)

OK, thank you!


I also found another couple of those in drivers/char/rtc.c file.
Here is a quick fix:

--- ./rtp-2.6.12-rc6-V0.7.48-17.orig	2005-06-13 01:26:53.000000000 +0000
+++ ./rtp-2.6.12-rc6-V0.7.48-17		2005-06-13 01:58:13.000000000 +0000
@@ -17044,7 +17044,7 @@
 -			barrier();
 -			cpu_relax();
 -		}
-+		msleep(2*HZ/100);
++		msleep(20);
  	
  	spin_lock_irq(&rtc_lock);
  	year = CMOS_READ(RTC_YEAR);
@@ -17102,7 +17102,7 @@
 -			barrier();
 -			cpu_relax();
 -		}
-+		msleep(2*HZ/100);
++		msleep(20);

  	/*
  	 * Only the values that we read from the RTC are set. We leave

Regards,
-- 
					Luca

