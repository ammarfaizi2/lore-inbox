Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbQLNMvl>; Thu, 14 Dec 2000 07:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132366AbQLNMvb>; Thu, 14 Dec 2000 07:51:31 -0500
Received: from smtprelay.abs.adelphia.net ([64.8.20.11]:20887 "EHLO
	smtprelay1.abs.adelphia.net") by vger.kernel.org with ESMTP
	id <S132109AbQLNMvV>; Thu, 14 Dec 2000 07:51:21 -0500
Date: Thu, 14 Dec 2000 07:26:35 -0500 (EST)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: <200012140356.eBE3u8s42047@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.21.0012140723100.26553-100000@pii.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2000, Justin T. Gibbs wrote:

> >Thanks for posting this.  Unfortunately, the kernel won't build unless you
> >restore this macro to the namespace after aic7xxx_linux.h blows it away:
> >
> >--- linux-2.2.18/drivers/scsi/hosts.c.orig	Wed Dec 13 20:27:34 2000
> >+++ linux-2.2.18/drivers/scsi/hosts.c	Wed Dec 13 20:26:22 2000
> >@@ -137,6 +137,7 @@
> > 
> > #ifdef CONFIG_SCSI_AIC7XXX
> > #include "aic7xxx/aic7xxx_linux.h"
> >+#define current get_current()
> > #endif
> > 
> > #ifdef CONFIG_SCSI_IPS
> >
> >
> >Steve
> 
> I take it you had other controllers enabled?  I tested this against
> 2.2.18-pre24 and didn't see any problems.  I didn't enable anything
> other than the aic7xxx driver.

Yes, I have an IBM ServeRaid controller in addition to the on-board
7890.  Any includes which lexically follow your new aic7xxx driver in
hosts.c will be similarly affected.

> Luckily, in newer kernels, the per-controller includes are no longer
> required in hosts.c.  None-the-less, it seems to me that spamming
> the kernel namespace with "current" in at least the way that the
> 2.2 kernels do (does this occur in later kernels?) should be corrected.
> As you can see from my comment in aic7xxx_linux.h, I was very surprised
> to see this occur.
> 
> I'll update my patch tomorrow to restore the definition of current.
> I do fear, however, that this will perpetuate the polution of the
> namespace should "current" ever get cleaned up.

I won't wade into this controversy (sick of dimpled chads, I guess).

Steve

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
