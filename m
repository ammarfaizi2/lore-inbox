Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318961AbSHQBxz>; Fri, 16 Aug 2002 21:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318991AbSHQBxz>; Fri, 16 Aug 2002 21:53:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44816 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318961AbSHQBxy>;
	Fri, 16 Aug 2002 21:53:54 -0400
Message-ID: <3D5DB023.AE0D005@zip.com.au>
Date: Fri, 16 Aug 2002 19:08:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE?
References: <200208170058.39227.m.c.p@wolk-project.de> <Pine.LNX.4.44L.0208162116230.1430-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 17 Aug 2002, Marc-Christian Petersen wrote:
> > > In article <2444170000.1029531611@flay>,
> > > Martin J. Bligh <Martin.Bligh@us.ibm.com> wrote:
> > > > So did Linus get disk corruption or is something else afoot?
> > > Martin gave up the fight he had to do all the time, so..
> >
> > I am beside my self with laughing, sorry :P
> 
> Having thrown away months and months of hard work, or
> giving up on months of hard work is NOT FUN.
> 
> I'm thankful Martin tried to make the IDE layer better.
> 
> His method of removing things to "add a better implementation
> later" may not have worked out in the end, but I'm thankful
> he tried.
> 

Yes.   Martin starkly demonstrated how much work is needed in
there, and how much cruft has accumulated.  That is valuable.

And I take back my bugreport regarding failure to read the final
eight sectors of my 80 gig maxtors on HPT374.  Linus' current
tree has the same failure.

(gdb) bt
#0  __lock_page (page=0xc108141c) at /usr/src/25/include/asm/bitops.h:136
#1  0xc012d313 in lock_page (page=0xc3ff48c0) at filemap.c:710
#2  0xc012e561 in read_cache_page (mapping=0xc2f6d3c4, index=7, filler=0xc0143dc0 <blkdev_readpage>, data=0x0)
    at filemap.c:1765
#3  0xc016488e in read_dev_sector (bdev=0xc2f11f60, n=63, p=0xc3fdbe38) at check.c:458
#4  0xc0164a3b in parse_extended (state=0xc2f02000, bdev=0xc2f11f60, first_sector=63, first_size=48243132)
    at msdos.c:106
#5  0xc0164d7f in msdos_partition (state=0xc2f02000, bdev=0xc2f11f60) at msdos.c:433
#6  0xc01646a6 in check_partition (hd=0xc2fb73c0, bdev=0xc2f11f60) at check.c:288
#7  0xc0164840 in grok_partitions (dev={value = 8448}, size=160086528) at check.c:448
#8  0xc01647b6 in register_disk (gdev=0xc2fb73c0, dev={value = 8448}, minors=64, ops=0xc0322660, size=160086528)
    at check.c:422
#9  0xc0212193 in idedisk_attach (drive=0xc03895dc) at ide-disk.c:1492
#10 0xc020a751 in subdriver_match (channel=0xc03894b0, ops=0xc03230e0) at main.c:526
#11 0xc020aac6 in register_ata_driver (driver=0xc03230e0) at main.c:1090
#12 0xc033f3dd in idedisk_init () at ide-disk.c:1503
#13 0xc033d914 in ata_module_init () at main.c:1377
#14 0xc033da27 in init_ata () at main.c:1417


(And grep bio drivers/ide/ataraid.c || echo drat)
