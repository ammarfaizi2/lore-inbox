Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277300AbRJETCK>; Fri, 5 Oct 2001 15:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277550AbRJETCA>; Fri, 5 Oct 2001 15:02:00 -0400
Received: from [208.129.208.52] ([208.129.208.52]:42769 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277551AbRJETBt>;
	Fri, 5 Oct 2001 15:01:49 -0400
Date: Fri, 5 Oct 2001 12:07:08 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andreas Dilger <adilger@turbolabs.com>
cc: Robert Olsson <Robert.Olsson@data.slu.se>, <mingo@elte.hu>,
        jamal <hadi@cyberus.ca>, <linux-kernel@vger.kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Benjamin LaHaise <bcrl@redhat.com>, <netdev@oss.sgi.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011005124824.F315@turbolinux.com>
Message-ID: <Pine.LNX.4.40.0110051205460.1523-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Andreas Dilger wrote:

> On Oct 05, 2001  16:52 +0200, Robert Olsson wrote:
> >  > If you get to the stage where you are turning off IRQs and going to a
> >  > polling mode, then don't turn IRQs back on until you have a poll (or
> >  > two or whatever) that there is no work to be done.  This will at worst
> >  > give you 50% polling success, but in practise you wouldn't start polling
> >  > until there is lots of work to be done, so the real success rate will
> >  > be much higher.
> >  >
> >  > At this point (no work to be done when polling) there are clearly no
> >  > interrupts would be generated (because no packets have arrived), so it
> >  > should be reasonable to turn interrupts back on and stop polling (assuming
> >  > non-broken hardware).  You now go back to interrupt-driven work until
> >  > the rate increases again.  This means you limit IRQ rates when needed,
> >  > but only do one or two excess polls before going back to IRQ-driven work.
> >
> >  Yes this has been considered and actually I think Jamal did this in one of
> >  the pre NAPI patch. I tried something similar... but instead of using a
> >  number of excess polls I was doing excess polls for a short time (a
> >  jiffie). This was the showstopper mentioned the previous mails. :-)
>
> (Note that I hadn't read the NAPI paper until after I posted the above, and
> it appears that I was describing pretty much what NAPI already does ;-).  In
> light of that, I wholly agree that NAPI is a superior solution for handling
> IRQ overload from a network device.
>
> >  Anyway it up to driver to decide this policy. If the driver returns
> >  "not_done" it is simply polled again. So low-rate network drivers can have
> >  a different policy compared to an OC-48 driver. Even continues polling is
> >  therefore possible and even showstoppers. :-)  There are protection for
> >  polling livelocks.
>
> One question which I have is why would you ever want to continue polling
> if there is no work to be done?

According to the doc the poll is stopped when 1) there're no more packets
to be fetched from dma ring 2) quota is reached.




- Davide


