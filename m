Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbVLIMLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbVLIMLu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 07:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVLIMLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 07:11:49 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:60628 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932254AbVLIMLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 07:11:48 -0500
Date: Fri, 9 Dec 2005 12:11:25 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       randy_d_dunlap@linux.intel.com, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
Message-ID: <20051209121124.GA25974@srcf.ucam.org>
References: <20051208133945.GA21633@srcf.ucam.org> <1134050498.17102.2.camel@localhost.localdomain> <20051208141811.GB21715@srcf.ucam.org> <1134052433.17102.17.camel@localhost.localdomain> <20051208145257.GB21946@srcf.ucam.org> <20051208171901.GA22451@srcf.ucam.org> <20051209114246.GB16945@infradead.org> <20051209114944.GA1068@havoc.gtf.org> <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43997171.9060105@pobox.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 06:58:41AM -0500, Jeff Garzik wrote:

> If this is for hotswap, as I noted, libata doesn't need this at all.
> 
> If the hardware supports it, then libata will support it directly. 
> There is no ACPI-specific magic, because ACPI does nothing but talk to 
> the same hardware libata is talking to.

If libata knows how to talk to the random hardware attached to a Dell 
laptop hotswap bay, I'll be amazed. Ejecting the drive generates a 
system management interrupt, which then causes the ACPI code to check a 
register in a block of machine-specific registers and generate an ACPI 
notification. As far as I can tell, the controller has no say in the 
matter at all - the Intel specs seem to suggest that ICH6 doesn't 
generate a hotswap interrupt unless you're using AHCI (which this 
hardware doesn't).

So, as far as I can tell, there /is/ ACPI-specific magic on 
current-generation hardware. If we're lucky, they'll move to AHCI in 
future and implement things properly there - but I wouldn't count on it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
