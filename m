Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADChU>; Wed, 3 Jan 2001 21:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132116AbRADChL>; Wed, 3 Jan 2001 21:37:11 -0500
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:22657 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129324AbRADChD>; Wed, 3 Jan 2001 21:37:03 -0500
Date: Wed, 03 Jan 2001 18:25:56 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: Prerelease kernel will not hotplug a USB host-controller when
 itisinserted into a Cardbus slot.
To: Miles Lane <miles@megapathdsl.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, linux-kernel@vger.kernel.org
Message-id: <047301c075f5$ac01a480$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <3A53187B.9030601@megapathdsl.net>
 <032e01c07595$7be8b8c0$6600000a@brownell.org>
 <3A53C8AA.8060103@megapathdsl.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miles,

>        The whole
> "Bad PCI invocation" error was a red herring, sorry.

Not an endangered species ... even if Tux does like to
snack on them!  :-)


> I have since gone in a tested test12-pre5, test12-pre6 and
> test12-pre8.  test12-pre5 works.  test12-pre6 fails utterly.

That's for "Cardbus hotplug".  I've had USB hotplugging fine,
with the iffy bits being when it combines with the network
hotplugging ... those async changes seem to have created some
deadlocking paths (while removing some others).


> It looks like Cardbus was just completely hosed in that
> tree, because I can't get my network card (3c575) to be recognized
> by that kernel, either.  I checked the patches and Andrew's
> "04X" change went into test12-pre8.  I just tested test12-pre8
> with both your latest hotplug script, David, and with the
> pertinent "0x" locations changed to "04x".  Both scripts fail
> to load usb-ohci.

The root cause seems to be the Cardbus/PCI hotplug invocation not
happening for you.

Was this with or without the "pcmcia_cs" package installed?  My
own take on it is that 2.4 _should_ hotplug that controller
just fine if "pcmcia_cs" isn't installed.  Otherwise, I'd be
pleasantly surprised to know it works properly.


> For the Cardbus hotplug event, is it expected that the hotplug
> debug info would be dumped after the insert event is processed
> and the required driver is loaded?

No -- you were seeing the USB hotplug event, not the cardbus one.

Plugging a cardbus OHCI into your machine should cause two hotplug
events ... first for PCI, eventually modprobing "usb-ohci", and
then as that module initializes you'll get a second one for USB,
reporting a new (root) hub.

So you should see an invocation "arguments (pci) env (...)"
followed by "arguments (usb) env (...)"; but you reported the
second one.

- Dave


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
