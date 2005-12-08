Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVLHOno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVLHOno (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVLHOno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:43:44 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:4519 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932160AbVLHOnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:43:43 -0500
Date: Thu, 8 Dec 2005 14:43:29 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051208144329.GA21946@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org> <20051208091542.GA9538@infradead.org> <20051208132657.GA21529@srcf.ucam.org> <20051208133308.GA13267@infradead.org> <20051208133945.GA21633@srcf.ucam.org> <20051208135225.GA13122@havoc.gtf.org> <1134050863.17102.5.camel@localhost.localdomain> <43983FC6.6050108@pobox.com> <1134052257.17102.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134052257.17102.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 02:30:57PM +0000, Alan Cox wrote:

> SCSI/libata can go easily from ata channel to pci device to device. The
> rest of the logic belongs outside of scsi/libata.

ACPI methods belong to SATA/PATA targets, not PCI devices. The 
notification you get is something of the form

\SB.PCI.IDE0.SEC.MASTER

on sensible devices, and

\SB.C043.C438.C222.C223

on anything from HP[1]. Somehow, you have to get from there to a 
specific SCSI host and target. By far the easiest way of doing that is 
to register them at device add time, which needs a small amount of 
cooperation from the SCSI or libata layers. And to register the 
notifications in the first place, you need to know the ACPI handles.

[1] Thanks, HP
-- 
Matthew Garrett | mjg59@srcf.ucam.org
