Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUAFPsv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 10:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUAFPsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 10:48:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:41410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264507AbUAFPsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 10:48:50 -0500
Date: Tue, 6 Jan 2004 07:48:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@colin2.muc.de>
cc: Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
In-Reply-To: <20040106153706.GA63471@colin2.muc.de>
Message-ID: <Pine.LNX.4.58.0401060744240.2653@home.osdl.org>
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org>
 <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de>
 <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de>
 <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
 <Pine.LNX.4.58.0401060726450.2653@home.osdl.org> <20040106153706.GA63471@colin2.muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Jan 2004, Andi Kleen wrote:
> 
> Anyways, I already implemented reservation for the aperture for the K8
> driver some time ago. And it's in your tree. But it doesn't help for 
> finding IO holes because there could be other unmarked hardware lurking
> there ... Or worse there is just no free space below 4GB.

The "unmarked hardware" is why we have PCI quirks. Look at 
drivers/pci/quirks.c, and notice how many of the quirks are all about 
quirk_io_region().  Exactly because there isn't any way for the BIOS to 
tell us about these things on the IO side.

(Actually, there is: PnP-BIOS calls are supposed to give us that
information. However, not only are the BIOSes buggy and don't give a
complete list _anyway_, anybody who uses the PnP-BIOS is much more likely
to just get a kernel oops when the BIOS is buggy and assumes that only
Windows will call it. So I strongly suggest you not _ever_ use pnp unless
you absolutely have to).

The same quirks could be done on the MMIO side for northbridges.

			Linus
