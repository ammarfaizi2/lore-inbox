Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUJETBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUJETBP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUJETBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:01:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10399 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261405AbUJETBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:01:05 -0400
Message-ID: <4162EF65.4080108@sgi.com>
Date: Tue, 05 Oct 2004 14:00:53 -0500
From: Colin Ngam <cngam@sgi.com>
Reply-To: cngam@sgi.com
Organization: SSO
User-Agent: Mozilla/5.0 (X11; U; IRIX64 IP35; en-US; rv:1.4.1) Gecko/20040105
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>, Grant Grundler <iod00d@hp.com>
CC: Jesse Barnes <jbarnes@engr.sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com> <200410050843.44265.jbarnes@engr.sgi.com> <20041005162201.GC18567@cup.hp.com> <20041005174558.GZ16153@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041005174558.GZ16153@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

>On Tue, Oct 05, 2004 at 09:22:01AM -0700, Grant Grundler wrote:
>  
>
>>pci_root_ops should be static. It's only intended for ACPI.
>>    
>>
>
>What I had intended when I wrote this code was that platforms that didn't
>want to use the generic SAL code (and why not?  It doesn't seem like it
>should be the hardest thing in the world to move your hacks into SAL)
>was that people should override
>
>  struct pci_raw_ops *raw_pci_ops = &pci_sal_ops;
>
>by just assigning raw_pci_ops in their own code.  I haven't looked at
>the SGI code yet, but this is how arch/i386/pci/direct.c (for example)
>works.
>
Hi Matthew,

Yes, after looking at Grant's review/suggestion, we found that we can 
actually just use raw_pci_ops.  This will work well for us.  We have 
incoorporated this change.  No changes in pci/pci.c needed.

Thanks you for your information.

Thanks.

colin

>
>  
>
>>Maybe rename pci_root_ops to "acpi_pci_ops" would make that clearer.
>>    
>>
>
>No.  Don't rename it to anything ACPI specific.  It isn't.  It's just an
>alternative route to access configuration space when you don't even
>have a PCI bus, let alone a device.
>
>  
>


