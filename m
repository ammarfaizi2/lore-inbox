Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUFJWuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUFJWuN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUFJWuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:50:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2710 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262328AbUFJWuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:50:04 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Craig Bradney <cbradney@zip.com.au>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Fri, 11 Jun 2004 00:53:55 +0200
User-Agent: KMail/1.5.3
Cc: Lars <terraformers@gmx.net>, linux-kernel@vger.kernel.org
References: <ca9jj9$dr$1@sea.gmane.org> <200406110026.34006.bzolnier@elka.pw.edu.pl> <1086906770.10033.6.camel@amilo.bradney.info>
In-Reply-To: <1086906770.10033.6.camel@amilo.bradney.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406110053.55052.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 of June 2004 00:32, Craig Bradney wrote:
> On Fri, 2004-06-11 at 00:26, Bartlomiej Zolnierkiewicz wrote:
> > On Friday 11 of June 2004 00:00, Craig Bradney wrote:
> > > On Thu, 2004-06-10 at 23:56, Bartlomiej Zolnierkiewicz wrote:
> > > > On Thursday 10 of June 2004 23:36, Lars wrote:
> > > > > thanks
> > > > >
> > > > > after some reading, im using now in rc.local:
> > > > >
> > > > > ### C1 Halt Disconnect Fix for Chip rev. C17
> > > > > setpci -H1 -s 0:0.0 6F=1F
> > > > > setpci -H1 -s 0:0.0 6E=01
> > > > > echo "Applying C1 Halt Disconnect Fix"
> > > > >
> > > > > this is for an older nforce2 board (a7n8x 1.04) with rev. C17 chip
> > > > > and worked fine so far.
> > > > >
> > > > > for the newer chip revision it should read
> > > > >
> > > > > ### C1 Halt Disconnect Fix for Chip rev. C18D
> > > > > setpci -H1 -s 0:0.0 6F=9F
> > > > > setpci -H1 -s 0:0.0 6E=01
> > > > > echo "Applying C1 Halt Disconnect Fix"
> > > > >
> > > > > first setpci is for the c1 halt bit and the second one enables the
> > > > > 80ns stability value.
> > > >
> > > > Order should be reversed.
> > > >
> > > > > i understand that its not good to enable c1 for all boards, but it
> > > > > would be nice to have the option to force the fixup on boards which
> > > > > work ok but have no bios option to enable c1. (like the a7n8x)
> > > > > an bootoption like "forceC1halt" or something would be nice here.
> > > >
> > > > It can be perfectly handled in user-space as you've just showed. :-)
> > > > There is no need to add complexity to the kernel.
> > >
> > > Except if people have the trouble when installing Linux.... ok, yes,
> >
> > What trouble are you talking about?
> >
> > Fix is in the kernel and is applied when C1 Halt Disconnect is enabled.
> > If  C1 H.D. is disabled you need to enable it somehow from user-space,
> > thus you can apply fixup from user-space at the same time.
> >
> > > they can still be done somehow, but thats just ugly for the "put cd in
> > > and install" users. Surely the kernel should be detecting this stuff
> > > and using various options as required.
> >
> > If you think that kernel should have options for all PCI tweaks
> > available than sorry but you are wrong (grab powertweak instead).
>
> Well.. no.. I dont suggest that the kernel apply fixes for all the buggy
> motherboards and other h/w out there.. but I guess the distro builders

Sure it needs to apply fixes if they are needed for stability etc.

Please note that if C1HD is not enabled in the BIOS we cannot
force it - some boards do not support it et all (even with fixup).

We may try to apply fixup always but enabling of C1HD _feature_
(your machine should work perfectly without it, if it doesn't i.e.
 overheats then it can also overheat with C1HD under heavy load)
must be leaved to user-space.

Alternatively we can add "forceC1Halt" kernel option
but it simply sucks: it is useless for non nForce2 users,
you can't disable it and you've to maintain it (forever?).

> need to make sure these post boot options are being set based on
> hardware detected, or something. :)
>
> Craig

Cheers.

