Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTE0Qxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263944AbTE0Qxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:53:55 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:52891 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263943AbTE0Qxx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:53:53 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 27 May 2003 10:06:56 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Thomas Winischhofer <thomas@winischhofer.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sis650 irq router fix for 2.4.x
In-Reply-To: <3ED32BA4.4040707@winischhofer.net>
Message-ID: <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>
References: <3ED21CE3.9060400@winischhofer.net>
 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>
 <3ED32BA4.4040707@winischhofer.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 May 2003, Thomas Winischhofer wrote:

>
> To Alan who is perhaps reading this: Who is an expert on this type of stuff?

Alan, are you there ?

(I also Cc'ed Martin that helped me with the patch)


> Davide Libenzi wrote:
> > On Mon, 26 May 2003, Thomas Winischhofer wrote:
> >
> >
> >>and I had (and have) no problems with irqs or USB (or anything) on any
> >>of these machines.
>
> First, let me say that I know NIL about irq routing. But fact is, I had
> my machines running with webcams, floppy drives and mice (all via USB,
> that is) - and had no problem.
>
> But you got me puzzled: As a matter of fact, it seems that ALL (!) my
> 650 variants show different routing tables, mostly like yours.
>
> dmesg with pci-debug enabled and lspci -vxxx printouts attached.
>
> 650 = "ISA bridge" revision 0
> M650 = revision 4
> 651 = revision 0x25
>
> Interestingly, as soon as pci-debugging was enabled, the log is full
> with error messages, and I suddenly actually _had_ problems with my
> network card and my wireless card (and assumingly the USB stuff, too,
> conclusing from the "failed" statements in the log)....
>
> >>Are you sure that checking the revision number of the device is enough?
> >
> >
> > It seems reasonble, at least without having the spec for the chipset. All
> > my searches failed about docs. Previous cases are correctly handled like
> > before, as you can see from the patch.
>
> I myself doubt this now. If I am reading the dmesg output correctly,
> even the machine with revision 0 (plain 650) is routing _some_ of the
> interrupts with 0x6x requests...

Yes, it seems that those request can be handled as pass thru, so might
have two options :

1) Use the new routing to handle only rev-04 and let users of other
	revisions to use the "stdroute" boot line

2) Use the new routing by default, except for the revisions that are known
	to work well with the old one


> > You happen to have the spec for the SIS650 ?
>
> That's a good one :) I have been bugging SiS since 2001 for docs, all I
> got was nothing.

Yes, I digged badly. Nothing beat Intel about documentation.



- Davide

