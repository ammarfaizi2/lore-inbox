Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264360AbUFGJSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbUFGJSm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264368AbUFGJSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:18:41 -0400
Received: from mail020.syd.optusnet.com.au ([211.29.132.131]:38107 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264360AbUFGJSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:18:38 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [OT] Who has record no. of  DriveReady SeekComplete DataRequest errors?
Date: Mon, 7 Jun 2004 19:18:16 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200406060007.10150.kernel@kolivas.org> <200406070906.46392.kernel@kolivas.org> <20040607072414.GC13836@suse.de>
In-Reply-To: <20040607072414.GC13836@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406071918.16166.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jun 2004 17:24, Jens Axboe wrote:
> On Mon, Jun 07 2004, Con Kolivas wrote:
> > hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest
> > Error } hdd: status error: error=0x20LastFailedSense 0x02
> > hdd: drive not ready for command
> > hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
> > hdd: status error: error=0x00
> > ..etc
> Con, please try with this debug patch.

Here is the output:
hdd: RICOH CD-R/RW MP7163A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: max request size: 1024KiB
hdb: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
 hdb: hdb2 < hdb5 hdb6 hdb7 >
ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 10 00 00 00
ide-cd: queueing cdb: 5a 00 03 00 00 00 00 00 10 00 00 00
ide-cd: queueing cdb: 5a 00 2c 00 00 00 00 00 10 00 00 00
ide-cd: queueing cdb: 46 00 00 20 00 00 00 00 18 00 00 00
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-cd: queueing cdb: 00 00 00 00 00 00 00 00 00 00 00 00
ide-cd: queueing cdb: 25 00 00 00 00 00 00 00 00 00 00 00
ide-cd: queueing cdb: 43 02 00 00 00 00 00 00 04 00 00 00
ide-cd: queueing cdb: 5a 00 2a 00 00 00 00 00 18 00 00 00
ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 10 00 00 00
hdd: status error: status=0x59 { DriveReady SeekComplete DataRequest Error }
hdd: status error: error=0x20LastFailedSense 0x02
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: drive not ready for command
hdd: status error: status=0x58 { DriveReady SeekComplete DataRequest }
hdd: status error: error=0x00
hdd: DMA disabled
hdd: drive not ready for command
hdd: ATAPI reset complete


followed by

ide-cd: queueing cdb: 46 00 00 28 00 00 00 00 10 00 00 00

... repeat every so often until it comes to:

hdd: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache
ide-cd: queueing cdb: 00 00 00 00 00 00 00 00 00 00 00 00
ide-cd: queueing cdb: 25 00 00 00 00 00 00 00 00 00 00 00
ide-cd: queueing cdb: 43 02 00 00 00 00 00 00 04 00 00 00

and the errors stop at that point

Con
