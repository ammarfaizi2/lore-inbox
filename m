Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266621AbUFWT25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266621AbUFWT25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266622AbUFWT25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:28:57 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:50140 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266621AbUFWT2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:28:53 -0400
Date: Wed, 23 Jun 2004 21:29:00 +0200
From: Kronos <kronos@people.it>
To: cdwrite@other.debian.org
Cc: linux-kernel@vger.kernel.org
Subject: [ISOFS] Troubles with multi session DVDs.
Message-ID: <20040623192900.GA20511@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm having a strange (at least for me) problem burning multisession
DVD+R media: the dvd becomes unreadable after the 3rd session is burned.
mount refuses to do its work, and kernel says:

Unable to identify CD-ROM format.

Note that there isn't any read error, so the kernel is simply unable to
locate the primary volume descriptor.

That happened with 3 different disks (and different data, though
sessions size were similar). DVD were burned with growisofs (5.19.4.9.7)
using the following command:

growisofs -M /dev/hdc -J -r <files> (-Z for the first session)

mkisofs version is 2.01a29.

I don't think that the problem is related to the inode wrap after 4GB
because:
* The 1st and 2nd sessions took about 2.6GB, the last was 1.8GB so
  directories should be before the 4GB boundary.
* I tried the patch from Paul Serice without success.

This is the output of dvd+rw-mediainfo:

INQUIRY:                [_NEC    ][DVD_RW ND-1300A ][1.0A]
GET [CURRENT] CONFIGURATION:
 Mounted Media:         1Bh, DVD+R
GET [CURRENT] PERFORMANCE:
 Write Performance:     3.9x1385=5408KB/s@[0 -> 2295104]
 Speed Descriptor#0:    00/2295104 R@7.8x1385=10816KB/s W@3.9x1385=5408KB/s
 Speed Descriptor#1:    00/2295104 R@7.8x1385=10816KB/s W@2.3x1385=3245KB/s
READ DVD STRUCTURE[#0h]:
 Media Book Type:       A1h, DVD+R book [revision 1]
 Media ID:              RICOHJPN/R01
 Legacy lead-out at:    2295104*2KB=4700372992
READ DISC INFORMATION:
 Disc status:           appendable
 Number of Sessions:    4
 State of Last Session: empty
 "Next" Track:          4
 Number of Tracks:      4
READ TRACK INFORMATION[#1]:
 Track State:           partial
 Track Start Address:   0*2KB
 Free Blocks:           0*2KB
 Track Size:            899648*2KB
READ TRACK INFORMATION[#2]:
 Track State:           partial
 Track Start Address:   901696*2KB
 Free Blocks:           0*2KB
 Track Size:            435648*2KB
READ TRACK INFORMATION[#3]:
 Track State:           partial
 Track Start Address:   1339392*2KB
 Free Blocks:           0*2KB
 Track Size:            896000*2KB
READ TRACK INFORMATION[#4]:
 Track State:           blank
 Track Start Address:   2237440*2KB
 Next Writable Address: 2237440*2KB
 Free Blocks:           57664*2KB
 Track Size:            57664*2KB
FABRICATED TOC:
 Track#1  :             17@0
 Track#2  :             17@901696
 Track#3  :             17@1339392
 Track#AA :             17@2235392
 Multi-session Info:    #3@1339392

Same dvd, TOC dumped with cdrecord-prodvd:

WARNING: Phys disk size 2295104 differs from rzone size 899648! Prerecorded disk?
WARNING: Phys start: 196608 Phys end 2491711
first: 1 last 3
track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 7 mode: -1
track:   2 lba:    901696 (  3606784) -56:24:46 adr: 1 control: 7 mode: -1
track:   3 lba:   1339392 (  5357568) -1:59:74 adr: 1 control: 7 mode: -1
track:lout lba:   2235392 (  8941568) -1:59:74 adr: 1 control: 7 mode: -1

Note that I get similar warnings for the other DVDs.

Kernel is 2.6.6 (and 2.6.7 for the last dvd), DMA is on for both the HD
and the DVD recorder. Also I don't have any problem filling the DVD in
one session.

The "other" OS is able to read the disk, so this may be a problem in the
isofs code (that's why I put lkml on CC).

Any idea of what's going on?

thanks,
Luca
PS: cc me, I'm not subscribed.
-- 
Home: http://kronoz.cjb.net
La vasca da bagno fu inventata nel 1850, il telefono nel 1875.
Se fossi vissuto nel 1850, avrei potuto restare in vasca per 25 anni
senza sentir squillare il telefono
