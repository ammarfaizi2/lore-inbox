Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286735AbRLVJFl>; Sat, 22 Dec 2001 04:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286738AbRLVJFZ>; Sat, 22 Dec 2001 04:05:25 -0500
Received: from d-dialin-1587.addcom.de ([62.96.165.155]:51183 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S286735AbRLVJE1>; Sat, 22 Dec 2001 04:04:27 -0500
Date: Sat, 22 Dec 2001 10:04:19 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Keith Owens <kaos@ocs.com.au>
cc: Jason Thomas <jason@topic.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link errors with internal calls to devexit functions 
In-Reply-To: <5750.1008997543@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112220953400.1352-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001, Keith Owens wrote:

> >diff -ur linux-2.4.17.orig/drivers/media/video/bttv-driver.c linux-2.4.17/drivers/media/video/bttv-driver.c
> >--- linux-2.4.17.orig/drivers/media/video/bttv-driver.c Sat Dec 22 13:39:39 2001
> >+++ linux-2.4.17/drivers/media/video/bttv-driver.c      Sat Dec 22 13:46:02 2001
> >@@ -2992,7 +2992,9 @@
> >        pci_set_drvdata(dev,btv);
> > 
> >        if(init_bt848(btv) < 0) {
> >+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
> >                bttv_remove(dev);
> >+#endif
> >                return -EIO;
> >        }
> >        bttv_num++;

> I don't like #if defined(MODULE) || defined(CONFIG_HOTPLUG) in open
> code.  If the rules for what gets discarded change (again) then those
> ifdefs will be out of sync.  That is why __devexit_p() is a wrapper, it
> is defined once and only has to be changed once when the rules change.
> 
> Define a __devexit_call wrapper in include/linux/init.h at the same
> place that __devexit_p is defined and use the wrapper around the calls.
> Untested.

I'd rather think that the patch (and the original code) is broken, as it
seems we call an __devexit function from an init function. So 
the correct fix is to remove the __devexit attribute from the offending 
functions.

--Kai



