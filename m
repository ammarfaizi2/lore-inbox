Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbSIWW0j>; Mon, 23 Sep 2002 18:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSIWW0j>; Mon, 23 Sep 2002 18:26:39 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:4583 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S261368AbSIWW0i>; Mon, 23 Sep 2002 18:26:38 -0400
Date: Tue, 24 Sep 2002 00:01:34 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE janitoring comments
Message-ID: <20020924000134.A210@linux-m68k.org>
References: <20020824150917.20045@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020824150917.20045@192.168.4.1>; from benh@kernel.crashing.org on Sat, Aug 24, 2002 at 05:09:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2002 at 05:09:16PM +0200, Benjamin Herrenschmidt wrote:

>  - In ide-iops, the insw, insl, outsw, outsl functions are
> broken for big endian. They should not do byteswap on these,
> however, implemeting them with a loop of IN/OUT_BYTE/WORD
> will cause byteswapped access on archs like PPC.
> The problem is that the macros IN/OUT_BYTE/WORD don't define
> non-swapping equivalents that would allow us to correctly
> implement the "s" versions. 

we have one special problem on m68k, on some machines the IDE
bus is byteswapped (unrelated to cpu endianness). For historical 
and performance reasons data to the HD is by default read and 
written in this "wrong" order (thus the bswap/swapdata option)
and special fixup code is used in ide_fix_driveid (see 
M68K_IDE_SWAPW). However data returned by IDE_DRIVE_CMD is not 
treated in any way, so that eg WIN_SMART data end up in the 
wrong order on those machines and this is something I would 
like to fix properly.
I figure I would define ata_*_{control,data} to handle special
data resp raw HD data and modify ide_handler_parser to return
specialised interrupt handlers or set some additional flag.

Any thoughts?

Richard
