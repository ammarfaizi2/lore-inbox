Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264706AbUEEPsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbUEEPsh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 11:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264705AbUEEPsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 11:48:37 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:10663 "EHLO cpmx.saic.com")
	by vger.kernel.org with ESMTP id S264706AbUEEPsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 11:48:32 -0400
Subject: Re: SATA device timeout using libata
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0405031242510.6080-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0405031242510.6080-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Message-Id: <1083772094.5386.83.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 05 May 2004 16:48:14 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Generally I can't trigger it on one drive, but that could just be a
timing issue. All of these controllers are hosted on an Asus A7V
motherboard with the VIA chipset, and we've managed to make it fall over
much more rapidly by simply mixing firmware revisions between drives on
a single controller. 

The problem seems to track the WD2000JD-00F drives, and when one of
those drives is on the same controller as a WD2000JD-00G the whole thing
falls over in a couple of minutes.

As to the sectors that are failing, they don't seem to repeat and the
disk itself again reports fine. It also works fine on it's own after a
reboot. The chap who actually owns the hardware is going to run a test
under W2K to try and eliminate plain hardware issues.

Does anybody know whether there is a firmware update available for these
drives, as that seems to be the only difference here.

Cheers,
Eamonn

On Mon, 2004-05-03 at 17:45, Mark Hahn wrote:
> > One controller has 2 X WDC WD2000JD-00G drives which seem to work
> > perfectly, another has 2 X Maxtor 6Y200M0 which also seem to work fine,
> > however the the third pair of drives are WDC WD2000JD-00F and these seem
> > to deliver issues.
> 
> please do followup to the list (or linux-raid) if you resolve this!
> many, many of us are doing similar things (or planning to).
> 
> > Basically, when attempting to stress a RAID-5 array while the array is
> > synchronising, I get the following after an hour or so:   
> 
> can you trigger this sort of thing using a stresstest on a single disk,
> or with raid0?
> 
> > ata3: DMA timeout, stat 0x1
> > ATA: abnormal status 0xD0 on port 0xE087B087
> > scsi2: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 01 92 8d 47 00
> > 00 08 00
> > Current sdc: sense key Medium Error
> > Additional sense: Unrecovered read error - auto reallocate failed
> > end_request: I/O error, dev sdc, sector 26381639
> 
> does that sector repeat across multiple errors?  unfortunately,
> one good response to this would be to use smartctl (but libata 
> currently doens't do the passthrough required afaikt...)
> 
> > The interesting part here is that the hardware checks out fine using the
> > manufacturers test disk in the same configuration, and having recabled
> 
> it would be interesting to know what the vendor's test actually does...

