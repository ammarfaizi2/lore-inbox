Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129067AbRBHWFf>; Thu, 8 Feb 2001 17:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129945AbRBHWF0>; Thu, 8 Feb 2001 17:05:26 -0500
Received: from cs.columbia.edu ([128.59.16.20]:11191 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129441AbRBHWFR>;
	Thu, 8 Feb 2001 17:05:17 -0500
Date: Thu, 8 Feb 2001 14:05:07 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
        <jes@linuxcare.com>, Donald Becker <becker@scyld.com>
Subject: Re: [PATCH] starfire reads irq before pci_enable_device.
In-Reply-To: <3A8311D8.C8C81E95@mandrakesoft.com>
Message-ID: <Pine.LNX.4.30.0102081355520.31024-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Jeff Garzik wrote:

> Well at least let's do it the Linux Kernel Way(tm):  separate out the
> zerocopy stuff such that there are minimal ifdefs in the code...  For
> example:
> 
> 	/* add these functions... */
> 	#ifdef ZEROCOPY
> 	static inline setup_txrx_rings(...) { /*...*/ }
> 	#else
> 	static inline setup_txrx_rings(...) { /*...*/ }
> 	#endif
> 
> then in the code itself, where the TxRx ring setup occurs now (ie. where
> ifdefs exist in the code) simply call the new static inline functions.

Hmm. Ok. I'll think about it. Roughly 1/3 of the driver code will be 
duplicated if we go this route with the existing structure. I'll try to 
make use of a few helper inline functions which are smaller and can be 
ifdef'ed without much code duplication.

> The #ifdef ZEROCOPY code you added is a classic example of the kind of
> code I -remove- from the kernel tree.

It's an issue of maintainer convenience vs. esthetics. And (last but not 
least) it's also about other people's ability to easily make changes to 
the driver, changes they can understand and test. So while in principle I 
agree with you, I'm also beginning to understand Donald Becker's 
frustration when others remove backward compatibility from his code.

So let's try to find some middle ground, ok? Your first suggestion sounds 
reasonable, and hopefully the fate of the zerocopy stuff will be decided 
sooner than later.

Stay tuned, there should be another version coming your way sometime 
today...

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
