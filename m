Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWBQUVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWBQUVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWBQUVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:21:54 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:44084 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1750904AbWBQUVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:21:53 -0500
To: Grant Grundler <iod00d@hp.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, Chris Wedgwood <cw@f00f.org>,
       Grant Grundler <grundler@parisc-linux.org>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-ia64@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Problems with MSI-X on ia64
X-Message-Flag: Warning: May contain useful information
References: <B8E391BBE9FE384DAA4C5C003888BE6F05BF610F@scsmsx401.amr.corp.intel.com>
	<20060217200454.GA24942@esmail.cup.hp.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 17 Feb 2006 12:21:37 -0800
In-Reply-To: <20060217200454.GA24942@esmail.cup.hp.com> (Grant Grundler's
 message of "Fri, 17 Feb 2006 12:04:54 -0800")
Message-ID: <aday809d9da.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 17 Feb 2006 20:21:38.0742 (UTC) FILETIME=[C1C7ED60:01C633FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BARs above 4G on i386 raise all sorts of issues.  I think Grant's
original patch (which changes phys_addr in drivers/pci/msi.c to
unsigned long) is correct as it stands, because the MSI code is going
to use that address to ioremap() the MSI-X table.  And the address
passed to ioremap is unsigned long anyway.

Some extension like ioremap_pfn() or something like that is going to
needed to handling giving the kernel access to BARs above 4G on 32-bit
archs.

 - R.
