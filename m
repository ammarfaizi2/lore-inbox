Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129648AbQKRSsK>; Sat, 18 Nov 2000 13:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQKRSsA>; Sat, 18 Nov 2000 13:48:00 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:27403 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129648AbQKRSrs>; Sat, 18 Nov 2000 13:47:48 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: test11-pre6 still very broken
Date: 18 Nov 2000 10:17:17 -0800
Organization: Transmeta Corporation
Message-ID: <8v6h3d$rp$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <20001117223137.A26341@wirex.com> <3A162EFE.A980A941@talontech.com> <20001117235624.B26341@wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20001117235624.B26341@wirex.com>, Greg KH  <greg@wirex.com> wrote:
>On Fri, Nov 17, 2000 at 11:25:50PM -0800, Ben Ford wrote:
>> Here is lspci output from the laptop in question.  Is this not UHCI?
>
>Yes it is.  Just a bit funny if you think about it, but with Intel and
>Via putting the UHCI core into their chipsets I guess it makes sense.
>
>One note for the archives, if you are presented a choice between a OHCI
>or a UHCI controller, go for the OHCI.  It has a "cleaner" interface,
>handles more of the logic in the silicon, and due to this provides
>faster transfers.

I'd disagree.  UHCI has tons of advantages, not the least of which is
[Cthat it was there first and is widely available.  If OHCI hadn't been
done we'd have _one_ nice good USB controller implementation instead of
fighting stupid and unnecessary battles that shouldn't have existed in
the first place. 

For example, the UHCI root hub can be controlled without DMA, which
makes it a lot cheaper on the system. When a UHCI system is unconnected
and idle, it doesn't waste cycles on extra memory traffic the way OHCI
does.

UHCI also requires fewer transistors, and is the more common by far
simply because Intel is good at getting their chipsets out.

Basically, the advantages of OHCI are not worth the differentiation, and
are not always advantages at all.  Many people think that it is "good"
that the root hub looks more like a regular hub, but that's just wrong. 

Especially with faster speeds, the memory pressure of the USB controller
is going to be noticeable, and it would be much preferable if the root
directory of the USB tree would be separated out (and cached in the
controller) by the root hub.  The UHCI approach of making the root a bit
special should be taken _further_, and not seen as a mistake. 

I hope EHCI makes it all moot. Some way or another.

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
