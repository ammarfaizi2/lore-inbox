Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288725AbSADTVb>; Fri, 4 Jan 2002 14:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284580AbSADTVV>; Fri, 4 Jan 2002 14:21:21 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:41105
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288712AbSADTVL>; Fri, 4 Jan 2002 14:21:11 -0500
Date: Fri, 4 Jan 2002 14:05:38 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
        Lionel Bouton <Lionel.Bouton@free.fr>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020104140538.A19746@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Vojtech Pavlik <vojtech@suse.cz>,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Woodhouse <dwmw2@infradead.org>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020103133454.A17280@suse.cz> <Pine.GSO.3.96.1020104191141.829B-100000@delta.ds2.pg.gda.pl> <20020104200410.E21887@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020104200410.E21887@suse.cz>; from vojtech@suse.cz on Fri, Jan 04, 2002 at 08:04:10PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz>:
> And of course, there will be a huge amount of false positives, because
> all the new chipsets have an ISA bridge built into the southbridge chip
> and it is there even when no ISA slots are present.

Yeah.  That's what makes the lspci approach unusable for my purposes.

The approach I want to take is this:

1. Get guaranteed access to the DMI data, either via a /{proc,sys}/dmi
   or /var/run/dmi initialized at boot time.

2. Develop an exception list of mobos that have ISA slots that don't
   show up under DMI.

My logic would then be: if the box has PCI, and DMI shows no ISA slots,
and the motherboard is not on the exception list, then suppress ISA 
questions.

This would be a kluge, but it would have the advantage that the exception
list is finite and can be expected to stop growing.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The end move in politics is always to pick up a gun.
	-- R. Buckminster Fuller
