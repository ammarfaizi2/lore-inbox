Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130231AbQLNE1I>; Wed, 13 Dec 2000 23:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbQLNE0t>; Wed, 13 Dec 2000 23:26:49 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:4114 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S130231AbQLNE0j>; Wed, 13 Dec 2000 23:26:39 -0500
Message-Id: <200012140356.eBE3u8s42047@aslan.scsiguy.com>
To: "Steven N. Hirsch" <shirsch@adelphia.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Wed, 13 Dec 2000 20:31:28 EST."
             <Pine.LNX.4.21.0012132029260.3736-100000@pii.fast.net> 
Date: Wed, 13 Dec 2000 20:56:08 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Thanks for posting this.  Unfortunately, the kernel won't build unless you
>restore this macro to the namespace after aic7xxx_linux.h blows it away:
>
>--- linux-2.2.18/drivers/scsi/hosts.c.orig	Wed Dec 13 20:27:34 2000
>+++ linux-2.2.18/drivers/scsi/hosts.c	Wed Dec 13 20:26:22 2000
>@@ -137,6 +137,7 @@
> 
> #ifdef CONFIG_SCSI_AIC7XXX
> #include "aic7xxx/aic7xxx_linux.h"
>+#define current get_current()
> #endif
> 
> #ifdef CONFIG_SCSI_IPS
>
>
>Steve

I take it you had other controllers enabled?  I tested this against
2.2.18-pre24 and didn't see any problems.  I didn't enable anything
other than the aic7xxx driver.

Luckily, in newer kernels, the per-controller includes are no longer
required in hosts.c.  None-the-less, it seems to me that spamming
the kernel namespace with "current" in at least the way that the
2.2 kernels do (does this occur in later kernels?) should be corrected.
As you can see from my comment in aic7xxx_linux.h, I was very surprised
to see this occur.

I'll update my patch tomorrow to restore the definition of current.
I do fear, however, that this will perpetuate the polution of the
namespace should "current" ever get cleaned up.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
