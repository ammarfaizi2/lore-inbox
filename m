Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271269AbTHMAIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271266AbTHMAIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 20:08:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8395 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271269AbTHMAIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 20:08:42 -0400
Date: Wed, 13 Aug 2003 01:08:41 +0100
From: Matthew Wilcox <willy@debian.org>
To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <willy@debian.org>, jgarzik@pobox.com, davem@redhat.com,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813000841.GP10015@parcelfarce.linux.theplanet.co.uk>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost> <20030812023936.GE3169@parcelfarce.linux.theplanet.co.uk> <20030812053826.GA1488@kroah.com> <20030812112729.GF3169@parcelfarce.linux.theplanet.co.uk> <20030812180158.GA1416@kroah.com> <20030812235324.GA12953@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030812235324.GA12953@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 12:53:24AM +0100, Dave Jones wrote:
> What would be *really* nice, would be the ability to do something
> to the effect of..

While we're off in never-never land, it'd be nice to specify default
values for struct initialisers.  eg, something like:

struct pci_device_id {
        __u32 vendor = PCI_ANY_ID;
        __u32 device = PCI_ANY_ID;
        __u32 subvendor = PCI_ANY_ID;
	__u32 subdevice = PCI_ANY_ID;
        __u32 class = 0;
	__u32 class_mask = 0;
        kernel_ulong_t driver_data = 0;
};

Erm, hang on a second ...  Since when are PCI IDs 32-bit?  What is this
ridiculous bloat?  You can't even argue that this makes things pack
better since this packs equally well:

struct pci_device_id {
        __u16 vendor;
        __u16 device;
        __u16 subvendor;
        __u16 subdevice;     
        __u32 class;
        __u32 class_mask;
        kernel_ulong_t driver_data;
};

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
