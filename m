Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261582AbSKNTDj>; Thu, 14 Nov 2002 14:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbSKNTDj>; Thu, 14 Nov 2002 14:03:39 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64517 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261582AbSKNTDi>;
	Thu, 14 Nov 2002 14:03:38 -0500
Message-ID: <3DD3F523.4000601@pobox.com>
Date: Thu, 14 Nov 2002 14:10:27 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       mochel@osdl.org
Subject: Re: [PATCH] eliminate pci_dev name
References: <3DD3EB3D.8050606@pobox.com> <Pine.LNX.4.44.0211141031500.3323-100000@home.transmeta.com> <20021114184431.E30392@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <3DD3EB3D.8050606@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:

> On Thu, Nov 14, 2002 at 10:36:03AM -0800, Linus Torvalds wrote:
>
> >Actually, I think we should do the reverse (for testing), and make the
> >name be something small like 8 bytes, and make sure that everybody who
> >writes the name uses strncpy()  and snprintf() instead of just blindly
> >writing whatever is in the database.
> >
> >Otherwise we'll always end up having fragile magic constants.
> >
> >Anybody willing to do that cleanup?
>
>
> Sure, I can do that.  That leads me to think that maybe we should
> delete name from struct device and just use the one in struct kobject
> (which is already a mere 16 bytes).  But if we're going to go as far
> down as the kobject... that has a dentry.  And dentrys have names.
> So how about eliminating that too and just creating a dentry with the
> almost infinitely long name?



Remember that the names we are talking about here is the English 
descriptive name of the PCI device...  there is only _one_ need for 
these names:  /proc/pci

If there is going to be this much thought put into it (what a waste of 
brain cycles <g>), then let's just remove CONFIG_PCI_NAMES and the name 
field completely.  lspci prints them out from its own database anyway, 
and the only _real_ use is to provide descriptive names for devices in 
/proc/pci.  Why bother?  For existing code, just use pdev->slot_name 
instead, which is what happens anyway for hotplugged devices that appear 
after we drop the PCI name database during the __init phase.

Comments?

	Jeff



