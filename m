Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279189AbRJ2LQC>; Mon, 29 Oct 2001 06:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279190AbRJ2LPx>; Mon, 29 Oct 2001 06:15:53 -0500
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:53698 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279189AbRJ2LPo>; Mon, 29 Oct 2001 06:15:44 -0500
Message-ID: <3BDD3A87.B98104B0@mandrakesoft.com>
Date: Mon, 29 Oct 2001 06:16:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Samuli Suonpaa <suonpaa@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-acX: NM256 hangs at boot
In-Reply-To: <E15yAHE-0002M1-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > NM256 is PCI-based, so I checked whether CONFIG_HOTPLUG_PCI would have
> > any effect. It didn't.
> >
> > Exactly the same thing happens with 2.4.13-ac4.
> >
> > If I compile the kernel without sound-support, everything works just
> > fine.
> 
> Jeff Garzik updated the neomagic driver to use the generic ac97 codec. It
> looks like he didnt quite get it right firs ttime around. I'll take a look
> and its then a case of either fixing it or reverting Jeff's change

If you don't see something right off, go ahead and revert it.

IIRC now, nm256 had trouble with completely locking the PCI bus if you
touched the wrong AC97 registers.  The solution was to create
ac97_codec_{read,write} that filtered register numbers depending on a
codec-specific mask, thus avoiding those registers on nm256 and using
them on other chips.  This change isn't in anybody's ac97_codec (except
an old CVS of mine), and it was never fully debugged when I had a hands
on a laptop with [supposed] ac97 codec nm256 on it.

So, I am hoping it's a stupid error like "using ac97 mixer when I
shouldn't", otherwise it's likely too much trouble to bother with.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

