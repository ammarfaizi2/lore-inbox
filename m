Return-Path: <linux-kernel-owner+w=401wt.eu-S964898AbXASURe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbXASURe (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 15:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbXASURe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 15:17:34 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:40470 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964898AbXASURd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 15:17:33 -0500
X-Greylist: delayed 1535 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Jan 2007 15:17:33 EST
From: chunkeey@web.de
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Fri, 19 Jan 2007 20:51:52 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>,
       =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       chunkeey@web.de
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AC3006.9070705@garzik.org> <200701191505.33480.s0348365@sms.ed.ac.uk>
In-Reply-To: <200701191505.33480.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701192051.52919.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 19. January 2007 16:05, Alistair John Strachan wrote:
> On Tuesday 16 January 2007 01:53, Jeff Garzik wrote:
> > Robert Hancock wrote:
> > > I'll try your stress test when I get a chance, but I doubt I'll run
> > > into the same problem and I haven't seen any similar reports. Perhaps
> > > it's some kind of wierd timing issue or incompatibility between the
> > > controller and that drive when running in ADMA mode? I seem to remember
> > > various reports of issues with certain Maxtor drives and some nForce
> > > SATA controllers under Windows at least..
> >
> > Just to eliminate things, has disabling ADMA been attempted?
> >
> > It can be disabled using the sata_nv.adma module parameter.
>
> Setting this option fixes the problem for me. I suggest that ADMA defaults
> off in 2.6.20, if there's still time to do that.

Not for me.
I'm still have the same trouble, but less (maybe about every hour, instead of 
every 5 minutes). futhermore, I found a patch
cocktail-2.6.20-rc3.patch: http://tinyurl.com/2gza8q, which improves the 
situation too! 

Now, the funny thing is that I've two SATA HDDs, but only 1 causes all the
headaches.

The affected drive is a:
sda - @ata3.0 - WDC WD2500KS-00M 02.0
ATA-7, max UDMA/133, 488395055 sectors: LBA48

"ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 out
         res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/133:PIO0
ata3: EH complete
SCSI device sda: 488395055 512-byte hdwr sectors (250058 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00"

the "good" HDD is a:
sdb - @ata4.0 - WDC WD2500YD-01N 10.0
ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 0/1)

System:
AMD64 4200+ 
nForce 4 SLI
2 GB
SMP PREEMPT kernel
