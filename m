Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVIMSNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVIMSNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbVIMSNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:13:11 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:13064 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S964953AbVIMSNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:13:10 -0400
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
From: Mathieu Fluhr <mfluhr@nero.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org>
	 <1126608030.3455.23.camel@localhost.localdomain>
	 <1126630878.2066.6.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org>
Content-Type: text/plain
Organization: Nero AG
Date: Tue, 13 Sep 2005 20:12:40 +0200
Message-Id: <1126635160.2183.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 10:15 -0700, Linus Torvalds wrote:
> 
> On Tue, 13 Sep 2005, Mathieu Fluhr wrote:
> >
> > Ok, after having performed a bisection of the kernel tree (took me the
> > whole afternoon.... 13 compilations needed ;-) I think I am able to give
> > the faulty patch for these buffer underruns: 
> 
> Thanks, interesting.
> 
> And hey, 13 compilations may sound like a lot, but considering that there
> were 2069 commits between 2.6.12 and 2.6.13-rc1, having to do "just" 13
> kernels to pinpoint the exact cause is pretty good, I think.
> 
> Especially as I don't think anybody would really have expected the one you 
> found:
> 

Yes I know. I was just kidding ;-) I would say that I didn't know the
git bisection method at all... but I would say that it is really
smashing!

> > [PATCH] i386: Selectable Frequency of the Timer Interrupt
> > 
> > So I would say that it is related to somehow some kind of timeout in
> > SCSI I/O (but really not sure...).
> 
> Interesting, and a bit scary. If it worked with 1kHz (old default value),
> it's not even any of the old Linux x86 timeouts (that were designed for
> 100 Hz), so it's some _new_ HZ dependency.
> 
> > As far as I saw, there is now an option in the kernel config file
> > related to this, so I will try to see what happens with 1000 Hz and 100
> > Hz (I left the default value of 250 Hz for my tests).
> 
> Yes, that would be interesting.
> 

Okay, here is the point: I will have these bloody buffer underruns
unless I select a 'Timer frequency' of 1000 Hz in 'Processor type and
features' section of the kernel configuration. That's quite
understandable, as recording a DVD at 16x requires a throughput of 22160
KB/s, which is quite fast.

I will have a deep look in the patch, and maybe write a patched patch
(Ooooo my god what am I writing ?) in the next few days.

> Btw, what's the exact error message you get? (And is it the kernel or the
> burning app that complains?)

I do not get any kernel error message. It is just my burning app that
complains that buffer underruns occured, as if the source media was not
fast enough to deliver 22160 KB/s.

> 
> 			Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

