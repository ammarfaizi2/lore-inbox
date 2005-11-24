Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932653AbVKXUVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbVKXUVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVKXUVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:21:24 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:47585 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1751392AbVKXUVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:21:23 -0500
Date: Thu, 24 Nov 2005 21:21:13 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <4384E1BC.4090708@pobox.com>
Message-ID: <Pine.LNX.4.63.0511241834390.28034@dingo.iwr.uni-heidelberg.de>
References: <437D2DED.5030602@pobox.com>
 <Pine.LNX.4.44.0511182241420.5095-100000@kenzo.iwr.uni-heidelberg.de>
 <20051118215209.GA9425@havoc.gtf.org> <Pine.LNX.4.63.0511211311260.22263@dingo.iwr.uni-heidelberg.de>
 <Pine.LNX.4.63.0511221809430.24388@dingo.iwr.uni-heidelberg.de>
 <4384E1BC.4090708@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Jeff Garzik wrote:

>> 1. several badblocks tests finished fine; the speed is also fine (about 
>> 50Mbytes/s both read and write as reported by both iostat during badblocks 
>> and bonnie++ on an ext2 FS).
> cool

... and it's getting even cooler: with 4 WD Raptor 74GB, I get about 
65MB/s per disk up to 3 disks accessed simultaneously; only when also 
using the 4th disk, the speed per disk decreases to about 50MB/s. 
Given than 3*65 ~ 4*50, I might reach some hidden limit, but it's 
already quite good. So I'd appreciate if people with similar hardware 
could test this, to see if there's a limit in the controller or in my 
system ;-)

I have to mention that the above figures were obtained not with RAID0, 
but with individual reading from each drive. RAID0 somehow made reads 
slower, I got only 120-130 MB/s total speed; writes over RAID0 were as 
expected about 200MB/s (I only tried RAID0 with 128k and 1024k chunk 
sizes).

When creating the array (with mdadm --create), I got these messages 
which I haven't seen before, although I played with SATA and RAID0 
with some older kernels:

ata4: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata4: status=0xd0 { Busy }
ata3: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata3: status=0xd0 { Busy }
ata2: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata2: status=0xd0 { Busy }
ata1: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
ata1: status=0xd0 { Busy }

(in this order, although the order specified on the mdadm command line 
was the opposite).

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
