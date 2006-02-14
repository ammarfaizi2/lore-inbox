Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422892AbWBNX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422892AbWBNX6j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422890AbWBNX6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:58:38 -0500
Received: from lucidpixels.com ([66.45.37.187]:32128 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1422888AbWBNX6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:58:38 -0500
Date: Tue, 14 Feb 2006 18:58:37 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <43F1EE4A.3050107@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602141857500.5959@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI:

Make a 100GB file, md5sum it, copy it to 'problem' drive and md5sum it, 
same MD5SUMS.

box:/x8# /usr/bin/time dd if=/dev/zero of=100gb bs=1M count=100000 ; 
/usr/bin/time md5sum 100gb; /usr/bin/time cp 100gb /x4 ; cd /x4 ; 
/usr/bin/time md5sum 100gb
100000+0 records in
100000+0 records out
104857600000 bytes transferred in 4735.034107 seconds (22145057 bytes/sec)
0.29user 245.59system 1:18:55elapsed 5%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (0major+210minor)pagefaults 0swaps
1e95cd44e2cb773f483ea7b2f676258d  100gb
248.24user 98.17system 32:50.97elapsed 17%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (1major+188minor)pagefaults 0swaps
14.75user 341.92system 35:25.25elapsed 16%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (4major+183minor)pagefaults 0swaps
1e95cd44e2cb773f483ea7b2f676258d  100gb
246.95user 110.41system 28:06.49elapsed 21%CPU (0avgtext+0avgdata 
0maxresident)k
0inputs+0outputs (1major+190minor)pagefaults 0swaps
box:/x4#

Also, all SMART tests passed with flying colors..

(FYI)


On Tue, 14 Feb 2006, Mark Lord wrote:

> Justin Piszcz wrote:
> ..
>>  ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>>  ata3: status=0x51 { DriveReady SeekComplete Error }
>>  ata3: error=0x04 { DriveStatusError }
>
> I wonder if the FUA logic is inserting cache-flush commands
> and perhaps the drive is rejecting those?
>
> Jeff, we really ought to be including the failed ATA opcode
> in those error messages!!
>
> Cheers
>
