Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbULOUfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbULOUfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbULOUfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:35:50 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:4770 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262441AbULOUfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:35:42 -0500
Subject: Re: How to add/drop SCSI drives from within the driver?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, brking@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
In-Reply-To: <20041215164851.GC31494@lists.us.dell.com>
References: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com>
	 <1102536081.4218.0.camel@localhost.localdomain>
	 <20041215072453.GB17274@lists.us.dell.com>
	 <20041215164851.GC31494@lists.us.dell.com>
Content-Type: text/plain
Organization: SteelEye Technology, inc.
Date: Wed, 15 Dec 2004 13:55:29 -0500
Message-Id: <1103136929.5232.8.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-15 at 10:48 -0600, Matt Domsch wrote:
> SCSI LLDDs don't show up in sysfs under /sys/bus/scsi/drivers at
> present, which is where, I think, you would want to put megaraid_mm
> with links to show the scsi_host and pci_dev associated with this
> adapter.  Something like this:
> 
> /sys
> |-- bus
> |   `-- drivers
> |       `-- scsi
> |           `-- megaraid_mm
> |               `-- adapter0
> |                   |-- pci_dev -> ../../../../../devices/pci0000:03/0000:03:06.0

Actually, there is a reason why this doesn't happen:  The drivers
directory shows only drivers belonging to a bus.  The megaraid_mm driver
is actually a PCI driver, and thus belongs to the PCI bus.  So, you'll
see this under

/sys/bus/pci/drivers/megaraid_mm/<pci_id>/host<n>

That should be sufficient to obtain all instances.  Note: the instances
aren't numerically indexed under this scheme (unlike your adapter<n>)
they'd be indexed by a unique pci_id.

So it looks like all the information is accessible today (if you look
for it in a slightly different way).  Is there anything currently
missing?

James


