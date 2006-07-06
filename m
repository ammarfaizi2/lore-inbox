Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWGFXII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWGFXII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 19:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWGFXIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 19:08:07 -0400
Received: from lucidpixels.com ([66.45.37.187]:27570 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751039AbWGFXIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 19:08:06 -0400
Date: Thu, 6 Jul 2006 19:08:05 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Sander <sander@humilis.net>
cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <20060219171651.GA8986@favonius>
Message-ID: <Pine.LNX.4.64.0607061906550.5107@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F1EE4A.3050107@rtr.ca>
 <43F58D29.3040608@pobox.com> <200602170959.40286.lkml@rtr.ca>
 <20060218204340.GA2984@favonius> <43F794D8.7000406@rtr.ca>
 <20060219071414.GA31299@favonius> <43F88F30.1070208@rtr.ca>
 <20060219171651.GA8986@favonius>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Look at this:

>From smartctl, look at the correspondence:
199 UDMA_CRC_Error_Count    0x000a   200   253   000    Old_age   Always 
-       4

[4301946.802000] ata4: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[4301946.802000] ata4: status=0x51 { DriveReady SeekComplete Error }
[4301946.802000] ata4: error=0x04 { DriveStatusError }
[4302380.482000] ata4: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[4302380.482000] ata4: status=0x51 { DriveReady SeekComplete Error }
[4302380.482000] ata4: error=0x04 { DriveStatusError }
[4302493.664000] ata4: no sense translation for status: 0x51
[4302493.664000] ata4: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 
0xb/00/00
[4302493.664000] ata4: status=0x51 { DriveReady SeekComplete Error }
[4302863.673000] ata4: no sense translation for status: 0x51
[4302863.673000] ata4: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 
0xb/00/00
[4302863.673000] ata4: status=0x51 { DriveReady SeekComplete Error }

different drive, different cable, same controller, but second port

So that Stat/err = UDMA_CRC_Error_Count!

Not sure if we can fix what is causing it (in Linux) but just FYI.

