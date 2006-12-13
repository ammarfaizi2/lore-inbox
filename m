Return-Path: <linux-kernel-owner+w=401wt.eu-S965047AbWLMR6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWLMR6u (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWLMR6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:58:50 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:46474 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965047AbWLMR6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:58:48 -0500
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Douglas Gilbert <dougg@torque.net>
In-Reply-To: <45803AA0.8020203@us.ibm.com>
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>
	 <4574B004.6030606@us.ibm.com>  <457D8637.5070707@garzik.org>
	 <1165855489.2791.7.camel@mulgrave.il.steeleye.com>
	 <457F2C1C.1030503@us.ibm.com>
	 <1166026240.2790.27.camel@mulgrave.il.steeleye.com>
	 <45803AA0.8020203@us.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 11:57:25 -0600
Message-Id: <1166032646.2790.39.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 09:38 -0800, Darrick J. Wong wrote:
> Sorry, I should have clarified this earlier--the Quantum GoVault is a
> removable disk drive, not a CD-ROM.  The device is reminiscent of Zip
> disks, but the cartridge is a sealed unit and contains a 2.5" SATA disk
> inside; hence it's not a CD-ROM.  So the patch below won't work for me,
> because sdev->type == TYPE_DISK.

So it's a SATAPI device of type 0 ... that's fun ... but it still needs
a blacklist; it's governed by SBC which isn't ambiguous about the need
to support REPORT LUNS.  Now, if it supported RBC instead of SBC, that's
different; RBC also makes REPORT LUNS optional.  However, it is required
to indicate RBC support by being type 0xe.

> I wonder if the same sort of REPORT LUNS screw-up might apply to other
> ATAPI devices too, such as tape drives.  Since we've seen that
> manufacturers of CD-ROMs and removable disks don't implement it, it
> would not surprise me if the other ATAPI devices don't either.  But,
> that's speculation on my part.

James


