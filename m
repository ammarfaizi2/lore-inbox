Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263850AbUHIINT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263850AbUHIINT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 04:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUHIINT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 04:13:19 -0400
Received: from mail.math.TU-Berlin.DE ([130.149.12.212]:62155 "EHLO
	mail.math.TU-Berlin.DE") by vger.kernel.org with ESMTP
	id S263850AbUHIINQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 04:13:16 -0400
From: Thomas Richter <thor@math.TU-Berlin.DE>
Message-Id: <200408090813.KAA26594@cleopatra.math.tu-berlin.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <200408071217.i77CHUKm006973@burner.fokus.fraunhofer.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Mon, 9 Aug 2004 10:13:13 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jörg,

> >From the > 20 platforms that libscg provides abstractions from, _most_
> platforms do not allow the "UNIX" /dev/something method to work with
> Generic SCSI:

> -	AmigaOS

/* snip */

I've been following this discussion for quite a while now, fairly interested,
mainly as a user of cdrecord and linux, you here you're going a bit over the
edge. Having had my home at AmigaOs for quite a while, I should possibly
add my two cents that your above argument is pretty much "bogus".

For first, there is nothing like a CAM interface on Amiga, neither on MacOs.
MacOs implements (or at least, up to Os 9) implemented SCSI by its own
"scsi-manager" interface which is "all but CAM". It is more or less a pretty
bad abstraction of a pretty bad (hand-rolled) SCSI chipset Apple choose to
implement in the early Mac's, not much more.

As for AmigaOs, there's also nothing like a standardized SCSI interface.
Instead, you'd had to talk to the device driver ("kinna like /dev/hda") 
directly using HD_SCSICMD, which is closer to the proposed Linux device
driver interface than the "dev" setting you're putting forward. There's
no /dev, and thus there's no /dev/hda, but there's possibly a scsi.device
or an oktagon.device you had to talk to, and that's much closer to the
Linux /dev/hdx raw device interface than to CAM.

If you'd like to have an internal CAM layer, then this is possibly a good
idea to integrate cdrecord into various operating systems (if you like
to count AmigaOs as one), but as user frontend, this is a pretty bad idea.
One should talk to users in a way that integrates into the host environment,
and not in some kind of standard specified environment. After all, standards
are made to make things simpler - instead cdrecord makes things harder
by trying to follow standards that are not the standards of the host.

And please, don't tell that I'm "Linux centric". I've much more ideas
about the internal wiring of other operating systems than Linux.

> These are the platforms where /dev/something could work:

+ AmigaOs, if you prefer to count.

But, as I said, this is a non-argument. The tools should integrate into
the environment, and keeping things managable for the user should be the
goal.

Whether Linux should choose CAM as interface is another question - with
ATAPI much more popular than SCSI nowadays, one might consider this of
less importance, possibly.

Sorry, just my 0.02 Euro.

So long,
	Thomas

