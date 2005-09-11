Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbVIKACL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVIKACL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 20:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbVIKACK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 20:02:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932457AbVIKACJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 20:02:09 -0400
Date: Sat, 10 Sep 2005 17:02:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
In-Reply-To: <43236FD2.6010501@pobox.com>
Message-ID: <Pine.LNX.4.58.0509101658080.30958@g5.osdl.org>
References: <Pine.LNX.4.44L0.0509101655520.7081-100000@netrider.rowland.org>
 <Pine.LNX.4.58.0509101410300.30958@g5.osdl.org> <43235707.7050909@pobox.com>
 <20050910153110.36a44eba.akpm@osdl.org> <Pine.LNX.4.58.0509101548230.30958@g5.osdl.org>
 <43236FD2.6010501@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Sep 2005, Jeff Garzik wrote:
> 
> I -do- want to use iomap.  The problem is that no one has yet come up 
> with a few that does all the proper resource reservation.  Everybody 
> (including myself) did the ioread/iowrite part, but gave up before 
> handling all cases of (a) legacy ISA iomap, (b) native PCI IDE iomap, 
> and (c) non-standard MMIO iomap.

It should all be trivial. The only ugly issue in the patch I just sent out 
is that it needs to save the "legacy_mode" bits that were calculated at 
initialization time somewhere in the ap structure. Then the 
release_regions should match the request_regions.

That's a cleanup, the current code is literally buggy. It may end up
releasing IO address 0x1f0 twice, if somebody wasn't marked legacy, but
actually had 0x1f0 in the PCI resource pointers (maybe that doesn't ever
happen, but still.. Relying on the legacy-value of the IO port instead of
relying on whether you did a legacy request_region() is definitely at
least conceptually wrong).

			Linus
