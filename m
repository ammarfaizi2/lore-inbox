Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264510AbUAFPgP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUAFPgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:36:14 -0500
Received: from colin2.muc.de ([193.149.48.15]:24850 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264510AbUAFPgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:36:12 -0500
Date: 6 Jan 2004 16:37:06 +0100
Date: Tue, 6 Jan 2004 16:37:06 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
Message-ID: <20040106153706.GA63471@colin2.muc.de>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de> <Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 07:27:33AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 6 Jan 2004, Andi Kleen wrote:
> > 
> > In my opinion it would have been cleaner if the aperture had always
> > an reserved entry in the e820 map.
> 
> That does sound like a bug in the AGP drivers. It shouldn't be hard at all 
> to make them reserve their aperture.
> 
> Hint hint.

No, it's a bug in the BIOS that they're not marked. But I've actually
seen a BIOS that marked it and it lead to the Linux AGP driver failing
(due to some interaction with how setup.c sets up resources). So the Linux
driver currently even relies on the broken state.

Anyways, I already implemented reservation for the aperture for the K8
driver some time ago. And it's in your tree. But it doesn't help for 
finding IO holes because there could be other unmarked hardware lurking
there ... Or worse there is just no free space below 4GB.

-Andi
