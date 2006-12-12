Return-Path: <linux-kernel-owner+w=401wt.eu-S932487AbWLLWYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWLLWYd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWLLWYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:24:33 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:35299 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480AbWLLWYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:24:32 -0500
Message-ID: <457F2C1C.1030503@us.ibm.com>
Date: Tue, 12 Dec 2006 14:24:28 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Douglas Gilbert <dougg@torque.net>
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>	<4574B004.6030606@us.ibm.com>  <457D8637.5070707@garzik.org> <1165855489.2791.7.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1165855489.2791.7.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

> I thought we were closing in on agreeing that the SPC/MMC
> inconsistencies made this the correct candidate fix.

I tried out the patch below, but with it applied, SCSI still issues
REPORT LUNS to the device.  It seems that sdev->type = -1 and bflags = 0
when scsi_get_device_flags is called because the type code is not set up
until scsi_add_lun, which is called later.  In any case, the check
doesn't work for me because the SATAPI GoVault reports itself as a
Direct Access device, not a CD-ROM.

> diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
<snip>
> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
<empty>

Was there supposed to be more to this patch?

--D
