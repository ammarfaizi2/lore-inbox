Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSGLLDg>; Fri, 12 Jul 2002 07:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSGLLDf>; Fri, 12 Jul 2002 07:03:35 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:37631 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S315928AbSGLLDe>;
	Fri, 12 Jul 2002 07:03:34 -0400
Date: Fri, 12 Jul 2002 13:06:20 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH] 2.4 IDE core for 2.5, #2 (was Re: [PATCH] 2.4 IDE core for 2.5)
Message-ID: <20020712110620.GA14338@win.tue.nl>
References: <20020709102249.GA20870@suse.de> <20020709200711.GA13401@win.tue.nl> <20020710054356.GE3185@suse.de> <20020710111115.GJ3185@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710111115.GJ3185@suse.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 01:11:15PM +0200, Jens Axboe wrote:

> Care to try the next version? I've completely disabled task file i/o
> since it does seem to be broken in pio, and fixed the multi-write
> multi-page bio bug as well. There are a number of other changes in
> there. There are split patches like last time, but also one big patch:
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.25/
> 
> ide24-for-2.5-2
> 	all of the above

Had no time until now, but just tried ide24-for-2.5-3.
It did not compile, but after adding 05_25pci-ids-1a it did.
Also added

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c       Mon Jun 17 19:35:40 2002
+++ b/drivers/usb/host/uhci-hcd.c       Fri Jun 21 22:44:35 2002
@@ -2428,7 +2428,7 @@
        return retval;
 }
 
-static void __devexit uhci_stop(struct usb_hcd *hcd)
+static void uhci_stop(struct usb_hcd *hcd)
 {
        struct uhci_hcd *uhci = hcd_to_uhci(hcd);
 
@@ -2509,7 +2509,7 @@
        suspend:                uhci_suspend,
        resume:                 uhci_resume,
 #endif
-       stop:                   __devexit_p(uhci_stop),
+       stop:                   uhci_stop,
 
        hcd_alloc:              uhci_hcd_alloc,
        hcd_free:               uhci_hcd_free,

to prevent oopses at shutdown.

The resulting kernel seems to work. Tried it only for a short time,
but maybe long enough to be confident.

[Yesterday, or the day before I installed a new distribution.
Unfortunately there are vendor modifications to kernel and
user space software, so replacing the kernel by a vanilla one
does not yield a functioning system; will also have to replace
some vendor user space stuff by vanilla stuff.]

Andries
