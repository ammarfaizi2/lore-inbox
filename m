Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274246AbRI3XRN>; Sun, 30 Sep 2001 19:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274249AbRI3XRD>; Sun, 30 Sep 2001 19:17:03 -0400
Received: from bart.one-2-one.net ([195.94.80.12]:25093 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S274246AbRI3XQ6>; Sun, 30 Sep 2001 19:16:58 -0400
Date: Mon, 1 Oct 2001 01:19:32 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] yet another yenta resource allocation fix
In-Reply-To: <E15npZT-0007s7-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0110010104290.746-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Oct 2001, Alan Cox wrote:

> > I'm asking for application of a patch I'm using since 2.4.0. Issue was the
> > BIOS of my OB-800 mapped the memory regions of the cardbus bridges into
> > legacy 1M-area (0xe6000 e.g.). Despite being pretty bogus this used to
> > work after a reboot just until the first pm-suspend/resume, where the
> > hostbridge somehow looses access to this area.
> 
> At a guess your bios doesnt restore the shadow ram disables right.

In fact, there is a (IIRC single) byte changed in the hostbridge's config
space after resume. Blindly writing back the old value re-enables access
to the cardbus memory resource below 1M. But I agree solving the real
cause (i.e. bogus mapping to legacy area) is better then trying to cure
whatever triggers the problem with that.

> Would a generic
> 
> 	pci_fixup_device()
> 
> type function not be more appropriate

IIRC there was some discussion on l-k some time ago, whether such fixups
should stay close to were the issue appeared or better be placed at
generic pci quirk location. In this particular case I personally tend to
the latter one as well, particularly because there may be other BIOS'
doing similar things with non-cardbus memory bar's.
The patch however was simply what I'm using since 2.4.0 just in case the
cardbus-specific fixup would be the prefered way.

Martin

