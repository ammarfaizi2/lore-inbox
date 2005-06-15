Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVFOUje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVFOUje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVFOUj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:39:29 -0400
Received: from osten.wh.Uni-Dortmund.DE ([129.217.129.130]:25291 "EHLO
	osten.wh.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261545AbVFOUjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:39:15 -0400
Message-ID: <42B091EE.4020802@web.de>
Date: Wed, 15 Jun 2005 22:39:10 +0200
From: Alexander Fieroch <fieroch@web.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [2.6.12rc4] PROBLEM: "drive appears confused" and "irq 18: nobody
 cared!"
References: <d6gf8j$jnb$1@sea.gmane.org>	 <20050527171613.5f949683.akpm@osdl.org> <429A2397.6090609@web.de> <58cb370e05061401041a67cfa7@mail.gmail.com>
In-Reply-To: <58cb370e05061401041a67cfa7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "Integrated Technology Express, Inc. IT/ITE8212 Dual channel ATA
RAID controller" and a missing driver in the current kernel is
responsible for that problem.

I've found a GPL ITE8212 driver at
ftp://ftp.asus.de/pub/ASUSCOM/TREIBER/CONTROLLER/IDE/ITE/ITE8212.zip

The driver is compiling and working up to kernel 2.6.9.
With newer kernel versions I get following error while compiling:

# make
make -C /usr/src/linux-2.6.12rc6-git6
SUBDIRS=/usr/src/linux-2.6.12rc6-git6/drivers/scsi modules
make[1]: Entering directory `/usr/src/linux-2.6.12rc6-git6'
  CC [M]  /usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.o
In file included from
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.c:250:
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/hosts.h:1:2: warning:
#warning "This file is obsolete, please use <scsi/scsi_host.h> instead"
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.c: In function
`itedev_open':
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.c:5580: error:
`MOD_INC_USE_COUNT' undeclared (first use in this function)
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.c:5580: error: (Each
undeclared identifier is reported only once
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.c:5580: error: for
each function it appears in.)
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.c: In function
`itedev_close':
/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.c:5817: error:
`MOD_DEC_USE_COUNT' undeclared (first use in this function)
make[2]: *** [/usr/src/linux-2.6.12rc6-git6/drivers/scsi/iteraid.o] Error 1
make[1]: *** [_module_/usr/src/linux-2.6.12rc6-git6/drivers/scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.6.12rc6-git6'
make: *** [modules] Error 2



Because of the driver is published under GPL could you please adapt this
to newer kernel versions and include it in the next kernel 2.6.12?

