Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261605AbSIXHlt>; Tue, 24 Sep 2002 03:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261607AbSIXHlt>; Tue, 24 Sep 2002 03:41:49 -0400
Received: from AMarseille-201-1-5-7.abo.wanadoo.fr ([217.128.250.7]:3184 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S261605AbSIXHls>;
	Tue, 24 Sep 2002 03:41:48 -0400
From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
To: "Richard Zidlicky" <rz@linux-m68k.org>
Cc: "Andre Hedrick" <andre@linux-ide.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: IDE janitoring comments
Date: Mon, 23 Sep 2002 09:29:42 +0200
Message-Id: <20020923072942.21213@192.168.4.1>
In-Reply-To: <20020924000134.A210@linux-m68k.org>
References: <20020924000134.A210@linux-m68k.org>
X-Mailer: CTM PowerMail 4.0.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>we have one special problem on m68k, on some machines the IDE
>bus is byteswapped (unrelated to cpu endianness). For historical 
>and performance reasons data to the HD is by default read and 
>written in this "wrong" order (thus the bswap/swapdata option)
>and special fixup code is used in ide_fix_driveid (see 
>M68K_IDE_SWAPW). However data returned by IDE_DRIVE_CMD is not 
>treated in any way, so that eg WIN_SMART data end up in the 
>wrong order on those machines and this is something I would 
>like to fix properly.
>I figure I would define ata_*_{control,data} to handle special
>data resp raw HD data and modify ide_handler_parser to return
>specialised interrupt handlers or set some additional flag.
>
>Any thoughts?

You just need to provide your own ide-ops doing the right
thing, I don't think you need to touch ata_*_data if you
properly implement "s" ops {in,out}s{b,w,l} for your hwif.

Ben.


