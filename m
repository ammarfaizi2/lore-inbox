Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265894AbUAFWv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 17:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265952AbUAFWv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 17:51:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4978 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S265894AbUAFWvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 17:51:51 -0500
To: Andi Kleen <ak@colin2.muc.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Mika Penttil? <mika.penttila@kolumbus.fi>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <1aJdi-7TH-25@gated-at.bofh.it>
	<m37k054uqu.fsf@averell.firstfloor.org>
	<Pine.LNX.4.58.0401051937510.2653@home.osdl.org>
	<20040106040546.GA77287@colin2.muc.de>
	<Pine.LNX.4.58.0401052100380.2653@home.osdl.org>
	<20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi>
	<20040106094442.GB44540@colin2.muc.de>
	<Pine.LNX.4.58.0401060726450.2653@home.osdl.org>
	<20040106153706.GA63471@colin2.muc.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jan 2004 15:45:16 -0700
In-Reply-To: <20040106153706.GA63471@colin2.muc.de>
Message-ID: <m1brpgn1c3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@colin2.muc.de> writes:

> On Tue, Jan 06, 2004 at 07:27:33AM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Tue, 6 Jan 2004, Andi Kleen wrote:
> > > 
> > > In my opinion it would have been cleaner if the aperture had always
> > > an reserved entry in the e820 map.
> > 
> > That does sound like a bug in the AGP drivers. It shouldn't be hard at all 
> > to make them reserve their aperture.
> > 
> > Hint hint.
> 
> No, it's a bug in the BIOS that they're not marked. But I've actually
> seen a BIOS that marked it and it lead to the Linux AGP driver failing
> (due to some interaction with how setup.c sets up resources). So the Linux
> driver currently even relies on the broken state.

And mtd map drivers for rom chips run into the same problem except in
that case regions is almost always reserved by the BIOS.

Which means it's just silly for the drivers to fail when request_mem_region
fails.  They are looking at the hardware and know where the regions are, and
there is not a parent device we can request a subregion from when it is the
BIOS that reserves the region.

Eric
