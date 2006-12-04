Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967751AbWLDXNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967751AbWLDXNA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 18:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967752AbWLDXNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 18:13:00 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:39115 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967751AbWLDXM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 18:12:59 -0500
Message-ID: <4574AB78.40102@garzik.org>
Date: Mon, 04 Dec 2006 18:12:56 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata: Simulate REPORT LUNS for ATAPI devices when not supported
References: <4574A90E.5010801@us.ibm.com>
In-Reply-To: <4574A90E.5010801@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darrick J. Wong wrote:
> The Quantum GoVault SATAPI removable disk device returns ATA_ERR in
> response to a REPORT LUNS packet.  If this happens to an ATAPI device
> that is attached to a SAS controller (this is the case with sas_ata),
> the device does not load because SCSI won't touch a "SCSI device"
> that won't report its LUNs.  If we see this command fail, we should
> simulate a response that indicates the presence of LUN 0.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

I think the answer to this issue lies in the behavior of the majority of 
ATAPI devices when responding to REPORT LUNS.  Regardless of SAS or SATA 
or whatever bus the device is using.

ISTR that REPORT LUNS can make ATAPI devices croak, so it might be wise 
and more safe to simply simulate REPORT LUNS by default for all ATAPI 
devices.  Then readdress the issue if someone has a burning need to 
support the rare multi-LUN ATAPI devices.  I have one, but I'm not 
highly motivated to dig it out.

	Jeff





