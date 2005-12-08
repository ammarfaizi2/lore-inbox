Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVLHOOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVLHOOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 09:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVLHOOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 09:14:52 -0500
Received: from mail.dvmed.net ([216.237.124.58]:22952 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932131AbVLHOOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 09:14:49 -0500
Message-ID: <43983FC6.6050108@pobox.com>
Date: Thu, 08 Dec 2005 09:14:30 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Matthew Garrett <mjg59@srcf.ucam.org>,
       Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: RFC: ACPI/scsi/libata integration and hotswap
References: <20051208030242.GA19923@srcf.ucam.org>	 <20051208091542.GA9538@infradead.org>	 <20051208132657.GA21529@srcf.ucam.org>	 <20051208133308.GA13267@infradead.org>	 <20051208133945.GA21633@srcf.ucam.org>	 <20051208135225.GA13122@havoc.gtf.org> <1134050863.17102.5.camel@localhost.localdomain>
In-Reply-To: <1134050863.17102.5.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > On Iau, 2005-12-08 at 08:52 -0500,
	Jeff Garzik wrote: > >>On Thu, Dec 08, 2005 at 01:39:45PM +0000,
	Matthew Garrett wrote: >> >>>On Thu, Dec 08, 2005 at 01:33:08PM +0000,
	Christoph Hellwig wrote: >>> >>> >>>>Don't do it at all. We don't need
	to fuck up every layer and driver for >>>>intels braindamage. >>>
	>>>Doing SATA suspend/resume properly on x86 depends on knowing the
	ACPI >>>object that corresponds to a host or target. >> >>Not true. > >
	> > Actually he is right. You have to know the ACPI object in order to
	run > the _GTM/_STM etc functions. If you don't run those your
	suspend/resume [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2005-12-08 at 08:52 -0500, Jeff Garzik wrote:
> 
>>On Thu, Dec 08, 2005 at 01:39:45PM +0000, Matthew Garrett wrote:
>>
>>>On Thu, Dec 08, 2005 at 01:33:08PM +0000, Christoph Hellwig wrote:
>>>
>>>
>>>>Don't do it at all.  We don't need to fuck up every layer and driver for
>>>>intels braindamage.
>>>
>>>Doing SATA suspend/resume properly on x86 depends on knowing the ACPI 
>>>object that corresponds to a host or target.
>>
>>Not true.
> 
> 
> 
> Actually he is right. You have to know the ACPI object in order to run
> the _GTM/_STM etc functions. If you don't run those your suspend/resume

These are only for PATA.  We don't care about _GTM/_STM on SATA.

Further, SATA completely resets and re-initializes the device as if from 
a hardware reset (except on ata_piix, which doesn't support COMRESET, 
and PATA).  This makes _GTF uninteresting, as well.


> may not work, may corrupt and so on. The only safe alternative is to
> disable acpi which, while it would have been a good idea before the spec
> ever got out, is a bit late now.

suspend/resume works just fine with Jens' out-of-tree patch.


> If you don't run the resume methods your disk subsystem status after a
> resume is simply undefined and unsafe.

I initialize the hardware to a defined state.

	Jeff


