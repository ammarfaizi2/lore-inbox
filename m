Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTDWUDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263581AbTDWUDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:03:54 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8320 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263578AbTDWUDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:03:48 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304232019.h3NKJ7lc000582@81-2-122-30.bradfords.org.uk>
Subject: Re: [PATCH] M68k IDE updates
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 23 Apr 2003 21:19:07 +0100 (BST)
Cc: rz@linux-m68k.org (Richard Zidlicky),
       geert@linux-m68k.org (Geert Uytterhoeven),
       torvalds@transmeta.com (Linus Torvalds), paulus@samba.org,
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1051095870.2065.84.camel@dhcp22.swansea.linux.org.uk> from "Alan Cox" at Apr 23, 2003 12:04:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Mer, 2003-04-23 at 12:27, Richard Zidlicky wrote:
> > It seems that Geert=C2=B4 idea would fit neatly into the current IDE=20
> > system. Endianness of on disk data and drive control data are
> > clearly different things. A while ago Andre suggested to switch
> > the transport based on opcode to make it work, it might be even
> > more straightforward to set some flag when the handler is selected
> > or take a distinct handler altogether (ide_cmd_type_parser or
> > ide_handler_parser).
> 
> Thats over complicating stuff I think.
> 
> > Otoh trying to solve that with loopback would mean new kernels=20
> > wouldn=C2=B4t even see the partition table of old installed harddisks
> > on some machines.=20
> 
> Which is a real pain. I think its the right 2.5 answer. I'm not happy
> about breaking that (even if its only for the m68k userbase in 2.4)
> either.
> 
> I don't think command parsing is the right place. Turn your IDE layer
> "right endian" and most stuff begins to look a lot saner already.=20
> The "fixing" needs to be happening at the top of the IDE layer not
> in the driver itself. For 2.5 that ought to be loopback or similar
> for 2.4 it makes sense I think to effectively implement an endian
> switcher without loopback for compatibility.

Moving byte swapping out of the IDE layer also means that dumping the
whole disk to a file will then give you non-byte swapped data, which
could then be written back to a disk on another machine without a
byte-swapped IDE interface.

It will also allow you to exchange tar archives on raw hard disk
devices, and have them readable on non-byte swapped IDE interfaces
:-).

John.
