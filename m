Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269080AbUJERrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269080AbUJERrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269076AbUJERrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:47:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58775 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269120AbUJERqA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:46:00 -0400
Date: Tue, 5 Oct 2004 18:45:58 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Grant Grundler <iod00d@hp.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, "Luck, Tony" <tony.luck@intel.com>,
       Pat Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH] 2.6 SGI Altix I/O code reorganization
Message-ID: <20041005174558.GZ16153@parcelfarce.linux.theplanet.co.uk>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0221C647@scsmsx401.amr.corp.intel.com> <200410050843.44265.jbarnes@engr.sgi.com> <20041005162201.GC18567@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041005162201.GC18567@cup.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 09:22:01AM -0700, Grant Grundler wrote:
> pci_root_ops should be static. It's only intended for ACPI.

What I had intended when I wrote this code was that platforms that didn't
want to use the generic SAL code (and why not?  It doesn't seem like it
should be the hardest thing in the world to move your hacks into SAL)
was that people should override

  struct pci_raw_ops *raw_pci_ops = &pci_sal_ops;

by just assigning raw_pci_ops in their own code.  I haven't looked at
the SGI code yet, but this is how arch/i386/pci/direct.c (for example)
works.

> Maybe rename pci_root_ops to "acpi_pci_ops" would make that clearer.

No.  Don't rename it to anything ACPI specific.  It isn't.  It's just an
alternative route to access configuration space when you don't even
have a PCI bus, let alone a device.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
