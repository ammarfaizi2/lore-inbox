Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVHYL6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVHYL6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 07:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVHYL6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 07:58:50 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:15023 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964948AbVHYL6u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 07:58:50 -0400
Subject: Re: 2.6.13-rc7: crash on removing CF card
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
In-Reply-To: <20050825111943.GB4018@suse.de>
References: <20050825094846.GA2097@elf.ucw.cz>
	 <20050825111943.GB4018@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 25 Aug 2005 13:26:45 +0100
Message-Id: <1124972805.21456.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-08-25 at 13:19 +0200, Jens Axboe wrote:
> > Aug 25 11:35:23 amd kernel: hdf: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)
> > Aug 25 11:35:24 amd kernel: hdf: ^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H^H(^H^H^H(^H^H^H^H, ATA DISK drive
> > Aug 25 11:35:24 amd kernel: ide2 at 0x8040-0x8047,0x804e on irq 7

Interesting in itself - the slave on this adapter appears not to be
decoded, but worse still to produce garbage.

> > Aug 25 11:35:24 amd kernel: hde: max request size: 128KiB
> > Aug 25 11:35:24 amd kernel: hde: 503808 sectors (257 MB) w/0KiB Cache, CHS=984/16/32
> > Aug 25 11:35:24 amd kernel: hde: cache flushes not supported
> > Aug 25 11:35:24 amd kernel:  hde: hde1
> > Aug 25 11:35:24 amd kernel: hdf: max request size: 128KiB
> > Aug 25 11:35:24 amd kernel: hdf: 131584 sectors (67 MB) w/1028KiB Cache, CHS=2056/8/8
> > Aug 25 11:35:24 amd kernel: hdf: cache flushes not supported
> > Aug 25 11:35:54 amd kernel:  hdf:<6> hde:<4>hdf: lost interrupt
> > Aug 25 11:36:24 amd kernel: hdf: lost interrupt
> > Aug 25 11:36:54 amd kernel: hdf: lost interrupt
> > 

hdf never really existed so what follows initially is no surprise.


> > Aug 25 11:45:09 amd kernel: Buffer I/O error on device hdf, logical block 0
> > Aug 25 11:45:09 amd kernel:  unable to read partition table

We give up on the nonexistant hdf. It then looks as if the partition
code corrupted the request stuff or perhaps double freed something ?


