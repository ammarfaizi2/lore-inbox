Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271747AbRHURSt>; Tue, 21 Aug 2001 13:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271748AbRHURSk>; Tue, 21 Aug 2001 13:18:40 -0400
Received: from beppo.feral.com ([192.67.166.79]:36875 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S271747AbRHURSa>;
	Tue, 21 Aug 2001 13:18:30 -0400
Date: Tue, 21 Aug 2001 10:18:07 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: <mjacob@feral.com>
To: "David S. Miller" <davem@redhat.com>
cc: <jes@sunsite.dk>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <20010821.094227.57162632.davem@redhat.com>
Message-ID: <20010821100710.X23686-100000@wonky.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few of pieces of information and comments:

The "BSD" copyright in the f/w I have from QLogic is there only because Theo
Deraadt threatened to pull QLogic from the 2.7 OpenBSD release. I'd been
pleading with them for over a year to do *something*. I should have done a BSD
license w/o the advert clause, but, oh, well.....

To understand what shape you're in, it's really best to load firmware into the
card's SRAM. That way you *know* it understands feature foo (like SCCLUN, for
example). QLogic produces so many different flavors of firmware of the same
nominal revision that it's hard to deduce the viability or safety of some
firmware.

That said, it *is* possible in a non-BIOS environment to pull firmware out of
flash rom, I believe- you have to do some hand strobing of registers that
normally only the firmware touches, but I think it *is* technically possible
to pull the contents of flash out into system memory, figure out where the
'resident' f/w image is in this goop and then download *that* into SRAM and
restart the sequencer. Still- this leaves you in the same position as before.

IMO, the best thing is to do an ispfw load module that goes away after you've
loaded SRAM. I've started down this path in FreeBSD (there's a separate ispfw
module)- which will only be really useful if module memory ever gets reclaimed
in FreeBSD :-). This is of particular importance for my driver, because in
supporting 1020 (SBus (yes for NetBSD/OpenBSD, not yet for Linux)  && PCI),
1080/1280 Ultra2, 12160 Ultra3, 2100 FC, 2200FC and 2300FC (next week)- you
end up with an absurd amount of f/w images.

I'm sure there's something similar that can be done for Linux.

Alan- you say you can talk to QLogic- good. I've been finding it harder and
harder to talk to them. If you can get them to put out 2100 and 2200 and 2300
f/w with GPL for Linux- great.

-matt


