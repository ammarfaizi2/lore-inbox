Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbUEFIKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUEFIKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 04:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUEFIKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 04:10:32 -0400
Received: from cpmx.mail.saic.com ([139.121.17.160]:12489 "EHLO cpmx.saic.com")
	by vger.kernel.org with ESMTP id S261582AbUEFIKN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 04:10:13 -0400
Subject: Re: SATA device timeout using libata
From: Eamonn Hamilton <EAMONN.HAMILTON@saic.com>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0405051153570.21114-100000@coffee.psychology.mcmaster.ca>
References: <Pine.LNX.4.44.0405051153570.21114-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain
Message-Id: <1083830995.5386.88.camel@ukabzc383.uk.saic.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 09:09:55 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-05 at 17:49, Mark Hahn wrote:
> > Generally I can't trigger it on one drive, but that could just be a
> > timing issue. All of these controllers are hosted on an Asus A7V
> > motherboard with the VIA chipset, and we've managed to make it fall over
> 
> ah.  most people consider VIA chipsets to be pretty suspect from the get-go.
> I was hoping you were using a solid server-type chipset (Intel or
> AMD/opteron)...
I'd love to, but the components of the chipset are shared as all the
controllers are PCI and only the controllers with those drives attached
are delivering issues
> 
> > much more rapidly by simply mixing firmware revisions between drives on
> > a single controller. 
> 
> that seems odd, since unlike PATA, there should be no interaction between
> disks using SATA...
Yep, "odd" is a pretty fair description :)
> 
> > As to the sectors that are failing, they don't seem to repeat and the
> > disk itself again reports fine. It also works fine on it's own after a
> > reboot. The chap who actually owns the hardware is going to run a test
> > under W2K to try and eliminate plain hardware issues.
> 
> eww!  jgarzik might have something to say about this.  to me (hardly
> an expert), this looks almost like some kind of protocol misunderstanding - 
> perhaps that libata isn't handling status 0xD0 properly, or something 
> weirder like (blue sky example) if the driver reads status too early,
> it's reported wrong...
Given that it works fine with other drives of the type, and with other
manufacturers, I'm inclined to mostly absolve libata
> 
> > Does anybody know whether there is a firmware update available for these
> > drives, as that seems to be the only difference here.
> 
> to me, this all sniffs of a timing issue...
Agreed, I'm fairly certain it's something with the drives behaviour,
rather than the physical surfaces themselves
> 
> 
> > 
> > Cheers,
> > Eamonn
> > 
> > On Mon, 2004-05-03 at 17:45, Mark Hahn wrote:
> > > > One controller has 2 X WDC WD2000JD-00G drives which seem to work
> > > > perfectly, another has 2 X Maxtor 6Y200M0 which also seem to work fine,
> > > > however the the third pair of drives are WDC WD2000JD-00F and these seem
> > > > to deliver issues.
> > > 
> > > please do followup to the list (or linux-raid) if you resolve this!
> > > many, many of us are doing similar things (or planning to).
> > > 
> > > > Basically, when attempting to stress a RAID-5 array while the array is
> > > > synchronising, I get the following after an hour or so:   
> > > 
> > > can you trigger this sort of thing using a stresstest on a single disk,
> > > or with raid0?
> > > 
> > > > ata3: DMA timeout, stat 0x1
> > > > ATA: abnormal status 0xD0 on port 0xE087B087
> > > > scsi2: ERROR on channel 0, id 0, lun 0, CDB: Read (10) 00 01 92 8d 47 00
> > > > 00 08 00
> > > > Current sdc: sense key Medium Error
> > > > Additional sense: Unrecovered read error - auto reallocate failed
> > > > end_request: I/O error, dev sdc, sector 26381639
> > > 
> > > does that sector repeat across multiple errors?  unfortunately,
> > > one good response to this would be to use smartctl (but libata 
> > > currently doens't do the passthrough required afaikt...)
> > > 
> > > > The interesting part here is that the hardware checks out fine using the
> > > > manufacturers test disk in the same configuration, and having recabled
> > > 
> > > it would be interesting to know what the vendor's test actually does...
> > 

