Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269106AbTCBDUk>; Sat, 1 Mar 2003 22:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269107AbTCBDUk>; Sat, 1 Mar 2003 22:20:40 -0500
Received: from virtisp1.zianet.com ([216.234.192.105]:31507 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S269106AbTCBDUj>; Sat, 1 Mar 2003 22:20:39 -0500
Subject: Re: [PATCH] kernel source spellchecker
From: Steven Cole <elenstev@mesatop.com>
To: Dan Kegel <dank@kegel.com>
Cc: Matthias Schniedermeyer <ms@citd.de>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca,
       Tak-Shing Chan <chan@aleph1.co.uk>
In-Reply-To: <3E6167B1.6040206@kegel.com>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de>
	<3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com> 
	<3E6167B1.6040206@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 01 Mar 2003 20:29:47 -0700
Message-Id: <1046575789.7527.438.camel@spc1.mesatop.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-01 at 19:08, Dan Kegel wrote:
[snipped]
> 
> This corrections file is probably good enough to actually use.
> I'm running it against linux-2.5.63-bk5 now...
> - Dan
[snippage]
> Pseudo=Psuedo

Hmm, psuedo didn't get caught.  Is psuedo code particularly smooth?

Anyway, looking beyond comments only may catch real bugs.
I found this a few days ago whilst looking for commonly
misspelled words, a much weaker technique than your spellchecker.

[steven@spc5 linus-2.5]$ bk export -tplain ../linux
[steven@spc5 linus-2.5]$ cd ../linux
[steven@spc5 linux]$ find . -type f | xargs grep psuedo
./arch/ppc64/kernel/iSeries_IoMmTable.h:/*   allocated the psuedo I/O Address.                                  */
./drivers/base/platform.c: * platform.c - platform 'psuedo' bus for legacy devices
./drivers/scsi/aic7xxx/aic7xxx.seq: * use byte 27 of the SCB as a psuedo-next pointer and to thread a list
./drivers/scsi/g_NCR5380.c: *   Perform a psuedo DMA mode read from an NCR53C400 or equivalent
./drivers/scsi/g_NCR5380.c: *   Perform a psuedo DMA mode read from an NCR53C400 or equivalent
./drivers/video/skeletonfb.c: * no color palettes are supported. Here a psuedo palette is created
./drivers/video/anakinfb.c:     fb_info.psuedo_palette = colreg;
----------------------------------------^^^^^^
This shouldn't even compile.

[steven@spc5 linux]$ find . -name "*.h" | xargs grep pseudo_palette
./drivers/video/i810/i810.h:    u32 pseudo_palette[17];
./include/linux/fb.h:   void *pseudo_palette;                /* Fake palette of 16 colors and

Yep, a mistake all right.  Adding the listed author to the cc list.

Steven

