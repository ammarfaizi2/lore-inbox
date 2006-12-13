Return-Path: <linux-kernel-owner+w=401wt.eu-S1751605AbWLMRjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWLMRjH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWLMRjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:39:07 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38034 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbWLMRjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:39:05 -0500
Message-ID: <45803AA0.8020203@us.ibm.com>
Date: Wed, 13 Dec 2006 09:38:40 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Douglas Gilbert <dougg@torque.net>
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>	<4574B004.6030606@us.ibm.com>  <457D8637.5070707@garzik.org>	<1165855489.2791.7.camel@mulgrave.il.steeleye.com>	<457F2C1C.1030503@us.ibm.com> <1166026240.2790.27.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1166026240.2790.27.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> Er, if it's really a CD-ROM, doesn't it need a blacklist entry with
> BLIST_ROM then?  Regardless, MMC is the only standard that seems to be
> inconsistent in this regard.  Anything claiming to conform to SBC will
> need to be explicitly blacklisted if it claims SCSI-3 or higher and
> doesn't support REPORT LUNS.

Sorry, I should have clarified this earlier--the Quantum GoVault is a
removable disk drive, not a CD-ROM.  The device is reminiscent of Zip
disks, but the cartridge is a sealed unit and contains a 2.5" SATA disk
inside; hence it's not a CD-ROM.  So the patch below won't work for me,
because sdev->type == TYPE_DISK.

I wonder if the same sort of REPORT LUNS screw-up might apply to other
ATAPI devices too, such as tape drives.  Since we've seen that
manufacturers of CD-ROMs and removable disks don't implement it, it
would not surprise me if the other ATAPI devices don't either.  But,
that's speculation on my part.

--D
