Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbVLHODE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbVLHODE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVLHODE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:03:04 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23173 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932112AbVLHODC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:03:02 -0500
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <20051208133945.GA21633@srcf.ucam.org>
References: <20051208030242.GA19923@srcf.ucam.org>
	 <20051208091542.GA9538@infradead.org>
	 <20051208132657.GA21529@srcf.ucam.org>
	 <20051208133308.GA13267@infradead.org>
	 <20051208133945.GA21633@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 08 Dec 2005 14:01:38 +0000
Message-Id: <1134050498.17102.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-12-08 at 13:39 +0000, Matthew Garrett wrote:
> On Thu, Dec 08, 2005 at 01:33:08PM +0000, Christoph Hellwig wrote:
> 
> > Don't do it at all.  We don't need to fuck up every layer and driver for
> > intels braindamage.
> 
> Doing SATA suspend/resume properly on x86 depends on knowing the ACPI 
> object that corresponds to a host or target. It's also the only way to 
> support hotswap on this hardware[1], since there's no way for userspace 
> to know which device a notification refers to.
> 
> [1] ie, most laptops sold nowadays

Actually "most PC systems"

Nevertheless Christoph has a point even if its hidden behind a George
Bush approach to diplomacy. The scsi core directly shouldn't need to
know about ACPI or other arch specific PM systems. 

Something like  "pci_to_acpi(struct pcidev *)" belongs in arch specific
code even if we do add a generic "void * pm_device" type pointer to
struct pci_dev or struct device for such a purpose.

Alan

