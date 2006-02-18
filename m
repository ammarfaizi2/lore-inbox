Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWBRVwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWBRVwG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 16:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWBRVwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 16:52:06 -0500
Received: from lucidpixels.com ([66.45.37.187]:19388 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932193AbWBRVwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 16:52:04 -0500
Date: Sat, 18 Feb 2006 16:51:59 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: sander@humilis.net, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <43F794D8.7000406@rtr.ca>
Message-ID: <Pine.LNX.4.64.0602181651490.4315@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca>
 <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca>
 <20060218204340.GA2984@favonius> <43F794D8.7000406@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ for i in `seq 10`
> do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
> done
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 190.997693 seconds (54899930 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 212.242724 seconds (49404568 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 189.324450 seconds (55385134 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 190.280352 seconds (55106898 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 191.567239 seconds (54736708 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 183.640928 seconds (57099254 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 179.974098 seconds (58262606 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 190.126087 seconds (55151611 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 192.227807 seconds (54548612 bytes/sec)
10000+0 records in
10000+0 records out
10485760000 bytes transferred in 185.309607 seconds (56585086 bytes/sec)
war@p34:/x4$ md5sum bigfile.*
26f56024ac39cdc54b228820107f040d  bigfile.1
26f56024ac39cdc54b228820107f040d  bigfile.10
26f56024ac39cdc54b228820107f040d  bigfile.2
26f56024ac39cdc54b228820107f040d  bigfile.3
26f56024ac39cdc54b228820107f040d  bigfile.4
26f56024ac39cdc54b228820107f040d  bigfile.5
26f56024ac39cdc54b228820107f040d  bigfile.6
26f56024ac39cdc54b228820107f040d  bigfile.7
26f56024ac39cdc54b228820107f040d  bigfile.8
26f56024ac39cdc54b228820107f040d  bigfile.9

No errors in dmesg yet (for my issue).

On Sat, 18 Feb 2006, Mark Lord wrote:

> Sander wrote:
>> Mark Lord wrote (ao):
>>> On Friday 17 February 2006 03:45, Jeff Garzik wrote:
>>>> Submit a patch... 
>>> You mean, something like this one?
> ...
>> [  633.449961] md: md1: sync done.
>> [  633.456070] RAID5 conf printout:
>> [  633.456117]  --- rd:9 wd:9 fd:0
> ...
>> [ 1872.338185] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
>> SK/ASC/ASCQ 0xb/47/00
>> [ 1872.338239] ata6: status=0xd0 { Busy }
>> [ 5749.285084] ata8: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
>> SK/ASC/ASCQ 0xb/47/00
>> [ 5749.285138] ata8: status=0xd0 { Busy }
>> [ 5906.008461] ata6: translated op=0x2a ATA stat/err 0xd0/00 to SCSI 
>> SK/ASC/ASCQ 0xb/47/00
>> [ 5906.008515] ata6: status=0xd0 { Busy }
> ...
>> This is with 2.6.16-rc3, your patch, and running nine Maxtors disks
>> over onboard nForce4 and MV88SX6081 8-port SATA II PCI-X Controller (rev 
>> 09).
>> 
>> for i in `seq 10`
>> do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
>> done
>> md5sum bigfile.*
>> 
>> The errors mostly seem to happen during the md5sum (not during the dd).
>
> SCSI opcode 0x2a is WRITE_10, so the errors are being reported
> in response to the writes to bigfile.$i.  But these are different
> from the previously reported error status values -- I wonder why
> it's getting "Busy" back as a status here ??
>
