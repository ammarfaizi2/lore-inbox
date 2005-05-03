Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261804AbVECQCf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbVECQCf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 12:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVECQCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 12:02:34 -0400
Received: from aquila.skane.tbv.se ([193.13.139.7]:17822 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261804AbVECQCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 12:02:07 -0400
From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Date: Tue, 3 May 2005 18:02:01 +0200
To: Drew Winstel <DWinstel@Miltope.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Message-ID: <20050503160201.GA12461@oskar>
References: <66F9227F7417874C8DB3CEB057727417045148@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66F9227F7417874C8DB3CEB057727417045148@MILEX0.Miltope.local>
User-Agent: Mutt/1.5.6+20040907i
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "diadema.skane.tbv.se", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tuesday, May 03, 2005 at 10:17, Drew Winstel wrote:
	> > Hmm... that puzzles me, although for no other reason than I'm not
	familiar > with how Maxtor drives report themselves. Having the
	BIOS-reported LBA > sectors not equal to the OS-reported geometry may
	not be a problem, but > I must defer to the experts on that one. > > As
	an FYI just in case, the new libata-based driver will treat your drives
	> as SCSI drives, so you'll see the drives as sda, sdb, and so forth
	instead of > hd?. [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 03, 2005 at 10:17, Drew Winstel wrote:
> 
> Hmm... that puzzles me, although for no other reason than I'm not familiar 
> with how Maxtor drives report themselves.  Having the BIOS-reported LBA 
> sectors not equal to the OS-reported geometry may not be a problem, but 
> I must defer to the experts on that one.  
> 
> As an FYI just in case, the new libata-based driver will treat your drives 
> as SCSI drives, so you'll see the drives as sda, sdb, and so forth instead of
> hd?.  

Hm, I patched the kernel with 2.6.11-libata-dev1, compiled it with

# CONFIG_BLK_DEV_PDC202XX_NEW is not set
CONFIG_BLK_DEV_VIA82CXXX=y   (for the motherboard IDE)
CONFIG_SCSI=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_PATA_PDC2027X=y

and rebooted. SCSI is initialized and the pata_pdc2027x driver is
loaded, but it doesn't seem to find any devices. Or maybe it doesn't
look for devices at all. I can tell that it's loaded by the existence
of /sys/bus/pci/drivers/pata_pdc2027x (a directory which is empty).

/proc/scsi/scsi is also empty besides the "Attached devices:" line.
During startup the kernel does say "Probing IDE interface ide0"
through "ide5" (finding only devices on ide0). I also tried compiling
pata_pdc2027x as a module, with same result.

What's wrong here?

Regards,

Oskar Liljeblad (oskar@osk.mine.nu)
