Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265468AbUAZCQS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 21:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbUAZCQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 21:16:18 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:424 "EHLO
	gaimboi.tmr.com") by vger.kernel.org with ESMTP id S265468AbUAZCQP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 21:16:15 -0500
Message-ID: <4014789F.2000202@tmr.com>
Date: Sun, 25 Jan 2004 21:17:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Charles Shannon Hendrix <shannon@widomaker.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
References: <20040117031925.GA26477@widomaker.com>
In-Reply-To: <20040117031925.GA26477@widomaker.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles Shannon Hendrix wrote:
> 
> Is CD burning supposed to work with kernel 2.6.1 using the ATAPI
> interface, or are bugs still being worked out?
> 
> I have run cdrecord under kernel 2.4.2x and it worked great using the
> ATAPI interface like this:
> 
> % cdrecord dev=ATAPI:bus,drive,lun
> 
> Instant disk information reads, never had to reload media, and burns
> were fast and reliable.  It worked fine with ide-scsi as well, but I
> wanted to get away from that as it is going away.  It worked with
> several versions of cdrecord equally well.
> 
> I'm now running kernel 2.6.1, and using cdrecord with ATAPI is
> problematic.
> 
> First problem is that cdrecord now must reload media often, runs slowly,
> and burns slowly.  Reading CD/RW disks burned under 2.6.x is much slower
> than those burned under kernel 2.4 (same version of cdrecord in all
> cases).
> 
> -scanbus works fine:
> 
> % cdrecord dev=ATAPI -scanbus
> scsidev: 'ATAPI'
> devname: 'ATAPI'
> scsibus: -2 target: -2 lun: -2
> Warning: Using ATA Packet interface.
> Warning: The related libscg interface code is in pre alpha.
> Warning: There may be fatal problems.
> Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J?rg Schilling
> Using libscg version 'schily-0.7'
> scsibus0:
> 	0,0,0	  0) *
> 	0,1,0	  1) 'OPTORITE' 'CD-RW CW5205    ' '180E' Removable CD-ROM
> [rest of output snipped]
> 
> However, -msinfo doesn't work at all.
> 
> With a previously recorded CD/R, I get this:
> 
> % cdrecord dev=ATAPI:0,1,0 -msinfo
> cdrecord: No disk / Wrong disk!
> 
> With a previously recorded CD/RW disc, I get this:
> 
> % cdrecord dev=ATAPI:0,1,0 -msinfo
> cdrecord: Drive needs to reload the media to return to proper status.
> cdrecord: Input/output error. read track info: scsi sendcmd: no error
> CDB:  52 01 00 00 00 FF 00 00 1C 00
> status: 0x2 (CHECK CONDITION)
> Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00 00 00
> Sense Key: 0x5 Illegal Request, Segment 0
> Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
> Sense flags: Blk 0 (not valid) 
> cmd finished after 0.000s timeout 240s
> cdrecord: Cannot read first writable address
> 
> Both are successful and verified burns.
> 
> Another problem is that in later 2.4 kernels and 2.6 kernels, I often
> have to reload a CD several times before the drive recognizes it.  At
> first I figured the kernel could not possibly cause this, but it does.
> This doesn't happen when using ide-scsi.
> 
> It almost seems like cd burning worked in 2.6.0-mm2, but I no longer
> have that kernel to test.  I could possibly be convinced to rebuild it
> if anyone wants to confirm this.
> 
> I've had better overall luck using ide-scsi, but since it is going away,
> I decided to quit building it.
> 
> What should I do to continue debugging this problem?

I believe that you will find that you have to compile for 2.6 on a 
machine with /usr/src/linux pointing to the 2.6 kernel source. This is 
being discussed elsewhere, but is what got things working for me.


Also note, this is worth doing, you can burn audio CDs using DMA if you 
get a good build.
-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
