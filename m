Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUAQDnu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 22:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUAQDnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 22:43:50 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:9235 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S265971AbUAQDnr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 22:43:47 -0500
Date: Fri, 16 Jan 2004 22:19:26 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 2.6.1 and cdrecord on ATAPI bus
Message-ID: <20040117031925.GA26477@widomaker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Is CD burning supposed to work with kernel 2.6.1 using the ATAPI
interface, or are bugs still being worked out?

I have run cdrecord under kernel 2.4.2x and it worked great using the
ATAPI interface like this:

% cdrecord dev=ATAPI:bus,drive,lun

Instant disk information reads, never had to reload media, and burns
were fast and reliable.  It worked fine with ide-scsi as well, but I
wanted to get away from that as it is going away.  It worked with
several versions of cdrecord equally well.

I'm now running kernel 2.6.1, and using cdrecord with ATAPI is
problematic.

First problem is that cdrecord now must reload media often, runs slowly,
and burns slowly.  Reading CD/RW disks burned under 2.6.x is much slower
than those burned under kernel 2.4 (same version of cdrecord in all
cases).

-scanbus works fine:

% cdrecord dev=ATAPI -scanbus
scsidev: 'ATAPI'
devname: 'ATAPI'
scsibus: -2 target: -2 lun: -2
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
Cdrecord 2.00.3 (i686-pc-linux-gnu) Copyright (C) 1995-2002 Jörg Schilling
Using libscg version 'schily-0.7'
scsibus0:
	0,0,0	  0) *
	0,1,0	  1) 'OPTORITE' 'CD-RW CW5205    ' '180E' Removable CD-ROM
[rest of output snipped]

However, -msinfo doesn't work at all.

With a previously recorded CD/R, I get this:

% cdrecord dev=ATAPI:0,1,0 -msinfo
cdrecord: No disk / Wrong disk!

With a previously recorded CD/RW disc, I get this:

% cdrecord dev=ATAPI:0,1,0 -msinfo
cdrecord: Drive needs to reload the media to return to proper status.
cdrecord: Input/output error. read track info: scsi sendcmd: no error
CDB:  52 01 00 00 00 FF 00 00 1C 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 00 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x24 Qual 0x00 (invalid field in cdb) Fru 0x0
Sense flags: Blk 0 (not valid) 
cmd finished after 0.000s timeout 240s
cdrecord: Cannot read first writable address

Both are successful and verified burns.

Another problem is that in later 2.4 kernels and 2.6 kernels, I often
have to reload a CD several times before the drive recognizes it.  At
first I figured the kernel could not possibly cause this, but it does.
This doesn't happen when using ide-scsi.

It almost seems like cd burning worked in 2.6.0-mm2, but I no longer
have that kernel to test.  I could possibly be convinced to rebuild it
if anyone wants to confirm this.

I've had better overall luck using ide-scsi, but since it is going away,
I decided to quit building it.

What should I do to continue debugging this problem?







-- 
UNIX/Perl/C/Pizza____________________s h a n n o n@wido !SPAM maker.com
