Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291318AbSBMCku>; Tue, 12 Feb 2002 21:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291314AbSBMCka>; Tue, 12 Feb 2002 21:40:30 -0500
Received: from [63.231.122.81] ([63.231.122.81]:57686 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291312AbSBMCkT>;
	Tue, 12 Feb 2002 21:40:19 -0500
Date: Tue, 12 Feb 2002 19:35:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, Padraig Brady <padraig@antefacto.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020212193555.X9826@lynx.turbolabs.com>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Padraig Brady <padraig@antefacto.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020212140624.R9826@lynx.turbolabs.com> <Pine.LNX.4.33L2.0202121633070.1530-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0202121633070.1530-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Tue, Feb 12, 2002 at 04:49:51PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2002  16:49 -0800, Randy.Dunlap wrote:
> On Tue, 12 Feb 2002, Andreas Dilger wrote:
> | My thought on this is to make it a tristate [y/m/n] and have it print
> | output via /dev/kconfig or similar.  There could be a dep_bool which
> | keeps it in-core, or puts it in an init function which is discarded
> | after boot.  If you don't want to have it at all, you turn it off.
> | If you want it in the kernel, but not in memory all the time, it can
> | be in an init function (maybe printk'ing it before startup is done?).
> | It can be in a module and you can get the original plain-text config
> | back with "cat /dev/kconfig" and if it is a module it will be auto-loaded
> | from wherever it is.
> |
> | You can also extract it from an uncompressed kernel (vmlinux) or the
> | module with "strings <file> | grep '[A-Z]*=[ym]$'".  It is simple
> | enough to search for the gzip magic (1f 8b 08 00 at about 16-18kB)
> | in a zImage or bzImage, and then pipe it to gunzip and strings as above.
> 
> Thanks for the info.
> 
> Yes, I can see the gzip header, using 'od'.
> 
> What's an existing tool to strip (delete) bootsect and setup
> from the beginning of [b]zImage, up to the gzip header, so
> that the rest of the file can be piped to gunzip ?
> Otherwise I can write one.

I thought that zcat might be a bit tolerant as to checking for gzip
magic not exactly at the beginning of the file.  There is something
like this as part of the "mknbi" tool (from etherboot) on SourceForge,
but it is probably just as easy to make a simple C program which looks
for the magic, and then execs zcat and pipes the rest of the file to it.

This would be useful for other things besides the config issue (e.g.
getting a vmlinux that you can run GDB with from a bzImage).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

