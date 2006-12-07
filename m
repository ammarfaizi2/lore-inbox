Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163213AbWLGTNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163213AbWLGTNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163205AbWLGTNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:13:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34416 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163204AbWLGTNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:13:41 -0500
Message-ID: <457867C5.7060508@torque.net>
Date: Thu, 07 Dec 2006 14:13:09 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: "Darrick J. Wong" <djwong@us.ibm.com>, Jeff Garzik <jeff@garzik.org>,
       linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] libata: Simulate REPORT LUNS for ATAPI devices
References: <4574A90E.5010801@us.ibm.com> <4574AB78.40102@garzik.org>	 <4574B004.6030606@us.ibm.com> <1165514983.4698.21.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1165514983.4698.21.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Mon, 2006-12-04 at 15:32 -0800, Darrick J. Wong wrote:
>> The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
>> response to a REPORT LUNS packet.  If this happens to an ATAPI device
>> that is attached to a SAS controller (this is the case with sas_ata),
>> the device does not load because SCSI won't touch a "SCSI device"
>> that won't report its LUNs.  Since most ATAPI devices don't support
>> multiple LUNs anyway, we might as well fake a response like we do for
>> ATA devices.
> 
> Actually, there may be a standards conflict here.  SPC says that all
> devices reporting compliance with this standard (as the inquiry data for
> this device claims) shall support REPORT LUNS.  On the other hand, MMC
> doesn't list REPORT LUNS in its table of mandatory commands.

MMC-5 rev 4 section 7.1:
"Some commands that may be implemented by MM drives are
not described in this standard, but are found in other
SCSI standards. For a complete list of these commands
refer to [SPC-3]."

Hmm, "may be implemented" yet REPORT LUNS is mandatory
in SPC-3 (and SPC-3 is a normative reference for MMC-5).
I guess there is wriggle room there.
In practice, MMC diverges from SPC a lot more than other
SCSI device type command sets (e.g. SBC and SSC).

> I'm starting to think that even if they report a SCSI compliance level
> of 3 or greater, we still shouldn't send REPORT LUNS to devices that
> return MMC type unless we have a white list override.

There is also SAT compliance. For the ATA command set (i.e.
disks) sat-r09 lists REPORT LUNS and refers to SPC-3. For
ATAPI sat-r09 is far less clear. It does recommend, for
example, that the ATA Information VPD pages is implemented
in the SATL for ATAPI devices.

Doug Gilbert
