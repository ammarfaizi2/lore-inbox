Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUAFJnv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 04:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbUAFJnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 04:43:51 -0500
Received: from colin2.muc.de ([193.149.48.15]:26117 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261779AbUAFJnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 04:43:49 -0500
Date: 6 Jan 2004 10:44:42 +0100
Date: Tue, 6 Jan 2004 10:44:42 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040106094442.GB44540@colin2.muc.de>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFA7BB9.1030803@kolumbus.fi>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 11:11:21AM +0200, Mika Penttil? wrote:
> 
> 
> Andi Kleen wrote:
> 
> >>If you ahve a proper e820 map, then it should work correctly, with 
> >>anything that is RAM being marked as such (or being marked as "reserved").
> >>   
> >>
> >
> >Every e820 map i've seen did not have the AGP aperture marked reserved.
> >
> Why should it? It's not ram, and the aperture is marked as reserved 
> while doing PCI resource assignment/reservation.

It implies that you cannot just put your IO mappings
into any holes. Because something else like the aperture may 
be already there.

In my opinion it would have been cleaner if the aperture had always
an reserved entry in the e820 map. Or better all usable holes get
an special entry. Then you could actually reliable allocate IO space
 on your own. Currently it's just impossible.

-Andi
