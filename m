Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSIXAXo>; Mon, 23 Sep 2002 20:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261526AbSIXAXo>; Mon, 23 Sep 2002 20:23:44 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54532
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261525AbSIXAXn>; Mon, 23 Sep 2002 20:23:43 -0400
Date: Mon, 23 Sep 2002 17:28:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Richard Zidlicky <rz@linux-m68k.org>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: IDE janitoring comments
In-Reply-To: <20020924000134.A210@linux-m68k.org>
Message-ID: <Pine.LNX.4.10.10209231726580.2072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Poke in your own special ide-ops function pointers.
This should have been allowed on a per chipset/channel bases.

Did I miss something?

On Tue, 24 Sep 2002, Richard Zidlicky wrote:

> On Sat, Aug 24, 2002 at 05:09:16PM +0200, Benjamin Herrenschmidt wrote:
> 
> >  - In ide-iops, the insw, insl, outsw, outsl functions are
> > broken for big endian. They should not do byteswap on these,
> > however, implemeting them with a loop of IN/OUT_BYTE/WORD
> > will cause byteswapped access on archs like PPC.
> > The problem is that the macros IN/OUT_BYTE/WORD don't define
> > non-swapping equivalents that would allow us to correctly
> > implement the "s" versions. 
> 
> we have one special problem on m68k, on some machines the IDE
> bus is byteswapped (unrelated to cpu endianness). For historical 
> and performance reasons data to the HD is by default read and 
> written in this "wrong" order (thus the bswap/swapdata option)
> and special fixup code is used in ide_fix_driveid (see 
> M68K_IDE_SWAPW). However data returned by IDE_DRIVE_CMD is not 
> treated in any way, so that eg WIN_SMART data end up in the 
> wrong order on those machines and this is something I would 
> like to fix properly.
> I figure I would define ata_*_{control,data} to handle special
> data resp raw HD data and modify ide_handler_parser to return
> specialised interrupt handlers or set some additional flag.
> 
> Any thoughts?
> 
> Richard
> 

Andre Hedrick
LAD Storage Consulting Group

