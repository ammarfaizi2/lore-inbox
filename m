Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285720AbRLYSAK>; Tue, 25 Dec 2001 13:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbRLYSAA>; Tue, 25 Dec 2001 13:00:00 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63136 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S285720AbRLYR7t>;
	Tue, 25 Dec 2001 12:59:49 -0500
Date: Tue, 25 Dec 2001 12:59:48 -0500
From: Legacy Fishtank <garzik@havoc.gtf.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jason Thomas <jason@topic.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link errors with internal calls to devexit functions
Message-ID: <20011225125948.B21718@havoc.gtf.org>
In-Reply-To: <20011222025725.GA629@topic.com.au> <5750.1008997543@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5750.1008997543@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sat, Dec 22, 2001 at 04:05:43PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 04:05:43PM +1100, Keith Owens wrote:
> >--- linux-2.4.17.orig/drivers/media/video/bttv-driver.c Sat Dec 22 13:39:39 2001
> >+++ linux-2.4.17/drivers/media/video/bttv-driver.c      Sat Dec 22 13:46:02 2001
> >@@ -2992,7 +2992,9 @@
> >        pci_set_drvdata(dev,btv);
> > 
> >        if(init_bt848(btv) < 0) {
> >+#if defined(MODULE) || defined(CONFIG_HOTPLUG)
> >                bttv_remove(dev);
> >+#endif
> I don't like #if defined(MODULE) || defined(CONFIG_HOTPLUG) in open
> code.

1000.0% agreed


> 	__devexit_call(bttv_remove(dev));
> 	__devexit_call(uhci_pci_remove(dev));

ug...  Just use plain logic:  if a function is called from non-devexit
code, it should not be marked devexit.  That's the bug, we don't need
new API crud.

	Jeff


