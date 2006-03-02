Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWCBBwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWCBBwD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCBBwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:52:03 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:17544 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751377AbWCBBwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:52:00 -0500
Message-ID: <44064FBF.2010408@comcast.net>
Date: Wed, 01 Mar 2006 20:51:59 -0500
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATA: New patch (2.6.16rc5-ide2)
References: <1141242515.23170.6.camel@localhost.localdomain>
In-Reply-To: <1141242515.23170.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been following along closely, trying to figure out why fixating cds 
hasn't been working.  Fortunately, this last patch has allowed cd 
writing to finally work.  It may have been fixed in the last patch for 
this kernel since I didn't try cdrecord directly with it, just 
graveman.   In any case, cd writing seems to be working wonderfully.  
Now the problem is dvd writing.  I'm apparently unable to even sense 
dvd-R's in the drive for writing.  Errors i'm getting from dvdrecord and 
such is the following (graveman just says it detects a CDR and it uses 
readcd)

This error occurs on every DVD-R I try, and I know it's not a disc 
problem because they burn fine in the other computer, and they used to 
work before libata.

I get no errors in dmesg, so I'm not sure what is going on here.   CD 
writing/reading works, dvd reading works but dvd writing (at least 
minus, i have no plus right now) doesn't.

If any further info is needed just ask.

Driveropts: 'burnproof'
atapi: 1
Device type    : Removable CD-ROM
Version        : 5
Response Format: 2
Capabilities   :
Vendor_info    : 'PLEXTOR '
Identifikation : 'DVDR   PX-712A  '
Revision       : '1.07'
Device seems to be: Generic mmc2 DVD.
Using generic SCSI-3/mmc DVD-R(W) driver (mmc_mdvd).
Driver flags   : SWABAUDIO BURNFREE
Supported modes: PACKET SAO
Drive buf size : 6684672 = 6528 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data  4192 MB         padsize:   30 KB
Lout start:     4814 MB (477:01/06) = 2146431 sectors
Current Secsize: 2048
  ATIP start of lead in:  -150 (00:00/00)
Disk type:    unknown dye (reserved id code)
Manuf. index: -1
Manufacturer: unknown (not in table)
Blocks total: 2298496 Blocks current: 2298496 Blocks remaining: 152065

scsidev: '/dev/sg4'
devname: '/dev/sg4'
scsibus: -2 target: -2 lun: -2
Scanning device, b=4294967295
Linux sg driver version: 3.5.33
/usr/local/bin/cdrecord: Warning: using inofficial version of libscg 
(bero-0.5a '@(#)scsitransp.c    1.81 01/04/20 Copyright 1988,1995,2000 
J. Schilling').
trackno=0
BURN-Free is OFF.
Performing OPC...
Sending CUE sheet...
@01T004192
/usr/local/bin/cdrecord: Turning BURN-Free on
/usr/local/bin/cdrecord: Input/output error. write_g1: scsi sendcmd: no 
error
CDB:  2A 00 00 20 C1 26 00 00 1F 00
status: 0x2 (CHECK CONDITION)
Sense Bytes: 70 00 05 00 00 00 00 0A 00 00 00 00 21 02 00 00
Sense Key: 0x5 Illegal Request, Segment 0
Sense Code: 0x21 Qual 0x02 (logical block address out of range) [No 
matching qualifier] Fru 0x0
Sense flags: Blk 0 (not valid)
resid: 63488
cmd finished after 0.005s timeout 200s

write track data: error after 0 bytes
Writing  time:    5.024s
Sense Bytes: 70 00 00 00 00 00 00 0A 00 00 00 00 00 00 00 00 00 00

