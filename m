Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292592AbSBPXA7>; Sat, 16 Feb 2002 18:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSBPXAt>; Sat, 16 Feb 2002 18:00:49 -0500
Received: from zero.tech9.net ([209.61.188.187]:7941 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292592AbSBPXAd>;
	Sat, 16 Feb 2002 18:00:33 -0500
Subject: [PATCH] Re: 2.5: further llseek cleanup (3/3)
From: Robert Love <rml@tech9.net>
To: Manfred Spraul <manfred@colorfullife.com>, torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C6EDDCA.DAB884BD@colorfullife.com>
In-Reply-To: <3C6EDDCA.DAB884BD@colorfullife.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 16 Feb 2002 18:00:28 -0500
Message-Id: <1013900429.855.3.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-02-16 at 17:31, Manfred Spraul wrote:
> Hi Robert,
> 
> I think the pcilynx change is wrong:

Indeed.  Thank you, Manfred.

Linus, patch against 2.5.5-pre1 is attached.  Please, apply.

	Robert Love

diff -urN linux-2.5.5-pre1/drivers/ieee1394/pcilynx.c linux/drivers/ieee1394/pcilynx.c
--- linux-2.5.5-pre1/drivers/ieee1394/pcilynx.c	Wed Feb 13 18:18:46 2002
+++ linux/drivers/ieee1394/pcilynx.c	Sat Feb 16 17:58:47 2002
@@ -748,10 +748,11 @@
         }
 
         if (newoffs < 0 || newoffs > PCILYNX_MAX_MEMORY + 1) {
-                lock_kernel();
+                unlock_kernel();
                 return -EINVAL;
         }
 
+        unlock_kernel();
         file->f_pos = newoffs;
         return newoffs;
 }


