Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163159AbWLGSJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163159AbWLGSJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163157AbWLGSJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:09:58 -0500
Received: from hancock.steeleye.com ([71.30.118.248]:45096 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163145AbWLGSJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:09:56 -0500
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <4574B004.6030606@us.ibm.com>
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>
	 <4574B004.6030606@us.ibm.com>
Content-Type: text/plain
Date: Thu, 07 Dec 2006 12:09:43 -0600
Message-Id: <1165514983.4698.21.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 15:32 -0800, Darrick J. Wong wrote:
> The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
> response to a REPORT LUNS packet.  If this happens to an ATAPI device
> that is attached to a SAS controller (this is the case with sas_ata),
> the device does not load because SCSI won't touch a "SCSI device"
> that won't report its LUNs.  Since most ATAPI devices don't support
> multiple LUNs anyway, we might as well fake a response like we do for
> ATA devices.

Actually, there may be a standards conflict here.  SPC says that all
devices reporting compliance with this standard (as the inquiry data for
this device claims) shall support REPORT LUNS.  On the other hand, MMC
doesn't list REPORT LUNS in its table of mandatory commands.

I'm starting to think that even if they report a SCSI compliance level
of 3 or greater, we still shouldn't send REPORT LUNS to devices that
return MMC type unless we have a white list override.

James


