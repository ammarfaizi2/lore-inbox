Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSBMAy6>; Tue, 12 Feb 2002 19:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291280AbSBMAys>; Tue, 12 Feb 2002 19:54:48 -0500
Received: from air-2.osdl.org ([65.201.151.6]:50950 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S291272AbSBMAyk>;
	Tue, 12 Feb 2002 19:54:40 -0500
Date: Tue, 12 Feb 2002 16:49:51 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andreas Dilger <adilger@turbolabs.com>
cc: Bill Davidsen <davidsen@tmr.com>, Padraig Brady <padraig@antefacto.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <20020212140624.R9826@lynx.turbolabs.com>
Message-ID: <Pine.LNX.4.33L2.0202121633070.1530-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Andreas Dilger wrote:

| On Feb 12, 2002  13:32 -0500, Bill Davidsen wrote:
| > On Tue, 12 Feb 2002, Padraig Brady wrote:
| > > I'd go for tacking it on at the end of the bzImage. Advantages would be
| > > that it can be read even when the kernel isn't loaded, and also there
| > > is no danger of loading a module in another kernel.
| >
| > There are several problems with that:
| > 1 - built into the kernel it is compressed and needs a tool to read
| > 2 - the reason kernels are compressed is to make them fit in small boot
| >     media, so adding something to the image is not to be done lightly.
| > 3 - modules are NOT compressed, and can be read with the strings command.
| > 4 - other files in the modules directory are pure text and if the config
| >     was just text it could be read with `cat.'
|
| My thought on this is to make it a tristate [y/m/n] and have it print
| output via /dev/kconfig or similar.  There could be a dep_bool which
| keeps it in-core, or puts it in an init function which is discarded
| after boot.  If you don't want to have it at all, you turn it off.
| If you want it in the kernel, but not in memory all the time, it can
| be in an init function (maybe printk'ing it before startup is done?).
| It can be in a module and you can get the original plain-text config
| back with "cat /dev/kconfig" and if it is a module it will be auto-loaded
| from wherever it is.
|
| You can also extract it from an uncompressed kernel (vmlinux) or the
| module with "strings <file> | grep '[A-Z]*=[ym]$'".  It is simple
| enough to search for the gzip magic (1f 8b 08 00 at about 16-18kB)
| in a zImage or bzImage, and then pipe it to gunzip and strings as above.

Thanks for the info.

Yes, I can see the gzip header, using 'od'.

What's an existing tool to strip (delete) bootsect and setup
from the beginning of [b]zImage, up to the gzip header, so
that the rest of the file can be piped to gunzip ?
Otherwise I can write one.

Thanks,
-- 
~Randy

